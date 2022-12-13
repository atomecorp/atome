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
  my_video.add({ markers: { my_stop: { begin: 6, code: stoper } } })
  my_video.play(4)
end


# the marker below wont be executed because m2 will override it
my_video.markers({ m1: { begin: 13, code: m_code1 } }) do |_params|
  puts 'stop'
end
# the marker will replace marker m1
my_video.markers({ m2: { begin: 12.876, code: m_code2 } }) do |_params|
  puts'good'
end

# The markers below will be executed because they're added

my_video.add({ markers: { my_marker: { begin: 22.87576, code: looper } } })
my_video.add({ markers: { m3: { begin: 16.87576, code: m_code2 } } })
my_video.add({ markers: { m4: { begin: 14.87576,end: 16, code: m_code22 } } })
