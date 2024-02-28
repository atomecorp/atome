# frozen_string_literal: true
new({ atome: :color, type: :hash }) do |params|
  # # TODO : hack must call it properly thru renderer
  # if params[:affect]
  #   params[:affect].each do |affected|
  #     grab(affected).html.reset_background
  #   end
  # end

end

# new ({post: :color}) do |params|
#   # # TODO : hack must call it properly thru renderer
#   # params[:affect].each do |affected|
#   #   grab(affected).html.reset_background
#   # end
# end
new({ sanitizer: :color }) do |params|
  params = create_color_hash(params) unless params.instance_of? Hash
  # the condition below is to prevent the creation of multiple unwanted colors with same property and no ID specified
  unless params[:id]
    uniq_value = "#{params[:red].to_s.sub('.', '_')}_#{params[:green].to_s.sub('.', '_')}_#{params[:blue].to_s.sub('.', '_')}_#{params[:alpha].to_s.sub('.', '_')}_#{params[:left].to_s.sub('.', '_')}_#{params[:top].to_s.sub('.', '_')}_#{params[:diffusion].to_s.sub('.', '_')}"
    params[:id] = "#{@id}_color_#{uniq_value}".to_sym
  end
  params
end
# new({ post: :color }) do
#   Atome.global_monitoring(self, [:red, :blue, :blue, :alpha, :left, :right, :diffusion], [:variable1, :variable2])
# end
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
  data_found = params[:data]
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
new({ atome: :human }) do |params|
  Universe.add_user = params[:id]
end
new({ atome: :machine })
new({ atome: :paint })
new({ atome: :vector })

new({ atome: :matrix })
new({ atome: :atomized, type: :hash })

# new({ atome: :color, type: :model })
# new({ atome: :color, type: :template })



