# frozen_string_literal: true
new({ atome: :color, type: :hash })
new({ sanitizer: :color }) do |params|
  params = create_color_hash(params) unless params.instance_of? Hash
  # the condition below is to prevent the creation of multiple unwanted colors with same property and no ID specified
  unless params[:id]
    uniq_value = "#{params[:red].to_s.sub('.', '_')}_#{params[:green].to_s.sub('.', '_')}_#{params[:blue].to_s.sub('.', '_')}_#{params[:alpha].to_s.sub('.', '_')}_#{params[:left].to_s.sub('.', '_')}_#{params[:top].to_s.sub('.', '_')}_#{params[:diffusion].to_s.sub('.', '_')}"
    params[:id] = "#{@id}_color_#{uniq_value}".to_sym
  end
  params
end
new({ post: :color }) do |p|
  Atome.global_monitoring(self, [:red, :blue, :blue, :alpha, :left, :right, :diffusion], [:variable1, :variable2])
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

new({ atome: :shadow, type: :hash })

new({ atome: :raw })
new({ atome: :shape })
new({ atome: :code })
new({ atome: :audio })
new({ atome: :element })
new({ sanitizer: :element }) do |params|
  default_params = { data: '' }
  default_params.merge!(params)
end

new({ atome: :animation })
new({ atome: :group })
new({ atome: :text, type: :hash })
new({ post: :text }) do |params|
  data_found= params[:data]
  if data_found.instance_of? Array
    data_found.each_with_index do |data_found, index|
      # we treat the first element
      if index == 0
        send(:data, data_found)
      else
        # we create new text's atome attached to the main one (the first element above)
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
# new({ atome: :physical })
new({ atome: :human }) do |params|
  Universe.add_user = params[:id]
end
new({ atome: :machine })
new({ atome: :generator }) do |params|
  # we remove build and store it in a temporary particle  as it has to be added after atome creation
  build = params.delete(:build)
  params[:temporary] = { build: build }
end
new({ post: :generator }) do |params|
  build_plans = params[:temporary][:build]
  grab(params[:id]).build(build_plans)
end

