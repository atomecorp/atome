# frozen_string_literal: true

new({ particle: :record, category: :utility, type: :hash })
new({ renderer: :html, method: :record }) do |params, user_proc|
  duration = params[:duration] ||= 1
  media = params[:media] ||= :video
  mode = params[:mode] ||= :web # web or native
  name = params[:name] ||= :record
  path = params[:path] ||= './'
  data = params[:data] ||= {}
  stop = params[:stop]
  if stop
    # alert stop
    A.message({ action: :stop_recording, data: params }) do |result|
      # user_proc.call(result)
    end
  elsif media == :video
    type = params[:type] ||= :mp4
    if mode == :native
      A.message({ action: :record, data: { type: type, duration: duration, name: name, path: path, media: media, data: data } }) do |result|
        user_proc.call(result)
      end
    else
      puts 'video code'
    end

  elsif media == :audio
    type = params[:type] ||= :wav
    if mode == :native
      A.message({ action: :record, data: { type: type, duration: duration, name: name, path: path, media: media, data: data } }) do |result|
        user_proc.call(result)
      end
    else
      alert 'audio code'
    end
  end

end

c = circle({ color: :red, left: 30 })
c.text(:na)
record_callback = 'unset'
c.touch(true) do
  A.record({ media: :audio, duration: 5, mode: :native, name: :titi, type: :wav, path: '../src', data: {note: :c, velocity: 12, robin: 3, author: :vie, tags: [:voice, :noise, :attack]} }) do |result|
    puts result
    record_callback = result
  end

end

cc = circle({ color: :red, left: 120 })
cc.text(:nv)
cc.touch(true) do
  A.record({ media: :video, duration: 5, mode: :native, name: :tutu, type: :mp4, path: '../src/',data: {type: :thriller,} }) do |result|
    puts result
    record_callback = result
  end
end

ccc = circle({ color: :red, left: 256 })
ccc.text(:stop)
ccc.touch(true) do
  pid = record_callback['pid']
  A.record({ stop: true, pid: pid }) do |msg|
    puts "msg received for stop : #{msg}"
  end
end


