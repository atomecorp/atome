module PropertylHtml
  def content_html(value)
    value = value.read
    if render
      if type == :text
        value = value.to_s.gsub("\n", "<br>")
        jq_get(atome_id).html(value)
        jq_get(atome_id).css("background-color", "transparent")
        jq_get(atome_id).css("background-image", "url()")
        jq_get(atome_id).css("color", color)
      elsif type == :shape
        jq_get(atome_id).html("")
        jq_get(atome_id).css("background-color", color)
        if value[:tension]
          self.smooth(value[:tension])
        end
      elsif type == :video
        jq_get(atome_id).html("")
        video_creator__helper(value)
      elsif type == :image
        jq_get(atome_id).css("background-color", "transparent")
        image_creator__helper(value)
        jq_get(atome_id).html("")
      end
    end
  end
end