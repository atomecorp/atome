# frozen_string_literal: true

my_video = Atome.new(
  video: { renderers: [:browser], id: :video1, type: :video, attach: [:view],fasten: [],
           time: 33,  path: './medias/videos/superman.mp4', left: 69, top: 33, width: 777
  }
) do |params|
  puts "video callback here #{params}"
end
my_video.touch(true) do
  grab(:video1).time(3)
  my_video.pause(true)
  wait 3 do
    play(50)
  end

end
my_video.play(true)