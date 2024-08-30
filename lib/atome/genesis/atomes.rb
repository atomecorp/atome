# frozen_string_literal: true

new({ atome: :editor, type: :hash })

new({ sanitizer: :editor }) do |params|
  params = {} unless params.instance_of? Hash
  params[:data] = [] unless params[:data]
  params
end

new({ atome: :color, type: :hash })

new({ sanitizer: :color }) do |params|
  params = create_color_hash(params) unless params.instance_of? Hash
  unless params[:id]
    uniq_value = "#{params[:red].to_s.sub('.', '_')}_#{params[:green].to_s.sub('.', '_')}_#{params[:blue].to_s.sub('.', '_')}_#{params[:alpha].to_s.sub('.', '_')}_#{params[:left].to_s.sub('.', '_')}_#{params[:top].to_s.sub('.', '_')}_#{params[:diffusion].to_s.sub('.', '_')}"
    params[:id] = "color_#{uniq_value}".to_sym
  end
  params
end

new({ atome: :image })
new({ sanitizer: :image }) do |params|
  unless params.instance_of? Hash
    # TODO : we have to convert all image to png or maintain a database with extension
    # FIXME : temporary patch that add .png to the string if no extension is found
    params = "#{params}.png" if params.to_s.split('.').length == 1
    params = { path: "./medias/images/#{params}" }
  end
  # TODO : the line below should get the value from default params Essentials
  params

end
new({ post: :image }) do
  # we have find the size od the image to set it in the atome
  instance_variable_set("@width", compute({ particle: :width })[:value])
  instance_variable_set("@height", compute({ particle: :height })[:value])
end
new({ atome: :video })
new({ sanitizer: :video }) do |params|
  unless params.instance_of? Hash
    # TODO : we have to convert all image to png or maintain a database with extension
    # FIXME : temporary patch that add .mp4 to the string if no extension is found
    params = "#{params}.mp4" if params.to_s.split('.').length == 1

    params = { path: "./medias/videos/#{params}" }
  end
  # TODO : the line below should get the value from default params Essentials
  params
end
new({ atome: :www })
new({ atome: :shadow }) do |params|
  if params
    attach_value = params.delete(:affect)
    params[:affect] = attach_value
  end
  params
end
new({ atome: :border }) do |params|
  if params
    attach_value = params.delete(:affect)
    params[:affect] = attach_value
  end
  params
end
new({ post: :border }) do |params|
  # in order to apply the color to the atome border if a color is passed
  color(params[:color])
end
new({ atome: :raw })
new({ atome: :shape })
new({ atome: :code })
new({ atome: :audio })
new({ sanitizer: :audio }) do |params|
  unless params.instance_of? Hash
    # TODO : we have to convert all image to png or maintain a database with extension
    # FIXME : temporary patch that add .mp4 to the string if no extension is found
    params = "#{params}.mp4" if params.to_s.split('.').length == 1

    params = { path: "./medias/audios/#{params}" }
  end
  # TODO : the line below should get the value from default params Essentials
  params
end
new({ atome: :element })
new({ sanitizer: :element }) do |params|
  default_params = { data: '' }
  default_params.merge!(params)
end
new({ atome: :animation })
new({ atome: :group })
new({ atome: :text, type: :hash })
new({ post: :text }) do |params|
  data_found = params[:data]
  if data_found.instance_of? Array
    data_found.each_with_index do |data_found, index|
      # we treat the first element
      if index == 0
        send(:data, data_found)
      else
        # we create new text's atome fasten to the main one (the first element above)
        text(data_found)
      end

    end
  else
    send(:data, data_found)
  end
  params
end
new({ sanitizer: :text }) do |params|
  # to allow text api with the form text(:hello) instead of text({data: :hello})
  params = { data: params } unless params.instance_of? Hash
  params
end

# for later use ( physical is a css like style)
new({ atome: :human }) do |params|
  Universe.add_user = params[:id]
end
new({ atome: :machine })
new({ atome: :paint })
new({ atome: :vector })
new({ atome: :table })
new({ atome: :atomized, type: :hash })
new({ atome: :map, type: :hash })
new({atome: :vr, type: :hash})
new({atome: :draw})




