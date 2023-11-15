# frozen_string_literal: true

if Universe.internet
  v = video({ path: "medias/videos/avengers.mp4", id: :my_video })
  # v = video({ path: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" })
else
  v = video(:video_missing)
end
v.left(200)
v.touch(true) do
  # # v.play(true)
  # v.play(169) do |event|
  #   puts "event is : #{event}"
  # end
  alert v.play
  # wait 3 do
  #   v.play(66)
  # end
end

t=text({id: :my_text, data: :hello})
t.touch(true) do
  v.play(26) do |event|
    t.data("event is : #{event}")
  end
end

c=circle({left: 123})

c.touch(true) do
  v.play(:pause)
end

cc=circle({left: 0, width: 55, height: 55})

left=0
cc.drag(:locked) do |event|
  dx = event[:dx]
  dy = event[:dy]
  left += dx
  min_left = 0
  max_left = 600

  left = [min_left, left].max
  left = [left, max_left].min

  v.html.currentTime(left/10)
  cc.left(left)
end


puts "add lock x and y when drag"
puts "restrict view doesnt work"