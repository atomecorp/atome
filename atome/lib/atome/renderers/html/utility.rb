module HtmlUtility
  def delete_html(value)
    value.read
  end

  def render_html(value)
    value = value.read
    unless value
      jq_get(atome_id).remove
    end
  end

  def language_html(value)
    value.read
  end

  def preset_html(value)
    value.read
  end
end