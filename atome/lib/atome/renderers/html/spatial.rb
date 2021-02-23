module HtmlSpatial
  def x_html(value)
    jq_get(atome_id).css("left", value)
  end

  def xx_html(value)
    jq_get(atome_id).css("right", value)
  end

  def y_html(value)
    jq_get(atome_id).css("top", value)
  end

  def yy_html(value)
    jq_get(atome_id).css("bottom", value)
  end

  def z_html(value)
    jq_get(atome_id).css("z-index", value)
  end
end