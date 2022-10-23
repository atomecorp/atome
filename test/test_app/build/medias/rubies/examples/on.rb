my_video = Atome.new(
  video: { render: [:html], data: :dummy, id: :video1, type: :video, parent: [:view], path: './medias/videos/avengers.mp4', left: 333, top: 333, width: 199, height: 99,
  }
) do |params|
  puts "video callback here #{params}"
end
my_video.video.play(true)

# TODO int8! : language

# verif video
grab(:video1).time(5)
#
grab(:video1).on(:pause) do |event|
  alert :stopped
end
