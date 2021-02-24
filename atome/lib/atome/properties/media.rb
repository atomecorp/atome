module MediasProperties
  def content=(value)
    @content = atomise(value)
    content_html(@content)
  end

  def content
    @content.read
  end
end