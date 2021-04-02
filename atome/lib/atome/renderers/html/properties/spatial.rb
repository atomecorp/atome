module PropertylHtml
  def x_html(value)
    jq_get(atome_id).css("left", value.to_s + "px")
  end

  def xx_html(value)
    jq_get(atome_id).css("right", value.to_s + "px")
  end

  def y_html(value)
    jq_get(atome_id).css("top", value.to_s + "px")
  end

  def yy_html(value)
    jq_get(atome_id).css("bottom", value.to_s + "px")
  end

  def z_html(value)
    jq_get(atome_id).css("z-index", value)
  end

  def rotate_html(value)
    jq_get(atome_id).css("transform", "rotate(" + value.to_s + "deg)")
  end

  def center_html(value)
    value
    jq_get(atome_id).position({ atome_id: atome_id,
                                my: "right bottom",
                                at: "right bottom",
                                of: "#view"
                              });

    theatomeid = "##{atome_id}"

    # we update the position of the atome
    jq_object = jq_get(atome_id)
    x_position = jq_object.css("left").sub("px", "").to_i
    y_position = jq_object.css("top").sub("px", "").to_i
    xx_position = jq_object.css("right").sub("px", "").to_i
    yy_position = jq_object.css("bottom").sub("px", "").to_i

    update_property(self, :x, x_position)
    update_property(self, :y, y_position)
    update_property(self, :xx, xx_position)
    update_property(self, :yy, yy_position)
  end

  def position_html(value)
    jq_get(atome_id).css("position", value)
  end
end