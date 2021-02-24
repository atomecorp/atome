module EventsProperties
  def touch(value, &proc)
    @touch = Quark.new(value.merge(value: proc))
    touch_html(@touch)
  end

  def drag(value, &proc)
    @drag = Quark.new(value.merge(value: proc))
    drag_html(@drag)
  end
end