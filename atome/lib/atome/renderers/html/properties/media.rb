module PropertyHtml
  def content_html(value="")
    if render
      if type == :text
        value = value.to_s.gsub("\n", "<br>")
        # FIXME:children are deleted,  we must preserve them when setting html content
        jq_get(atome_id).html(value)
        jq_get(atome_id).css("background-color", "transparent")
        jq_get(atome_id).css("background-image", "url()")
        jq_get(atome_id).css("color", color)
      elsif type == :shape
        jq_get(atome_id).css("background-color", color)
        if value[:tension]
          self.smooth(value[:tension])
        end
      elsif type == :video
        video_creator_helper(value)
      elsif type == :camera
        alert "camera found"
        # video_creator_helper(value)
      elsif type == :image
        jq_get(atome_id).css("background-color", "transparent")
        image_creator__helper(value)
      end
    end
  end
end