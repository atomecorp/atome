my_video = Atome.new(
  video: { render: [:html], id: :video1, type: :video,  parent: [:view], path: './medias/videos/superman.mp4', left: 333, top: 333, width: 199, height: 99,
  }
) do |params|
  puts "video callback time is  #{params}, id is : #{id}"
end
my_video.video.top(33)
my_video.video.left(33)

my_video.video.touch(true) do
  my_video.video.play(true) do |currentTime|
    puts "play callback time is : #{currentTime}"
  end
end

my_video2 = Atome.new(
  video: { render: [:html], id: :video9, type: :video,  parent: [:view], path: './medias/videos/madmax.mp4', left: 666, top: 333, width: 199, height: 99,
  }
#FIXME : positioning doesnt work

) do |params|
  puts "2- video callback time is  #{params}, id is : #{id}"
end
my_video2.video.top(33)
my_video2.video.left(333)

my_video2.video.touch(true) do
  my_video2.video.play(true) do |currentTime|
    puts "2 - play callback time is : #{currentTime}, id is : #{id}"
  end
end


my_video3 = video({ path: './medias/videos/avengers.mp4', id: :video16 }) do |params|
  puts "3 - video callback here #{params}, id is : #{id}"
end

grab(:video16).on(:pause) do |event|
  alert ":supercool, id is : #{id}"
end
my_video3.touch(true) do
  grab(:video16).time(15)
  my_video3.play(true) do |currentTime|
    puts "3- play callback time is : #{currentTime}, id is : #{id}"
  end
  wait 3 do
    grab(:video16).pause(true) do |p|
      alert "paused, id is : #{id}"
    end
  end
end

