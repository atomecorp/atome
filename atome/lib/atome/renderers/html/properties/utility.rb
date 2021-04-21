module PropertyHtml
  def render_html(value)
    if value
      jq_get(atome_id).remove
      jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
      properties_found = self.properties
      properties_found.delete(:render)
      # fixme "attention the filter are re applied at each render : \n#{properties_found}"
      properties_found.each do |property, value_found|
        self.send(property, value_found)
      end
    else
      jq_get(atome_id).remove
    end
  end

  def language_html(value)
    value
  end

  def preset_html(value)
    value
  end

  def edit_html(value)
    if value == true
      jq_get(atome_id).attr("contenteditable", "true")
      jq_get(atome_id).css("-webkit-user-select", "text")
      jq_get(atome_id).css("-khtml-user-select", "text")
      jq_get(atome_id).css("-moz-user-select", "text")
      jq_get(atome_id).css("-o-user-select", "text")
      jq_get(atome_id).css("user-select: text", "text")
    elsif value == false
      jq_get(atome_id).attr("contenteditable", "false")
      jq_get(atome_id).css("-webkit-user-select", "none")
      jq_get(atome_id).css("-khtml-user-select", "none")
      jq_get(atome_id).css("-moz-user-select", "none")
      jq_get(atome_id).css("-o-user-select", "none")
      jq_get(atome_id).css("user-select: text", "none")
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

  def select_html(value)
    if value == :destroy
      jq_get(atome_id).selectable(:destroy)
    elsif value == :disable
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

  def previous_filer_found
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

end