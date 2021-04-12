# capture demo

recorder = box({width: 30, height: 30, color: :red, x: 30, y: 166, smooth: 33})
stop = box({width: 30, height: 30, color: :green, x: 90, y: 166, smooth: 33})
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
text({content: "try touch drag and resize on window"})
text = text({content: "mouse pointer position and timer", y: 33})
recorder.touch do
  grab(:view).record(true) do |evt|
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    pointer = "cursor move : #{evt.page_x}, #{evt.page_y} : #{elapsed}"
    text.content = pointer
  end

  grab(:view).touch({option: :down}) do |evt|
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    object_under_pointer=JSUtils.get_object_under_pointer(evt)
    pointer = "click down on view a  at #{evt.page_x}, #{evt.page_y} : #{elapsed}, object under the pointer #{object_under_pointer}"
    text.content = pointer
  end

  grab(:view).touch({option: :up}) do |evt|
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    object_under_pointer=JSUtils.get_object_under_pointer(evt)
    pointer = "click up on view at #{evt.page_x}, #{evt.page_y} : #{elapsed}, object under the pointer #{object_under_pointer}"
    text.content = pointer
  end

  grab(:view).drag({fixed: true}) do |evt|
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    pointer = "drag on view at #{evt.page_x}, #{evt.page_y} : #{elapsed}"
    text.content = pointer
  end

  ATOME.resize_html(true) do |evt|
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    pointer = "resize the view  #{evt[:width]}, #{evt[:height]} : #{elapsed}"
    text.content = pointer
  end

end

stop.touch do
  grab(:view).record(:stop)
end
image({content: :green_planet, x: 196, y: 196, atome_id: :the_planet})

box({x: 196, y: 196, color: :yellowgreen, atome_id: :my_nice_box})
circle({x: 222, y: 222, atome_id: :the_circle})