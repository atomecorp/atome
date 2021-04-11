# capture demo

recorder=box({width: 30, height: 30, color: :red, x:30, y: 30})
stop=box({width: 30, height: 30, color: :black, x:90, y: 30})
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
text=text("mouse pointer position and timer")
recorder.touch do
  grab(:view).record(true) do |evt|
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    pointer="#{evt.page_x}, #{evt.page_y} : #{elapsed}"
    text.content= pointer
  end
end

stop.touch do
  grab(:view).record(:stop)
end