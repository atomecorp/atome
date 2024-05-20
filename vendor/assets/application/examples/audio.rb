#  frozen_string_literal: true

# if Universe.internet
#   v = video({ path: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", left: 333 })
# else
#   v = video(:video_missing)
# end
a = audio({ path: 'medias/audios/clap.wav' })
b=box
a.left(333)
b.touch(:down) do

  a.play(true)
  # wait 3 do
  #   v.play(66)
  # end
end

# a=audio(:snare)
#
# a.touch(true)  do
#   a.play(66)
# end

