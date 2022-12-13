# frozen_string_literal: true

my_video = Atome.new(
  video: { renderers: [:browser], id: :video1, type: :video, parents: [:view],
           time: 33,  path: './medias/videos/avengers.mp4', left: 333, top: 33, width: 777
  }
) do |params|
  puts "video callback here #{params}"
end
my_video.touch(true) do
  grab(:video1).time(5)
  my_video.pause(true)
end
my_video.play(true)