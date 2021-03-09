module PropertylHtml
  def x_html(value)
    value=value.read
    jq_get(atome_id).css("left", value.to_s+"px")
  end

  def xx_html(value)
    value=value.read
    jq_get(atome_id).css("right", value.to_s+"px")
  end

  def y_html(value)
    value=value.read
    jq_get(atome_id).css("top", value.to_s+"px")
  end

  def yy_html(value)
    value=value.read
    jq_get(atome_id).css("bottom", value.to_s+"px")
  end

  def z_html(value)
    value=value.read
    jq_get(atome_id).css("z-index", value)
  end

  def rotate_html(value)
    value = value.read
    jq_get(atome_id).css("transform", "rotate(" + value.to_s + "deg)")
  end

  def center_html(value)
    value = value.read
    puts value
  end

  def position_html(value)
    jq_get(atome_id).css("position", value)
  end
end