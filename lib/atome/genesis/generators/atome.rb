# frozen_string_literal: true

new({ atome: :color })

new({ sanitizer: :color }) do |params|
  parent_found = found_parents_and_renderers[:parent]
  if parent_found == [:view]
    parent_found = [:black_matter] if parent_found == [:view]
  elsif color.value
    # we delete any previous color if there's one
    detached(color.value)
    grab(color.value)&.delete(true)# we had the condition because the color may exist but
    # so it is not sanitized so it has no id
  end

  render_found = found_parents_and_renderers[:renderers]
  generated_id = params[:id] || identity_generator(:color)

  default_params = { renderers: render_found, id: generated_id, type: :color,
                     attach: parent_found,
                     red: 0, green: 0, blue: 0, alpha: 1 }
  params = create_color_hash(params) unless params.instance_of? Hash
  new_params = default_params.merge!(params)
  atome[:color] = new_params[:id]
  new_params
end

new({ atome: :image })
new({ sanitizer: :image }) do |params|
  unless params.instance_of? Hash
    # TODO : we have to convert all image to png or maintain a database with extension
    params = { path: "./medias/images/#{params}" }
  end
  default_renderer = Essentials.default_params[:render_engines]
  generated_id = params[:id] || identity_generator(:image)

  generated_render = params[:renderers] || default_renderer
  generated_parents = params[:parents] || id.value
  # TODO : the line below should get the value from default params Essentials
  temp_default = { renderers: generated_render, id: generated_id, type: :image, parents: [generated_parents],
                   children: [], width: 99, height: 99, path: './medias/images/atome.svg' }
  params = temp_default.merge(params)
  params
end
new({ atome: :video })
new({ sanitizer: :video }) do |params|
  parent_found = found_parents_and_renderers[:parent]
  render_found = found_parents_and_renderers[:renderers]
  generated_id = params[:id] || identity_generator(:video)

  default_params = { renderers: render_found, id: generated_id, type: :video,
                     parents: parent_found }
  default_params.merge!(params)
end
new({ atome: :shadow })
new({ sanitizer: :shadow }) do |params|

  parent_found = found_parents_and_renderers[:parent]
  if parent_found == [:view]
    parent_found = [:black_matter] if parent_found == [:view]
  elsif shadow.value
    # we delete any previous color if there's one
    detached(shadow.value)
    grab(shadow.value)&.delete(true)# we had the condition because the shadow may exist but
    # so it is not sanitized so it has no id
  end
  ## we delete any previous shadow if there's one
  # if shadow.value
  #   attached.value.delete(shadow.value)
  #   grab(shadow.value)&.delete(true) # we had the condition because the color may exist but 
  #   # so it is not sanitized so it has no id
  # end
  # parent_found = found_parents_and_renderers[:parent]
  # parent_found = [:user_view] if parent_found == [:view]
  render_found = found_parents_and_renderers[:renderers]
  generated_id = params[:id] || identity_generator(:shadow)

  default_params = { renderers: render_found, id: generated_id, type: :shadow,
                     attach: parent_found,
                     red: 0, green: 0, blue: 0, alpha: 1, blur: 3, left: 3, top: 3 }
  # default_params.merge!(params)
  params = create_shadow_hash(params) unless params.instance_of? Hash
  new_params = default_params.merge!(params)
  atome[:shadow] = new_params
  new_params

end
new({ atome: :shape })
new({ atome: :code })
new({ atome: :audio })
new({ atome: :element })
new({ sanitizer: :element }) do |params|
  parent_found = found_parents_and_renderers[:parent]
  render_found = []
  generated_id = params[:id] || identity_generator(:element)

  default_params = { renderers: render_found, id: generated_id, type: :element,
                     parents: parent_found, data: '' }
  default_params.merge!(params)
end
new({ atome: :web })
new({ sanitizer: :web }) do |params|
  default_renderer = Essentials.default_params[:render_engines]
  generated_id = params[:id] || identity_generator(:web)

  generated_render = params[:renderers] || default_renderer
  generated_parents = params[:parents] || id.value
  # TODO : the line below should get the value from default params Essentials
  temp_default = { renderers: generated_render, id: generated_id, type: :web, parents: [generated_parents],
                   children: [], width: 120, height: 120, path: 'https://www.youtube.com/embed/usQDazZKWAk' }
  params = temp_default.merge(params)
  params
end
new({ atome: :collector })
new({ atome: :animation })
new({ sanitizer: :animation }) do |params|
  default_renderer = Essentials.default_params[:render_engines]
  atome_type = :animation
  generated_render = params[:renderers] || default_renderer
  generated_id = params[:id] || identity_generator(atome_type)
  generated_parents = params[:parents] || []
  generated_children = params[:children] || []
  params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
  params
end
new({ atome: :text })
new({ sanitizer: :text }) do |params|
  params = { data: params } unless params.instance_of? Hash
  default_renderer = Essentials.default_params[:render_engines]
  atome_type = :text
  generated_render = params[:renderers] || default_renderer
  generated_id = params[:id] || identity_generator(atome_type)
  generated_parents = params[:parents] || [id.value]
  generated_children = params[:children] || []
  params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
  params
end

