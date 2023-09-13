# frozen_string_literal: true
new({ atome: :color, type: :hash })

new({ sanitizer: :color }) do |params|

  # if params.instance_of?(Array)
  #   #   alert alert "++++#{self}"
  #   params.each do |param|
  #     self.send(:color, param)
  #   end
  # else
  #   # TODO : when attaching color to a shadow it should colorized it , cf : c.shadow({color: :blue}) should work
  #   params = create_color_hash(params) unless params.instance_of? Hash
  #   params
  # end
  params = create_color_hash(params) unless params.instance_of? Hash
  # the condition below is  to prevent the creation of multiple unwanted colors with same property and no ID specified
  unless params[:id]
    uniq_value= "#{params[:red].to_s.sub('.','_')}_#{params[:green].to_s.sub('.','_')}_#{params[:blue].to_s.sub('.','_')}_#{params[:alpha].to_s.sub('.','_')}_#{params[:left].to_s.sub('.','_')}_#{params[:top].to_s.sub('.','_')}_#{params[:diffusion].to_s.sub('.','_')}"
    params[:id]="#{@atome[:id]}_color_#{uniq_value}"
  end
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
  # TODO : when attaching color to a shadow it should colorized it , cf : c.shadow({color: :blue}) should work
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
new({ atome: :www })
new({ sanitizer: :www }) do |params|
  # TODO : the line below should get the value from default params Essentials
  temp_default = { path: 'https://www.youtube.com/embed/usQDazZKWAk' }
  params = temp_default.merge(params)
  params
end
# new({ atome: :collector })
# new({ atome: :collection })
new({ atome: :animation })
new({ atome: :text, type: :hash })
new({ sanitizer: :text }) do |params|
  if params[:data].instance_of? Array
    params
    additional_data = params.reject { |cle| cle == :data }
    data_found = params[:data]
    parent_text = ''
    data_found.each_with_index do |atome_to_create, index|
      unless atome_to_create.instance_of? Hash
        atome_to_create = { data: atome_to_create, width: :auto }
      end
      if index == 0
        parent_text = text(atome_to_create)
        parent_text.set(additional_data)
      else
        parent_text.text(atome_to_create)
      end
    end
    params = { data: '' }
  else
    params = { data: params } unless params.instance_of? Hash
  end
  params
end

# new({ atome: :group, type: :array, render: false })
#
#
# new({ sanitizer: :group }) do |params|
#
#   sanitized_params = if params.instance_of? Array
#                        # the group renderers is found in : Genesis/group/group.rb
#                        { data: params, attach: [:view] }
#                      elsif params.instance_of? Hash
#                        params
#                      else
#                        { data: [params], attach: [:view]}
#                      end
#   sanitized_params
# end


