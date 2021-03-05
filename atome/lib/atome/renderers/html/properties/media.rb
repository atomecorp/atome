module PropertylHtml
  def content_html(value)
    value = value.read
    if type == :text
      value = value.to_s.gsub("\n", "<br>")
      jq_get(atome_id).text(value)
    elsif type == :shape
      if value[:tension]
        self.smooth(value[:tension])
      end
    elsif type == :video
      video_creator__helper(value)
    elsif type == :image
      image_creator__helper(value)
    end
  end
end