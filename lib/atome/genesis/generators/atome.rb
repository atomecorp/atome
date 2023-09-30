# frozen_string_literal: true
new({ atome: :color, type: :hash })
new({ sanitizer: :color }) do |params|
  params = create_color_hash(params) unless params.instance_of? Hash
  # the condition below is  to prevent the creation of multiple unwanted colors with same property and no ID specified
  unless params[:id]
    uniq_value = "#{params[:red].to_s.sub('.', '_')}_#{params[:green].to_s.sub('.', '_')}_#{params[:blue].to_s.sub('.', '_')}_#{params[:alpha].to_s.sub('.', '_')}_#{params[:left].to_s.sub('.', '_')}_#{params[:top].to_s.sub('.', '_')}_#{params[:diffusion].to_s.sub('.', '_')}"
    params[:id] = "#{@atome[:id]}_color_#{uniq_value}".to_sym
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
# new({ sanitizer: :www }) do |params|
#   alert params
#   # TODO : the line below should get the value from default params Essentials
#   temp_default = { path: 'https://www.youtube.com/embed/usQDazZKWAk' }
#   params = temp_default.merge(params)
#   params
# end
new({ atome: :shadow, type: :hash })
new({ sanitizer: :shadow }) do |params|
  # TODO : when attaching color to a shadow it should colorized it , cf : c.shadow({color: :blue}) should work
  params = {} unless params.instance_of? Hash
  default_params = { red: 0, green: 0, blue: 0, alpha: 1, blur: 3, left: 3, top: 3 }
  new_params = default_params.merge!(params)
  new_params
end
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
new({ post: :text }) do |params, current_atome|
  if @data.instance_of? Array
    @data.each_with_index do |data_found, index|
      # we treat the first element
      if index == 0
        current_atome.send(:data, data_found)
      else
        # we create new text's atome attached to the main one (the first element above)
        current_atome.text(data_found)
      end

    end
  else
    current_atome.send(:data, @data)
  end
  params
end
new({ sanitizer: :text }) do |params|
  # to allow text api with the form text(:hello) instead of text({data: :hello})
  params = { data: params } unless params.instance_of? Hash
  # we delete and store the data for later analysis in:  "post: :text"
  @data = params.delete(:data)
  params
end
# for later use ( physical is a css like style)
new ({ atome: :physical })
