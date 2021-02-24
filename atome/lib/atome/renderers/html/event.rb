module HtmlEvent
  def touch_html(value)
    value = value.read
    proc = value[:value]
    jq_get(atome_id).on(:click) do |evt|
      proc.call(evt) if proc.is_a?(Proc)
    end
  end

  def drag_html(value)
    value = value.read
    proc = value[:value]
    jq_object = jq_get(atome_id)
    lock = case value[:lock]
    when :parent
      {containment: "parent"}
    when :x
      {axis: "y"}
    when :y
      {axis: "x"}
    else
      {containment: "parent"}
    end
    jq_object.draggable(lock)
    jq_object.on(:drag) do |evt|
      proc.call(evt) if proc.is_a?(Proc)
    end
  end
end