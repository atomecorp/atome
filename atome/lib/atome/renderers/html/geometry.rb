module HtmlGeometry
  def width_html(value)
    jq_get(atome_id).css("width", value)
  end

  def height_html(value)
    jq_get(atome_id).css("height", value)
  end
end