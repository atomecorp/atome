module PropertyHtml
  def render_html(value)
    if value
      jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
      properties_found = self.properties
      properties_found.delete(:render)
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

    jq_get(atome_id).keyup do
      content = jq_get(atome_id).html.gsub("<br>", "\n").gsub("<div>", "\n").gsub("</div>", "").delete(";").gsub("&nbsp", " ")
      content(content, false)
    end
  end
end