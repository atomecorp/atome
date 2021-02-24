module HtmlMedia
  def content_html(value)
    value = value.read
    value = value.to_s.gsub("\n", "<br>")
    if type == :text
      jq_get(atome_id).html(value)
    end
  end
end