module PropertyHtml

  def render_list(value)
    atome_parent = parent[0].q_read
    jq_get(atome_parent).append(jq_get(atome_id))
    temp_list_obj_id = "#{atome_id}_temp_list_obj"
    grab(temp_list_obj_id).delete
    i = 0
    list_width = 666
    list_height = 30
    x_offset = 9
    back_color = { red: 0, green: 0, blue: 0, alpha: 0.3 }
    line_color = { red: 0, green: 0, blue: 0, alpha: 0.3 }
    text_color = :orange
    list = box({ atome_id: temp_list_obj_id, width: 333, height: 333, x: self.x, y: self.y, scale: true, overflow: :auto, color: back_color,  shadow: {bounding: true} })
    case value[:list]
    when :property
      properties.each do |property, data|
        list.box({overflow: :auto,color: line_color, scale: true,height: list_height, width: "100%", y: ((list_height + x_offset) * i)+x_offset,text: {overflow: :auto,visual: 12, content: "#{property} : #{data}", color: text_color, width: :auto, x: x_offset }  })
        # list.box({ overflow: :scroll, color: line_color, height: list_height, width: "100%", scale: true, y: (list_height + x_offset) * i, text: {visual: 12, content: "#{property} : #{data}", color: text_color, width: :auto, center: true, x: x_offset } })
        i += 1
      end
    when :child
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
          line = list.box({ overflow: :scroll, color: line_color, height: list_height, width: list_width, y: y_position }.merge(visual))
          line.text(infos)
          i += 1
        end

      end
    end

  end

  def render_html(value)

    # first in any case we remove the atome if it already exist
    jq_get(atome_id).remove
    # we also remove pseudo element: (the one created when using different rendering type : list, bloc, ...)
    temp_list_obj_id = "#{atome_id}_temp_list_obj"
    grab(temp_list_obj_id).delete
    if value
      jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
      properties_found = self.properties
      properties_found.delete(:render)
      if value == true
        # we render the object in natural mode
        # fixme "attention the filter are re applied at each render : \n#{properties_found}"
        properties_found.each do |property, value_found|
          self.send(property, value_found)
        end
      elsif value.instance_of?(Hash)
        # the object will be render in other mode could be list , bloc , spoken , etc...
        case value[:mode]
        when :list
          render_list(value)
        when :bloc
          # todo
        else
          puts "no rendering"
        end
      end
      nil unless value
    end
  end

  def language_html(value)
    value
  end

  def edit_html(value)
    case value
    when true
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

    when false
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
  def  slider_html(params)
    JSUtils.slider(atome_id, params)
  end

end
