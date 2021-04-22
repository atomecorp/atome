module PropertyHtml
  def width_html(value)
    type = grab(atome_id).type
    if type == :text
      jq_get(atome_id).css("font-size", value)
      jq_get(atome_id).css("width", "auto")
    else
      jq_get(atome_id).css("width", value)
    end
  end

  def height_html(value)
    type = grab(atome_id).type
    if type == :text
      jq_get(atome_id).css("font-size", value)
      jq_get(atome_id).css("height", "auto")
    else
      jq_get(atome_id).css("height", value)
    end
  end

  def size_html(value)
    if value == :fit
      self.width = grab(parent.last).convert(:width)
      self.height = grab(parent.last).convert(:height)
    end
  end

end

