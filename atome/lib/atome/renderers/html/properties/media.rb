module PropertylHtml
  def content_html(value)
    value = value.read
    if type == :text
      value = value.to_s.gsub("\n", "<br>")
      jq_get(atome_id).html(value)
    elsif type == :shape
      if value[:tension]
        self.smooth(value[:tension])
      end
    elsif type == :video
      video_creator__helper(value)
    elsif type == :image
      image_creator__helper(value)
    end
    #case type
    #when :value.to_s.gsub("\n", "<br>")
    #when :shape
    #  if value[:tension]
    #    self.smooth(value[:tension])
    #  end
    #when :video
    #  video_creator__helper(value)
    #when :image
    #  image_creator__helper(value)
    #else
    #  value
    #end
  end
end