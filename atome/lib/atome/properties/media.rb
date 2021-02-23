module MediasProperties
  def content=(value = nil)
    content_html(value)
    @content = value
  end

  def content
    @content
  end
end