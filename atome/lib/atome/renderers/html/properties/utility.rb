module PropertyHtml

  def render_list(value)
    atome_parent = parent[0].q_read
    jq_get(atome_parent).append(jq_get(atome_id))
    temp_list_obj_id = "#{atome_id}_temp_list_obj"
    grab(temp_list_obj_id)&.delete(true)
    i = 0
    list_width = 666
    list_height = 30
    x_offset = 6
    y_offset = 30
    back_color = { red: 0, green: 0, blue: 0, alpha: 0.3 }
    line_color_0 = { red: 0.3, green: 0.3, blue: 0.3, alpha: 0.6 }
    line_color_1 = { red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3 }
    text_color = :orange
    list = grab(:view).box({ atome_id: temp_list_obj_id, width: 333, height: 333, x: self.x, y: self.y, scale: true, overflow: :auto, color: back_color, blur: { value: 9, invert: true }, shadow: { bounding: true, x: 0, y: 0, blur: 15, thickness: 0, invert: false }, drag: true })

    case value[:list]
    when :property
      # todo "use list method here "
      properties.each_with_index do |property, index|
        # en,color: line_color, height: list_height-list_height/4, width: 666, y: (list_height  * i)+x_offset,text: {center: :y,overflow: :auto,visual: 12, content: "#{property} : #{data}", color: text_color, width: :auto, x: x_offset }  })
        line_color = if (index % 2 == 0)
                       line_color_0
                     else
                       line_color_1
                     end
        # alert color_to_use
        line = list.box({ overflow: :hidden, color: line_color, height: list_height, width: 666, y: (list_height * i) + y_offset })
        line.text({ center: :y, overflow: :auto, visual: 12, content: "#{property[0]} : #{property[1]}", color: text_color, width: :auto, x: x_offset })

        i += 1
      end
    when :child
      child.each do |property|
        alert "msg from utility.rb render list : #{property}"
      end
    else
      child.each do |property|
        # we exclude the list from the list of the child
        unless property.atome_id == temp_list_obj_id
          prop = property.to_h
          prop.delete(:parent)
          prop_type = prop.delete(:type)
          display_size = 30
          y_position = 33 * i
          x_offset = 3
          visual = {}
          options = value[:visualize]
          visual_found = options.include?(:visual)
          if visual_found
            visual = { prop_type => prop.merge({ size: display_size, y: 0, x: x_offset }) }
          end
          infos_collected = []
          options.each do |option|
            unless option == :visual
              infos_collected << "#{option} : #{property.send(option)}"
            end
          end
          infos = { content: infos_collected.join(" , "), x: x_offset * 2 + display_size, color: text_color }
          line = list.box({ overflow: :scroll, color: :gray, height: list_height, width: list_width, y: y_position, visual: 15 }.merge(visual))
          line.text(infos)
          i += 1
        end

      end
    end
  end

  def render_html(value)
    properties_found = self.properties
    # the line below remove the render from the list of properties to avoid infinite loop

    # first in any case we remove the atome if it already exist
    jq_get(atome_id).remove

    # we also remove pseudo element: (the one created when using different rendering type : list, bloc, ...)
    temp_list_obj_id = "#{atome_id}_temp_list_obj"
    grab(temp_list_obj_id)&.delete(true)
    puts "render_html : #{atome_id} #{value}"
    # now we created the atome
    jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
    if value[:value] == false
      jq_get(atome_id).remove
    elsif value[:value] == true

      if parent
        parent.each do |parent_found|
          jq_get(parent_found.atome_id).append("<div class='atome' id='#{atome_id}'></div>")
        end
      end
      properties_found.delete(:render)
      properties_found.each do |property, value_found|
        self.send(property, value_found)
      end
    elsif value[:mode] == :list
      render_list(value)
    elsif value[:mode] == :bloc
      # todo
    else
      # # natural mode
      # # we render the object in natural mode
      #     # fixme "attention the filter are re applied at each render : \n#{properties_found}"
      #     properties_found.each do |property, value_found|
      #       self.send(property, value_found)
      #     end
    end

    # if  value[:value]=false
    #   alert :poi
    #   jq_get(atome_id).remove
    # end
    # jq_get(atome_id).remove

    # if parent && value.instance_of?(Hash)
    #   # puts "render_html :  #{atome_id}"
    #
    # else
    #   # jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
    # end

    # properties_found = self.properties

    # if value == true
    #   # we render the object in natural mode
    #   # fixme "attention the filter are re applied at each render : \n#{properties_found}"
    #   properties_found.each do |property, value_found|
    #     self.send(property, value_found)
    #   end
    # elsif
    # if value.instance_of?(Hash)
    #   # the object will be render in other mode could be list , bloc , spoken , etc...
    #   # puts "render_html #{atome_id}, #{value}"
    #   # case value
    #   # when ->(h) { h[:value] == true }
    #   #   jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
    #   #   properties_found = self.properties
    #   #   # properties_found.delete(:render)
    #   # when ->(h) { h[:value] == false }
    #   #   jq_get(atome_id).remove
    #   #   else
    #   # end

    ###############@ copy and get code below ##############
    # puts "render_html for list :  #{value}"
    #   case value[:mode]
    #   when :list
    #     render_list(value)
    #   when :bloc
    #     # todo
    #   else
    #     # we render the object in natural mode
    #     # fixme "attention the filter are re applied at each render : \n#{properties_found}"
    #     properties_found.each do |property, value_found|
    #       self.send(property, value_found)
    #     end
    #   end
    # end
    nil unless value
    # end
  end

  def language_html(value)
    value
  end

  def edit_html(value)
    case value
    when ->(h) { h[:value] == true }
      jq_get(atome_id).attr("contenteditable", "true")
      jq_get(atome_id).css("-webkit-user-select", "text")
      jq_get(atome_id).css("-khtml-user-select", "text")
      jq_get(atome_id).css("-moz-user-select", "text")
      jq_get(atome_id).css("-o-user-select", "text")
      jq_get(atome_id).css("user-select: text", "text")
      # bind key to save the content
      jq_get(atome_id).on(:keyup) do
        new_content = jq_get(atome_id).html
        new_content = new_content.gsub("<br>", "\n").gsub("</div>", "").gsub("<div>", "\n")
        current_language = self.language || grab(:view).language
        @content = atomise(:content, { current_language => new_content })
      end

    when ->(h) { h[:value] == false }
      jq_get(atome_id).attr("contenteditable", "false")
      jq_get(atome_id).css("-webkit-user-select", "none")
      jq_get(atome_id).css("-khtml-user-select", "none")
      jq_get(atome_id).css("-moz-user-select", "none")
      jq_get(atome_id).css("-o-user-select", "none")
      jq_get(atome_id).css("user-select: text", "none")
      # unbind keypress
      jq_get(atome_id).unbind("keypress")
    else
      # type code here
    end
  end

  def record_html(params)
    if params == :stop
      jq_get(atome_id).unbind(:mousemove)
      jq_get(atome_id).unbind(:mousedown)
      jq_get(atome_id).unbind(:mouseup)
      jq_get(atome_id).unbind(:touchmove)
      jq_get(atome_id).unbind(:touchstart)
      jq_get(atome_id).unbind(:touchend)
      ATOME.resize_html(:false)
    else
      jq_get(atome_id).on(:mousemove) do |evt|
        proc = params[:proc]
        proc.call(evt) if proc.is_a?(Proc)
      end
    end
  end

  def selection_html
    selected_items = Element['.ui-selected']
    collected_items = []
    selected_items.each do |jq_atome|
      collected_items << jq_atome.id
    end
    ATOME.atomise(:batch, collected_items)
  end

  def selectable_html(value)
    case value
    when :destroy
      jq_get(atome_id).selectable(:destroy)
    when :disable
      jq_get(atome_id).selectable(:disable)
    else
      proc = value[:proc]
      jq_get(atome_id).selectable
      jq_get(atome_id).on(:selectablestop) do |evt|
        proc.call(evt) if proc.is_a?(Proc)
      end
    end
  end

  def convert_html(property)
    property = property.to_sym
    case property
    when :width
      jq_get(atome_id).width
    when :height
      jq_get(atome_id).height
    else
      [jq_get(atome_id).width, jq_get(atome_id).height]
    end
  end

  def previous_filter_found
    filter = jq_get(atome_id).css('filter')
    if filter == "none"
      prev_prop = ""
    else
      filters = filter.split(")")
      collected_filter = []
      filters.each do |filer_found|
        if filer_found.start_with?(" drop-shadow")
          collected_filter << filer_found
        end
      end
      collected_filter = collected_filter.join(")")
      prev_prop = "#{collected_filter} "
    end
    prev_prop
  end

  def pay_html(link)
    JSUtils.pay(atome_id, link)
  end

  def code_html(code)
    JSUtils.load_opal_parser
    Object.compile(code)
  end

  def exec_html(params)
    if params
      JSUtils.load_opal_parser
      Object.compile(content)
    end
  end

  def cursor_html(params)
    jq_get(atome_id).css('cursor', params)
  end

  def slider_html(params)
    JSUtils.slider(atome_id, params)
  end

  def list_html(params)

    generated_atome_id = if params[:atome_id]
                           { atome_id: params[:atome_id] }
                         else
                           {}
                         end
    list_box = box({ width: params[:width], height: params[:height], overflow: :auto }.merge(generated_atome_id))
    list_box.color("rgb(66,66,66)")
    list_box.shadow(true)
    line_height = params[:line][:height]
    params[:content].each_with_index do |line_content, index|
      line = list_box.text(line_content[:value])
      line.x(line_height / 2)
      line.y(line_height * index + line_height / 2)
      line.visual(line_height / 1.5)
    end
    list_box
  end
end
