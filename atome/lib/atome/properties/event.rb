module EventsProperties
  def touch(value, &proc)
    @touch = atomise(value.merge(value: proc))
    touch_html(@touch)
  end

  def drag(value, &proc)
    @drag = atomise(value.merge(value: proc))
    drag_html(@drag)
  end
end