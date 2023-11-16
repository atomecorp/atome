# In the context of the Atome framework, when you provide code, debug, or give examples, in fact, whenever there are comments in the code, please always write these comments in English.

# here how to use a callback between ruby and javascript with binding and unbinding :

# example with the over method
# the method below add an event listener and trig the code found in the @original_atome.over_code[:enter]
def over_enter(_option)
  @over_enter = @original_atome.instance_variable_get('@over_code')[:enter]
  return unless @over_enter
  @over_enter_callback = lambda do |event|
    @original_atome.instance_exec(event, &@over_enter) if @over_enter.is_a? Proc
  end
  @element.addEventListener('mouseenter', @over_enter_callback)

end

# you can unbind using the method below
def remove_over_enter(_option)
  return unless @over_enter_callback
  # Remove the event listener using the same lambda
  @element.removeEventListener('mouseenter', @over_enter_callback)
  @over_enter_callback = nil
  @over_enter = nil

end

# please note that in the HTML class instance @element is always the current HTML object and is always define
# You forget every time - one should never suggest using backticks to interpolate JS code. How can you integrate this?

# Here is how to use direct JavaScript methods in a Ruby environment:

# Remember that you can use a variety of JavaScript methods without resorting to eval. For instance, for an EventListener:

@element.addEventListener('mouseleave', lambda do |event|
  @original_atome.instance_exec('my_params', &@over_leave) if @over_leave.is_a?(Proc)
end)
# Or for appending a child:

def append_to(parent_id_found)
  parent_found = JS.global[:document].getElementById(parent_id_found.to_s)
  parent_found.appendChild(@element)
  self
end

# These examples demonstrate the integration of JavaScript functionality in a Ruby environment,
# allowing for the use of JavaScript methods and events directly.

# Here is an example of a callback when used with the over particle:

def over_leave(_option)
  @over_leave = @original_atome.over_code[:leave]
  @element.addEventListener('mouseleave', lambda do |event|
    @original_atome.instance_exec(event, &@over_leave) if @over_leave.is_a?(Proc)
  end)
end

# This is also important because callbacks are often used. Try to remember this

# Here is a series of examples of basic methods for you to understand how use JavaScript from Ruby
# this example of callback is true when we have to deal with interoperability between ruby and javascript

class HTML

  def initialize(id_found, current_atome)
    @element ||= JS.global[:document].getElementById(id_found.to_s)
    @id = id_found
    @original_atome = current_atome
  end

  def attr(attribute, value)
    @element.setAttribute(attribute.to_s, value.to_s)
    self
  end

  def add_class(class_to_add)
    @element[:classList].add(class_to_add.to_s)
    self
  end

  def id(id)
    attr('id', id)
    self
  end

  # to create a html div or H1 or any other tag  the tag is found in the @original_atome.markup instance variable
  def shape(id)
    #
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :div
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  # below here is how to create various html tag
  def text(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :pre
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  def image(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :img
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)
    self
  end

  def video(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :video
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)
    self
  end

  def www(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :iframe
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    @element.setAttribute('src', 'https://www.youtube.com/embed/lLeQZ8Llkso?si=MMsGBEXELy9yBl9R')
    # below we get image to feed width and height if needed
    # image = JS.global[:Image].new
    self.id(id)
    self
  end

  def svg(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || 'svg'
    @element_type = markup_found.to_s
    svg_ns = "http://www.w3.org/2000/svg"
    @element = JS.global[:document].createElementNS(svg_ns, "svg")
    JS.global[:document][:body].appendChild(@element)
    @element.setAttribute('viewBox', '0 0 1024 1024')
    @element.setAttribute('version', '1.1')
    add_class('atome')
    self.id(id)
    self
  end

  def svg_data(data)
    data.each do |type_passed, datas|
      svg_ns = "http://www.w3.org/2000/svg"
      new_path = JS.global[:document].createElementNS(svg_ns.to_s, type_passed.to_s)
      JS.global[:document][:body].appendChild(new_path)
      datas.each do |property, value|
        new_path.setAttribute(property.to_s, value.to_s)
      end
      @element.appendChild(new_path)
    end
  end

  def update_svg_data(data)
    data.each do |type_passed, datas|
      element_to_update = JS.global[:document].getElementById(type_passed.to_s)
      datas.each do |property, value|
        element_to_update.setAttribute(property.to_s, value.to_s)
      end
    end
  end

  def colorize_svg_data(data)
    command = <<-JS
       let svgElement = document.getElementById("#{@id}");
      if (!svgElement) {
        return [];
      }
      var children = svgElement.children;
      var ids = [];
      for (var i = 0; i < children.length; i++) {
        var element = document.getElementById(children[i].id); // Récupérer l'élément par son ID
        if (element) {
            element.setAttribute('fill', '#{data}'); // Modifier l'attribut fill
            element.setAttribute('stroke', '#{data}'); // Modifier l'attribut stroke
        }
        ids.push(children[i].id);
      }
  return ids
    JS
    JS.eval(command)
  end

  def raw_data(html_string)
    @element[:innerHTML] = html_string
  end

  def video_path(video_path, type = 'video/mp4')
    source = JS.global[:document].createElement('source')
    source.setAttribute('src', video_path)
    source.setAttribute('type', type)
    @element.appendChild(source)
  end

  def sanitize_text(text)
    text.to_s
        .gsub('&', '&amp;')
        .gsub('<', '&lt;')
        .gsub('>', '&gt;')
        .gsub('"', '&quot;')
        .gsub("'", '&apos;')
  end

  def innerText(data)
    sanitized_data = sanitize_text(data.to_s)
    @element[:innerText] = sanitized_data
  end

  def textContent(data)
    @element[:textContent] = data
  end

  def path(objet_path)
    @element.setAttribute('src', objet_path)
    # below we get image to feed width and height if needed
    # image = JS.global[:Image].new
    @element[:src] = objet_path
    @element[:onload] = lambda do |_event|
      @element[:width]
      @element[:height]
    end
  end

  def transform(property, value = nil)
    transform_needed = "#{property}(#{value}deg)"
    @element[:style][:transform] = transform_needed.to_s
  end

  def style(property, value = nil)
    if value
      @element[:style][property] = value.to_s
    elsif value.nil?
      @element[:style][property]
    else
      # If value is explicitly set to false, remove the property
      command = "document.getElementById('#{@id}').style.removeProperty('#{property}')"
      JS.eval(command)
    end
  end

  def filter(property, value)
    filter_needed = "#{property}(#{value})"
    @element[:style][:filter] = filter_needed
  end

end


