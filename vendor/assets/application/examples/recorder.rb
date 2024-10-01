# frozen_string_literal: true

# native recording (server mode only) :
text({ data: 'native operation only work in server mode ', top: 60 })
a = circle({ color: :red, left: 30, top: 90 })
a.text('native Audio')
record_callback = 'unset'
a.touch(true) do
  A.record({ media: :audio, duration: 5, mode: :native, name: :my_audio_rec, type: :wav, path: '../src', data: { note: :c, velocity: 12, robin: 3, author: :vie, tags: [:voice, :noise, :attack] } }) do |result|
    puts result
    record_callback = result
  end
  nil # we must return nil else the event methods take the bloc for a Hash and crash the code

end

aa = circle({ color: :red, left: 120, top: 90 })
aa.text('native video')
aa.touch(true) do
  A.record({ media: :video, duration: 5, mode: :native, name: :my_video_rec, type: :mp4, path: '../src/', data: { type: :thriller, } }) do |result|
    puts result
    record_callback = result
  end
  nil # we must return nil else the event methods take the bloc for a Hash and crash the code

end

aaa = circle({ color: :red, left: 256, top: 90 })
aaa.text('native stop')
aaa.touch(true) do
  pid = record_callback['pid']
  A.record({ stop: true, pid: pid }) do |msg|
    puts "msg received for native stop : #{msg}"
  end
  nil # we must return nil else the event methods take the bloc for a Hash and crash the code

end

# web recording:
box_to_rec_into = box({ id: :the_big_box })
c = circle({ color: :red, left: 30 })
c.text(:audio)
c.touch(true) do
  box_to_rec_into.record({ media: :audio, duration: 7, mode: :web, name: :web_audio_rec, type: :wav, path: '../src', data: { note: :c, velocity: 12, robin: 3, author: :vie, tags: [:voice, :noise, :attack] } }) do |result|
    #   # puts "recording audio : #{result}"
  end
  nil # we must return nil else the event methods take the bloc for a Hash and crash the code

end

cc = circle({ color: :red, left: 120, id: :the_circle })
cc.text(:video)
cc.touch(true) do
  box_to_rec_into.record({ media: :video, duration: 30, mode: :web, name: :web_video_rec, type: :mp4, path: '../src/', data: { type: :thriller } }) do |result|
    # puts "recording video : #{result}"
  end
  nil # we must return nil else the event methods take the bloc for a Hash and crash the code

end

ccc = circle({ color: :red, left: 256 })
ccc.text(:stop)
ccc.touch(true) do
  box_to_rec_into.record({ stop: true }) do |msg|
    puts "msg received for web stop : #{msg}"
  end
  nil # we must return nil else the event methods take the bloc for a Hash and crash the code

end

cc2 = circle({ color: :red, left: 512, id: :the_circle_prev })
cc2.text(:preview)
cc2.touch(true) do
  A.preview({ media: :video, mode: :web, id: :my_preview })
  nil # we must return nil else the event methods take the bloc for a Hash and crash the code

end

cc3 = circle({ color: :red, left: 600, id: :the_circle_stop_prev })
cc3.text('kill preview')
cc3.touch(true) do
  A.preview({ media: :video, mode: :web, id: :my_preview, stop: true })
  nil # we must return nil else the event methods take the bloc for a Hash and crash the code

end


