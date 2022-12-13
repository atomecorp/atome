# frozen_string_literal: true

my_video = Atome.new(
  video: { renderers: [:browser], id: :video1, type: :video, parents: [:view],
           path: './medias/videos/avengers.mp4', left: 333, top: 33, width: 777
  }
) do |params|
  puts "video callback here #{params}"
end
my_video.touch(true) do
  my_video.pause(true)
end
my_video.play(true)

# video example
grab(:video1).time(5)
wait 4 do
  grab(:video1).pause(5)
end
grab(:video1).on(:pause) do |_event|
  puts :stopped
end

grab(:video1).on(:click) do |_event|
  puts :touched
end