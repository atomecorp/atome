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
    jq_get(atome_id).position({atome_id: atome_id,
                                        my: "right bottom+33",
                                        at: "right bottom",
                                     of: "#view"
                                   });

    theatomeid="##{atome_id}"


    left =`$( #{theatomeid}).css('top')

`
    # alert left
    update_property(self, :x, left)
  end

  def position_html(value)
    jq_get(atome_id).css("position", value)
  end
end