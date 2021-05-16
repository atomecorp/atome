module PropertyHtml
  def width_html(value)
    type = grab(atome_id).type
    if type == :texto
      # jq_get(atome_id).css("font-size", value)
      # jq_get(atome_id).css("width", "auto")
      # jq_get(atome_id).css("width", value)
      # jq_get(atome_id).css("width", value)
      # jq_get(atome_id).css("font-size", "001vmin")

    else
      # jq_get(atome_id).css("font-size", value)
      jq_get(atome_id).css("width", value)
    end
  end

  def height_html(value)
    type = grab(atome_id).type
    if type == :texto
      # jq_get(atome_id).css("font-size", value)
      # jq_get(atome_id).css("height", "auto")
      # jq_get(atome_id).css("height", value)
      # jq_get(atome_id).css("font-size", "1vmin")
    else
      # jq_get(atome_id).css("font-size", value)
      jq_get(atome_id).css("height", value)
    end
  end

  def size_html(value)
    size_ratio=1
    if self.ratio
      size_ratio=self.ratio
    end
    if self.width && self.height
      size_ratio=self.width/self.height
    end
    case value[:fit]
    when :fit
      self.width = grab(parent.last).convert(:width)
      self.height = grab(parent.last).convert(:height)
    when true
      self.width = grab(parent.last).convert(:width)
      self.height = grab(parent.last).convert(:height)
    when :width
      # alert value
      parent_width = grab(parent.last).convert(:width)
      self.width = parent_width
      self.height = parent_width / size_ratio
    when :height
      parent_height = grab(parent.last).convert(:height)
      self.height = parent_height
      self.width = parent_height * size_ratio
    else
    end
  end

end

