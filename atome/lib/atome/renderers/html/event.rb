module HtmlEvent
  def touch_html(options, proc)
    puts options
    jq_get(atome_id).on(:click) do |evt|
      proc.call(evt) if proc.is_a?(Proc)
    end
  end

  def drag_html(options, proc)
    jq_object = jq_get(atome_id)
    options = case options[:lock]
              when :parent
                {containment: "parent"}
              when :x
                {axis: "y"}
              when :y
                {axis: "x"}
              else
                {containment: "parent"}
              end
    jq_object.draggable(options)
    jq_object.on(:drag) do |evt|
      proc.call(evt) if proc.is_a?(Proc)
    end
  end
end