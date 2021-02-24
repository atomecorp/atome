module MediasProperties
  def content=(value)
    @content = Quark.new(value)
    content_html(@content)
  end

  def content
    @content.read
  end
end