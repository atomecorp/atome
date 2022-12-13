# frozen_string_literal: true

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
  wait 2 do
    my_video2.mute(true)
    wait 3 do
      my_video2.mute
    end
  end
end