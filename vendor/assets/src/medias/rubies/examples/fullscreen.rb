# frozen_string_literal: true

my_video = Atome.new(
  video: { renderers: [:browser],  id: :video1, type: :video, attach: [:view],
           path: './medias/videos/superman.mp4', left: 33, top: 33, width: 777
  }
) do |params|
  puts "video callback here #{params}"
end
my_video.play(true)


my_video.touch(true) do
  my_video.fullscreen
end