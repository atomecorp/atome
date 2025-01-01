# frozen_string_literal: true

if Universe.internet
  v = video({ path: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" })
else
  v = video(:video_missing)
end

v.touch(true) do
  v.play(true)
  wait 3 do
    v.play(66)
  end
end