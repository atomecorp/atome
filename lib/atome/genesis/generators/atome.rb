# frozen_string_literal: true
new({ atome: :color, type: :hash })

new({ sanitizer: :color }) do |params|
  # TODO : when attaching color to a shadow it should colorized it , cf : c.shadow({color: :blue}) should work
  params = create_color_hash(params) unless params.instance_of? Hash
  params
end

new({ atome: :image })
new({ sanitizer: :image }) do |params|
  unless params.instance_of? Hash
    # TODO : we have to convert all image to png or maintain a database with extension
    # FIXME : temporary patch that add .png to the string if no extension is found
    if params.split('.').length == 1
      params = "#{params}.png"
    end

    params = { path: "./medias/images/#{params}" }
  end
  # TODO : the line below should get the value from default params Essentials
  params
end
new({ atome: :video })

new({ atome: :shadow, type: :hash })
new({ sanitizer: :shadow }) do |params|
  # TODO : when attaching color to a shadow it should colorised it , cf : c.shadow({color: :blue}) should work
  params = {} unless params.instance_of? Hash
  default_params = { red: 0, green: 0, blue: 0, alpha: 1, blur: 3, left: 3, top: 3 }
  new_params = default_params.merge!(params)
  new_params
end
new({ atome: :shape })
# new({ pre: :shape }) do |params|
#   if params[:definition]
#     # if it is a vector we reorder tha params
#     attached = params.delete(:attached)
#     params = params.merge({ attached: attached })
#   end
#
#   params
# end
new({ atome: :code })
new({ atome: :audio })
new({ atome: :element })
new({ sanitizer: :element }) do |params|
  default_params = { data: '' }
  default_params.merge!(params)
end
new({ atome: :web })
new({ sanitizer: :web }) do |params|
  # TODO : the line below should get the value from default params Essentials
  temp_default = { path: 'https://www.youtube.com/embed/usQDazZKWAk' }
  params = temp_default.merge(params)
  params
end
new({ atome: :collector })
new({ atome: :animation })
new({ atome: :text, type: :hash })
new({ sanitizer: :text }) do |params|
  params = { data: params } unless params.instance_of? Hash
  params
end
