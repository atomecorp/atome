module PropertyHtml
  def content_html(value = "", type_mutation = false)
    if render
      if type == :text
        value = value.to_s.gsub("\n", "<br>")
        if type_mutation
          # we use the color scheme of the color method to display the text correctly
          self.color(color)
        end
        # FIXME:children are deleted,  we must preserve them when setting html content
        # jq_get(atome_id).html(value)
        jq_get(atome_id).html(value+jq_get(atome_id).html)
      elsif type == :shape
        if type_mutation
          jq_get(atome_id).css("-webkit-background-clip", "padding")
          jq_get(atome_id).css("background-color", color)
        end
        if value[:tension]
          self.smooth(value[:tension])
        end
      elsif type == :video
        video_creator_helper(value)
      elsif type == :audio
        audio_creator_helper(value)
      elsif type == :camera
        camera_creator_helper(value)
      elsif type == :image
        image_creator_helper(value)
        if type_mutation
          jq_get(atome_id).css("background-color", "transparent")
        end
      end
    end
  end
end