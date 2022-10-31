module Internal
  def self.read_ruby(file)
    # TODO write a ruby script that'll list and sort all files so they can be read
    `
fetch('medias/rubies/'+#{file})
  .then(response => response.text())
  .then(text => Opal.eval(text))
`
  end

  def self.read_text(file)
    `
fetch('medias/rubies/'+#{file})
  .then(response => response.text())
  .then(text => console.log(text))
`
  end

  def text_data(value)
    @html_object.text = value
  end

  def animator_data(value)
    puts "send params to animation engine#{value}"
  end

  def _data(value)
    #dummy method to handle atome with no type
  end

  def html_drag_helper(atome, options, parent = nil)
    drag_id = atome.id
    options[:max] = options[:max].to_n
    `current_obj = Opal.Utilities.$grab(#{drag_id})`

    `interact('.'+#{drag_id})
            .draggable({
                // enable inertial throwing
               // startAxis: 'y',
               // lockAxis: 'x',
               lockAxis: #{options[:lock]},
                inertia: true,
                // keep the element within the area of it's parent
                modifiers: [
                    interact.modifiers.restrictRect({
                        //restriction: 'parent',
                        //restriction: { left: 333 ,right: 90, top: 333, bottom: 30},
                        restriction: #{options[:max]},

//elementRect: { left: , right: 0, top: 1, bottom: 1 }
                        // endOnly: true,
                    }),

                ],
                // enable autoScroll
                autoScroll: true,

                listeners: {
                    // call this function on every dragmove event

                    // move: dragMoveListener,
                    move: dragMoveListener,
                    // move(event){
                    //     console.log('current atome is: '+self.current_obj)
                    // },
                    start(event) {
                    bloc=#{atome.bloc}
//TODO:  optimise this passing the proc to the drag callback
                        // lets get the current atome Object
                        // self.current_obj = Opal.Utilities.$grab(atome_drag_id)
                        // now get the grab proc
                        //self.proc_meth = current_obj.bloc
                    },
                    // call this function on every dragend event
                    end(event) {

                    }
                }
            })
`

    if options[:fixed]
      `
 function allow_drag(target,x,y){

  }
  `
    else
      `
 function allow_drag(target,x,y){
       target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'
    // update the position attributes
    target.setAttribute('data-x', x)
    target.setAttribute('data-y', y)
  }
  `
    end

    `
function dragMoveListener(event) {
    const target = event.target
    // the code below can be conditioned to receive the drag event without moving the object
    // keep the dragged position in the data-x/data-y attributes
    const x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
    const y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
    // translate the element
      allow_drag(target,x,y)
    // CallBack here
    var object_dragged_id=Opal.Utilities.$grab(target.id)
    #{atome}.$dragCallback(event.pageX, event.pageY, event.rect.left, event.rect.top, #{atome},object_dragged_id, bloc);
}
`
  end

  def drag_remove_true(current_atome)
    current_atome.target.each do |value|
      atome_found = grab(value)
      # we get the id of the drag and ad add it as a html class to all children so they become draggable
      # atome_found.html_object.remove_class(id)
      atome_found.html_object.remove_class(current_atome.id)
    end
  end

  def shape_remove_drag(atome)
    class_to_remove = atome.drag.id
    atome.html_object.remove_class(class_to_remove)
  end

  def dragCallback(page_x, page_y, x, y, current_object, object_dragged_id, proc = nil)
    dragged_atome = grab(object_dragged_id.id)
    dragged_atome.instance_variable_set('@left', x)
    dragged_atome.instance_variable_set('@top', y)
    current_object.instance_exec({ x: page_x, y: page_y }, &proc) if proc.is_a?(Proc)
  end

  def constraint_helper(params, current_atome, option)
    options = {}
    current_atome.particles.each do |particle, value|
      options[particle] = value if (particle != :id && particle != :render && particle != :child && particle != :html_type && particle != :type && particle != :html_object && particle != :target)
    end
    options = options.merge({ option => params[:value] })
    current_atome.target.each do |value|
      atome_found = grab(value)
      # we get the id of the drag and ad add it as a html class to all children so they become draggable
      atome_found.html_object.remove_class(current_atome.id)
      atome_found.html_object.add_class(current_atome.id)
      html_drag_helper(current_atome, options)
    end
  end

  def html_decision(html_type, value, id)
    case html_type
    when :style
      # remove previous class if the are of the same type of the type, example:
      # if there's a color already assign we remove it to allow the new one to be visible
      # comment / uncomment below if we need to remove class or not
      html_parent = grab(value).instance_variable_get("@html_object")
      html_parent.class_names.each do |class_name|
        if $document[class_name] && $document[class_name].attributes[:atome]
          class_to_remove = $document[class_name].attributes[:id]
          html_parent.remove_class(class_to_remove)
        end
      end
      $document[value].add_class(id)
    when :unset
    else
      @html_object.append_to($document[value])
    end

  end

  def color_sanitizer(params, atome)
    unless params.instance_of? Hash
      if RUBY_ENGINE.downcase == 'opal'
        rgb_color = `d = document.createElement("div");
	d.style.color = #{params};
	document.body.appendChild(d)
   rgb_color=(window.getComputedStyle(d).color);
d.remove();
`
        color_converted = { red: 0, green: 0, blue: 0, alpha: 1 }
        rgb_color.gsub("rgb(", "").gsub(")", "").split(",").each_with_index do |component, index|
          color_converted[color_converted.keys[index]] = component.to_i / 255
        end
      else
        rgb_color = Color::CSS["red"].css_rgb
        color_converted = { red: 0, green: 0, blue: 0, alpha: 1 }
        rgb_color.gsub("rgb(", "").gsub(")", "").gsub("%", "").split(",").each_with_index do |component, index|
          component = component.to_i / 100
          color_converted[color_converted.keys[index]] = component
        end
      end
      params = { render: [:html], id: "color_#{atome.id}", type: :color }.merge(color_converted)
    end

    params
  end

end