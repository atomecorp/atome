# capture demo

recorder = text({content: "click to start logging", height: 30, color: :red, x: 33, y: 96, smooth: 33, width: :auto})
stop = text({content: "click to stop logging", height: 30, color: :black, x: 33, y: 123, smooth: 33, width: :auto})
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
text({content: "try touch drag and resize on window", width: :auto})
text = text({content: "mouse pointer position and timer", y: 33, width: :auto})
recorder.touch do

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

  grab(:view).record(true) do |evt|
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    pointer = "cursor move : #{evt.page_x}, #{evt.page_y} : #{elapsed}"
    text.content = pointer
  end

end

stop.touch do
  grab(:view).record(:stop)
  grab(:view).child.record(:stop)
  grab(:view).child.drag(x: 33)
end
image({content: :green_planet, x: 196, y: 196, atome_id: :the_planet, drag: true})

box({x: 196, y: 196, color: :yellowgreen, atome_id: :my_nice_box, drag: true})
circle({x: 222, y: 222, atome_id: :the_circle, drag: true})