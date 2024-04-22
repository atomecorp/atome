# frozen_string_literal: true

new({ particle: :record, category: :utility, type: :hash })
new({ particle: :preview, category: :utility, type: :hash })
new({ renderer: :html, method: :preview }) do |params, user_proc|
  if params[:id]
    id_f = params[:id]
  else

    id_f = identity_generator
  end
  if  params[:media] == :video
    html.video_preview(id_f, true, false)
  elsif   params[:media] == :audio
    html.video_preview(id_f, false, true)
  elsif   params[:media] == :all
    html.video_preview(id_f, true, true)
  else
    html.video_preview(id_f, true, true)
  end


end
new({ renderer: :html, method: :record }) do |params, user_proc|
  duration = params[:duration] ||= 1000000
  media = params[:media] ||= :video
  mode = params[:mode] ||= :web # web or native
  name = params[:name] ||= :record
  path = params[:path] ||= './'
  data = params[:data] ||= {}
  stop = params[:stop]
  if stop
    if @video_recorder_type == :web || @audio_recorder_type == :web
      # alert "@video_recorder_type : #{@video_recorder_type}"
      # alert "@audio_recorder_type : #{@audio_recorder_type}"
      # alert "stop the params : #{params[:pid].class}"
      ########
      # callback_container("primaryKey3", "secondaryKey1")
      html.stop_media_recorder(id)
    elsif @video_recorder_type == :native || @audio_recorder_type == :native
      A.message({ action: :stop_recording, data: params })
    end

  elsif media == :video
    type = params[:type] ||= :mp4
    if mode == :native
      @video_recorder_type = :native
      A.message({ action: :record, data: { type: type, duration: duration, name: name, path: path, media: media, data: data } }) do |result|
        user_proc.call(result)
      end
    else
      @video_recorder_type = :web
      html.record_video(params)
    end

  elsif media == :audio
    type = params[:type] ||= :wav
    if mode == :native
      @audio_recorder_type = :native
      A.message({ action: :record, data: { type: type, duration: duration, name: name, path: path, media: media, data: data } }) do |result|
        user_proc.call(result)
      end
    else
      @audio_recorder_type = :web
      html.record_audio(params)
    end
  end

end

## native recording :
#
# c = circle({ color: :red, left: 30 })
# c.text(:na)
# record_callback = 'unset'
# c.touch(true) do
#   A.record({ media: :audio, duration: 5, mode: :native, name: :titi, type: :wav, path: '../src', data: {note: :c, velocity: 12, robin: 3, author: :vie, tags: [:voice, :noise, :attack]} }) do |result|
#     puts result
#     record_callback = result
#   end
#
# end
#
# cc = circle({ color: :red, left: 120 })
# cc.text(:nv)
# cc.touch(true) do
#   A.record({ media: :video, duration: 5, mode: :native, name: :tutu, type: :mp4, path: '../src/',data: {type: :thriller,} }) do |result|
#     puts result
#     record_callback = result
#   end
# end
#
# ccc = circle({ color: :red, left: 256 })
# ccc.text(:stop)
# ccc.touch(true) do
#   pid = record_callback['pid']
#   A.record({ stop: true, pid: pid }) do |msg|
#     puts "msg received for stop : #{msg}"
#   end
# end

# web recording:

c = circle({ color: :red, left: 30 })
c.text(:audio)
record_callback = 'unset'
c.touch(true) do
  A.record({ media: :audio, duration: 7, mode: :web, name: :titi, type: :wav, path: '../src', data: { note: :c, velocity: 12, robin: 3, author: :vie, tags: [:voice, :noise, :attack] } }) do |result|
    puts result
    # record_callback = result
  end
end

cc = circle({ color: :red, left: 120, id: :the_circle })
cc.text(:video)
media_element_found = ''
cc.touch(true) do

  A.record({ media: :video, duration: 5, mode: :web, name: :tutu, type: :mp4, path: '../src/', data: { type: :thriller } }) do |result|
    # alert  "callback : #{record_callback = result}"
    # alert "result : #{result.class}"
    media_element_found = result
  end
end

ccc = circle({ color: :red, left: 256 })
ccc.text(:stop)
ccc.touch(true) do
  # pid = record_callback['pid']
  # media_element_found

  A.record({ stop: true }) do |msg|
    puts "msg received for stop : #{msg}"
  end
end

cc2 = circle({ color: :red, left: 512, id: :the_circle_prev })
cc2.text(:preview)
cc2.touch(true) do
  A.preview({ media: :video , mode: :web, id: :my_preview })
end


