# frozen_string_literal: true

new({ renderer: :html, method: :web }) do |params, &user_proc|
  params
end

new({ renderer: :html, method: :renderers, type: :string })
new({ renderer: :html, method: :delete, type: :string }) do |params|
  html.delete(id)
end
new({ renderer: :html, method: :hypertext }) do |params|
  html.hypertext(params)
end
new({ renderer: :html, method: :hyperedit }) do |params, usr_proc|
  html.hyperedit(params, usr_proc)
end
new({ renderer: :html, method: :read, type: :string }) do |value, &bloc|
  html.read(id, value)
end

new({ renderer: :html, method: :browse, type: :string }) do |value, &bloc|
  html.browse(id, value)
end

new({ renderer: :html, method: :terminal, type: :string }) do |value, &bloc|
  html.terminal(id, value)
end

new({ renderer: :html, method: :match }) do |params, bloc|
  case id
  when :atome || :view
    result = bloc.call
    result = { alterations: result }
    params = params.merge(result)
    html.match(params)
  end
end

new({ renderer: :html, method: :import, type: :blob }) do |_params, bloc|

  if Atome::host == 'web-opal'
    file_for_opal(@id, bloc) do |file_content|
      bloc.call(file_content)
    end

  else
    # Wasm version
    def create_file_browser(_options = '', &bloc)
      div_element = JS.global[:document].getElementById(@id.to_s)
      input_element = JS.global[:document].createElement("input")
      input_element[:type] = "file"
      input_element[:style][:position] = "absolute"
      input_element[:style][:display] = "none"
      input_element[:style][:width] = "0px"
      input_element[:style][:height] = "0px"

      input_element.addEventListener("change") do |native_event|
        event = Native(native_event)
        file = event[:target][:files][0]
        if file
          puts "file requested: #{file[:name]}"
          file_reader = JS.global[:FileReader].new
          file_reader.addEventListener("load") do |load_event|
            file_content = load_event[:target][:result]
            Atome.file_handler(@id, file_content, bloc)
          end
          file_reader.readAsText(file)
        end
      end

      div_element.addEventListener("mousedown") do |event|
        input_element.click
      end
      div_element.appendChild(input_element)
    end

    create_file_browser(:options) do |file_content|
      # puts "wasm ===>#{file_content}"
      bloc.call(file_content)
    end
  end

end

new({ method: :compute, type: :hash, renderer: :html }) do |params|
  element = JS.global[:document].getElementById(@id.to_s)
  bounding_box = element.getBoundingClientRect()

  top = bounding_box[:top]
  left = bounding_box[:left]
  width = bounding_box[:width]
  height = bounding_box[:height]
  value_found = case params[:particle]
                when :left
                  left.to_f
                when :top
                  top.to_f
                when :width
                  width.to_f
                when :height
                  height.to_f
                else
                  nil
                end
  @compute[:value] = value_found
end

new({ renderer: :html, method: :preview }) do |params, user_proc|
  if params[:id]
    id_f = params[:id]
  else
    id_f = identity_generator
  end
  if params[:stop]
    html.stop_video_preview(id_f)
  else

    if params[:media] == :video
      html.video_preview(id_f, true, false)
    elsif params[:media] == :audio
      html.video_preview(id_f, false, true)
    elsif params[:media] == :all
      html.video_preview(id_f, true, true)
    else
      html.video_preview(id_f, true, true)
    end
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
