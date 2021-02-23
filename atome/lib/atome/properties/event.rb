module EventsProperties
  def touch=(value = nil)
    touch_html(value)
    @touch = value
  end

  def touch(options, &proc)
    touch_html(options, proc)
    @touch
  end

  def drag=(value = nil)
    drag_html(value)
    @drag = value
  end

  def drag(options, &proc)
    drag_html(options, proc)
    @drag
  end
end