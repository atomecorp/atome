# frozen_string_literal: true

##########################
# markers
my_video = Atome.new(
  video: { renderers: [:browser], id: :video1, type: :video, parents: [:view],
           path: './medias/videos/avengers.mp4', left: 333, top: 33, width: 777
  }
) do |params|
  # puts "video callback here #{params}"
end

my_video.touch(true) do
  my_video.play(10) do ||

  end
end

@mcounter = 0
my_video.at({ time: 15 }) do |value|
  # my_video.pause(true)
  if @mcounter
    puts "ok : #{@mcounter}"
  else
    @mcounter = 0
  end

  puts "value is : #{value} : mcounter : #{@mcounter}"
  puts "---- #{my_video.time}-----"
  my_video.play(15+(@mcounter*1))
  # my_video.play() do |val|
  #   puts val
  # end

  @mcounter = @mcounter + 1
  @at_time[:used] = false
end


# frozen_string_literal: true

generator = Genesis.generator
generator.build_particle(:markers)



my_lambda = lambda do  |val|
  puts "hello : #{val}"
end
my_video.markers({m1:{time: 15.87576, code: my_lambda}})

my_video.markers({m1:{time: 15.87576, code: my_lambda}}) do |params|
  alert :good
end

my_lambda.call(:jeezs)
alert my_video.markers