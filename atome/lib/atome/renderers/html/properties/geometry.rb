module PropertyHtml
  def width_html(value)
    jq_get(atome_id).css("width", value)
    # alert jq_get(atome_id).children().length()
    # if jq_get(atome_id).children().length() > 0
    #   alert atome_id
    #   # jq_get(atome_id).append("<div id= '#{atome_id}_mask' style='position: absolute;display:block; background-color: transparent;width:100%;height:100%''></div>")
    # end
  end

  def height_html(value)
    jq_get(atome_id).css("height", value)
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

