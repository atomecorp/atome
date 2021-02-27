module MediaHtml
  def content_html(value)
    value = value.read
    value = value.to_s.gsub("\n", "<br>")
    if type == :text
      jq_get(atome_id).html(value)
    elsif type == :video
      video_creator__helper(value)
    elsif type == :image
      image_creator__helper(value)
    end
  end
end