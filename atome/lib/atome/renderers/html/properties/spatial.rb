module PropertyHtml
  def x_html(value)
    jq_get(atome_id).css("left", value.to_s + "px")
    if alignment
      self.alignment[:horizontal] = :x
    else
      self.alignment({ horizontal: :x })
    end
  end

  def xx_html(value)
    if width == :auto
      jq_get(atome_id).css("right", value.to_s + "px")
    else
      jq_get(atome_id).css("left", "auto")
      jq_get(atome_id).css("right", value.to_s + "px")
      if alignment
        self.alignment[:horizontal] = :xx
      else
        self.alignment({ horizontal: :xx })
      end
    end
  end

  def y_html(value)
    jq_get(atome_id).css("top", value.to_s + "px")
    if alignment
      self.alignment[:vertical] = :y
    else
      self.alignment({ vertical: :y })
    end
  end

  def yy_html(value)
    if height == :auto
      jq_get(atome_id).css("bottom", value.to_s + "px")
    else
      # update_property(self, :x, x_position)
      jq_get(atome_id).css("top", "auto")
      jq_get(atome_id).css("bottom", value.to_s + "px")

      if alignment
        self.alignment[:vertical] = :yy
      else
        self.alignment({ vertical: :yy })
      end
    end

  end

  def z_html(value)
    jq_get(atome_id).css("z-index", value)
  end

  def rotate_html(value)
    jq_get(atome_id).css("transform", "rotate(" + value.to_s + "deg)")
  end

  def disposition_html(value)
    max_x = 0
    max_y = 0

    if value.instance_of?(Hash)
      offset_x=value[:x]
      offset_y=value[:y]
      # value=value.keys[0]
    end
    grab(self.parent.last).child do |child_found|
      unless child_found.atome_id == atome_id
        if child_found.x
          # alert child_found.convert(:width)
          if child_found.width.instance_of?(String)
            x_found = child_found.x + child_found.convert(:width)
          else
            x_found = child_found.x + child_found.width
          end
        else
          if child_found.width.instance_of?(String)
            x_found = child_found.convert(:width)
          else
            x_found = child_found.width
          end
        end
        if child_found.y
          if child_found.height.instance_of?(String)
            y_found = child_found.y + child_found.convert(:height)
          else
            y_found = child_found.y + child_found.height
          end
        else
          if child_found.height.instance_of?(String)
            y_found = child_found.convert(:height)
          else
            y_found = child_found.height
          end
        end
        if x_found > max_x
          max_x = x_found
        end
        if y_found > max_y
          max_y = y_found
        end
      end
    end
    unless offset_x
      offset_x=0
    end

    unless offset_y
      offset_y=0
    end

    if value[:x]
      self.x = max_x+offset_x
    end

    if value[:y]
      self.y = max_y+offset_y
    end

  end

  def center_html(value)
    if value.instance_of?(Hash)
      params = { reference: :parent, axis: :all, offset: false }
      value = params.merge(value)
      reference = value[:reference]
      axis = value[:axis]
      offset = value[:offset]
      # dynamic=value[:dynamic]
    else
      reference = :parent
      axis = value
      offset = false
    end

    if reference == :parent
      reference = parent.last
    end

    # if dynamic
    #   grab(:buffer).content[:resize] << self
    # elsif dynamic==false
    #   grab(:buffer).content[:resize].delete(self)
    # end
    if offset
      ofset_y = "left+#{x} top+#{y}"
      ofsset_x = "left+#{x} top+#{y}"
    else
      ofset_y = "left+#{x}"
      ofsset_x = "top+#{y}"
    end

    case axis
    when :y
      center_value = { atome_id: atome_id,
                       my: ofset_y,
                       at: "left middle",
                       of: "##{reference}"
      }
    when :x
      center_value = { atome_id: atome_id,
                       my: ofsset_x,
                       at: "middle top",
                       of: "##{reference}"
      }
    when :all
      center_value = { atome_id: atome_id,
                       at: "center",
                       of: "##{reference}"
      }
    else
      center_value = { atome_id: atome_id,
                       at: "center",
                       of: "##{reference}"
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