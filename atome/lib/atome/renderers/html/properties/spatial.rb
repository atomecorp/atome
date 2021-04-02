module PropertyHtml
  def x_html(value)
    jq_get(atome_id).css("left", value.to_s + "px")
  end

  def xx_html(value)
    if width == :auto
      jq_get(atome_id).css("right", value.to_s + "px")
    else
      jq_get(atome_id).css("left","auto")
      jq_get(atome_id).css("right", value.to_s + "px")


      # xx_value = { atome_id: atome_id,
      #             my: "right top+#{y}",
      #             at: "right+#{-value} top",
      #             of: "#view"
      # }
      # jq_get(atome_id).css("left","auto")
      # position_html(xx_value)
      # change_position_origin
    end
  end

  def y_html(value)
    jq_get(atome_id).css("top", value.to_s + "px")
  end

  def yy_html(value)
    if height == :auto
      jq_get(atome_id).css("bottom", value.to_s + "px")
    else

      # update_property(self, :x, x_position)
      jq_get(atome_id).css("top","auto")
      jq_get(atome_id).css("bottom", value.to_s + "px")
      # yy_value = { atome_id: atome_id,
      #             my: "left+#{x} bottom",
      #             at: "left bottom+#{-value}",
      #             of: "#view"
      # }
      # position_html(yy_value)
      # change_position_origin
    end

  end

  def z_html(value)
    jq_get(atome_id).css("z-index", value)
  end

  def rotate_html(value)
    jq_get(atome_id).css("transform", "rotate(" + value.to_s + "deg)")
  end

  def center_html(value)
    case value
    when :y
      center_value = { atome_id: atome_id,
                       my: "left+#{x}",
                       at: "left middle",
                       of: "#view"
      }
    when :x
      center_value = { atome_id: atome_id,
                       my: "top+#{y}",
                       at: "middle top",
                       of: "#view"
      }
    when :all
      center_value = { atome_id: atome_id,
                       at: "center",
                       of: "#view"
      }
    else
      center_value = { atome_id: atome_id,
                 at: "center",
                 of: "#view"
      }
    end
    position_html(center_value)
  end

  def position_html(value)
    jq_get(atome_id).position(value)
    # we update the position of the atome
    update_position
  end

  def fixed_html(value)
    if value
      jq_get(atome_id).css("position", :fixed)
    else
      jq_get(atome_id).css("position", :absolute)
    end
  end
end