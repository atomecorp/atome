module HtmlSpatial
  def x_html(value)
    value=value.read
    jq_get(atome_id).css("left", value)
  end

  def xx_html(value)
    value=value.read
    jq_get(atome_id).css("right", value)
  end

  def y_html(value)
    value=value.read
    jq_get(atome_id).css("top", value)
  end

  def yy_html(value)
    value=value.read
    jq_get(atome_id).css("bottom", value)
  end

  def z_html(value)
    value=value.read
    jq_get(atome_id).css("z-index", value)
  end

  def center_html(value)
    value = value.read
  end
end