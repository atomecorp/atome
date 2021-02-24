module HtmlGeometry
  def width_html(value)
    value = value.read
    jq_get(atome_id).css("width", value)
  end

  def height_html(value)
    value = value.read
    jq_get(atome_id).css("height", value)
  end

  def size_html(value)
    value = value.read
    puts "todo : add resize algo"
  end
end