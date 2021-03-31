module PropertylHtml
  def render_html(value)
    #alert "atome_id : #{value}"
    value = value.read
    if value
      #alert atome_id
      #content_html(content)
      #jq_get(atome_id).html(value)
      #jq_get(atome_id).remove
      #jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
      #atome_content= value
      #atome_type= type
      #alert "#{atome_id} #{atome_content} #{atome_type}"
      jq_get("user_device").append("<div class='atome' id='#{atome_id}'></div>")
      properties_found=self.properties
      properties_found.delete(:render)

      properties_found.each do |property, value_found|
        #if  atome_id==:intuition
        #  alert "#{property},#{value}"
        #end
        self.send(property,value_found)
      end

      #  jq_get(atome_id).html(value)
    #  if type == :text
    #    value = value.to_s.gsub("\n", "<br>")
    #    jq_get(atome_id).html(value)
    #    jq_get(atome_id).css("background-color", "transparent")
    #    jq_get(atome_id).css("background-image", "url()")
    #    jq_get(atome_id).css("color", color)
    #  elsif type == :shape
    #    jq_get(atome_id).html("")
    #    jq_get(atome_id).css("background-color", color)
    #    if value[:tension]
    #      self.smooth(value[:tension])
    #    end
    #  elsif type == :video
    #    jq_get(atome_id).html("")
    #    video_creator__helper(value)
    #  elsif type == :image
    #    jq_get(atome_id).css("background-color", "transparent")
    #    image_creator__helper(value)
    #    jq_get(atome_id).html("")
    #  end
    else
      jq_get(atome_id).remove
    end
  end

  def language_html(value)
    value.read
  end

  def preset_html(value)
    value.read
  end

  def edit_html(value)
    value = value.read
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