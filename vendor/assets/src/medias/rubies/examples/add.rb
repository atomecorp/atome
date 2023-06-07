# frozen_string_literal: true

my_video = Atome.new(
  video: { renderers: [:browser],  id: :video1, type: :video, attach: [:view],
           path: './medias/videos/superman.mp4', left: 33, top: 33, width: 777
  }
)

my_video.touch(true) do
  my_video.play(3)
  puts "play : #{my_video.play}, pause : #{my_video.pause}"
end

stoper = lambda do
  my_video.pause(true)
end

jumper=lambda do
  my_video.play(12)
end

my_video.markers({ markers: { begin: 6, code: jumper } })

my_video.add({ markers: { my_stop: { begin: 16, code: stoper } }, left: 33 })
