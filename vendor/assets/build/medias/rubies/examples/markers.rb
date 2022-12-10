# frozen_string_literal: true

my_video = Atome.new(
  video: { renderers: [:browser], id: :video1, type: :video, parents: [:view], clones: [],
           path: './medias/videos/avengers.mp4', left: 333, top: 33, width: 777
  }
)

my_video.touch(true) do
  my_video.play(10)
  puts "play : #{my_video.play}, pause : #{my_video.pause}"
end

m_code1 = lambda do |val|
  puts "hello : #{val}"
end
m_code2 = lambda do |val|
  puts "hi there : #{val}"
end

m_code22 = lambda do |val|
  puts "Super!! : #{val}"
end

stoper = lambda do
  my_video.pause(true)
end

looper=lambda do
  my_video.add({ markers: { my_stop: { time: 12, code: stoper } } })
  my_video.play(4)
end


# the marker below wont be executed because m2 will override it
my_video.markers({ m1: { time: 18, code: m_code1 } }) do |_params|
  puts 'stop'
end
# the marker will replace marker m1
my_video.markers({ m2: { time: 12.87576, code: m_code1 } }) do |_params|
  puts'good'
end

# The markers below will be executed because they're added

my_video.add({ markers: { my_marker: { time: 18.87576, code: looper } } })
my_video.add({ markers: { m3: { time: 16.87576, code: m_code2 } } })
my_video.add({ markers: { m4: { time: 14.87576, code: m_code22 } } })
