# frozen_string_literal: true

my_video = Atome.new(
  video: { renderers: [:browser], id: :video1, type: :video, parents: [:view], path: './medias/videos/superman.mp4',
           left: 333, top: 112, width: 199, height: 99
  }
) do |params|
  # puts "video callback time is  #{params}, id is : #{id}"
  puts "video callback time is  #{params}, id is : #{id}"
end
wait 2 do
  my_video.left(33)
  my_video.width(444)
  my_video.height(444)

end

my_video.touch(true) do
  my_video.play(true) do |currentTime|
    puts "play callback time is : #{currentTime}"
  end
end
#############
my_video2 = Atome.new(
  video: { renderers: [:browser], id: :video9, type: :video, parents: [:view], path: './medias/videos/madmax.mp4',
           left: 666, top: 333, width: 199, height: 99,
  }) do |params|
  puts "2- video callback time is  #{params}, id is : #{id}"
end
my_video2.top(33)
my_video2.left(333)

my_video2.touch(true) do
  my_video2.play(true) do |currentTime|
    puts "2 - play callback time is : #{currentTime}, id is : #{id}"
  end
end

#############
my_video3 = video({ path: './medias/videos/avengers.mp4', id: :video16 }) do |params|
  puts "3 - video callback here #{params}, id is : #{id}"
end
my_video3.width = my_video3.height = 333
my_video3.left(555)
grab(:video16).on(:pause) do |_event|
  puts "id is : #{id}"
end
my_video3.touch(true) do
  grab(:video16).time(15)
  my_video3.play(true) do |currentTime|
    puts "3- play callback time is : #{currentTime}, id is : #{id}"
  end
  wait 3 do
    puts "time is :#{my_video3.time}"
  end
  wait 6 do
    grab(:video16).pause(true) do |time|
      puts "paused at #{time} id is : #{id}"
    end
  end
end