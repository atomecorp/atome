# frozen_string_literal: true

generator = Genesis.generator

generator.build_atome(:animation)
generator.build_atome(:color)
generator.build_sanitizer(:color) do |params|
  parent_found = found_parents_and_renderers[:parent]
  parent_found = [:black_matter] if parent_found == [:view]
  render_found = found_parents_and_renderers[:renderers]
  default_params = { renderers: render_found, id: "color_#{Universe.atomes.length}", type: :color,
                     attach: parent_found,
                     red: 0, green: 0, blue: 0, alpha: 1 }
  params = create_color_hash(params) unless params.instance_of? Hash
  new_params = default_params.merge!(params)
  atome[:color] = new_params
  new_params
end

generator.build_sanitizer(:video) do |params|
  parent_found = found_parents_and_renderers[:parent]
  render_found = found_parents_and_renderers[:renderers]
  default_params = { renderers: render_found, id: "video_#{Universe.atomes.length}", type: :video,
                     parents: parent_found }
  default_params.merge!(params)
end
generator.build_atome(:shadow)

generator.build_sanitizer(:shadow) do |params|
  parent_found = found_parents_and_renderers[:parent]
  parent_found = [:user_view] if parent_found == [:view]
  render_found = found_parents_and_renderers[:renderers]
  default_params = { renderers: render_found, id: "shadow_#{Universe.atomes.length}", type: :shadow,
                     attach: parent_found,
                     red: 0, green: 0, blue: 0, alpha: 1, blur: 3, left: 3, top: 3 }
  default_params.merge!(params)
end
generator.build_atome(:shape)
generator.build_atome(:text)
generator.build_atome(:image)
generator.build_atome(:video)
generator.build_atome(:code)
generator.build_atome(:audio)
generator.build_atome(:element)
generator.build_atome(:web)
generator.build_sanitizer(:element) do |params|
  parent_found = found_parents_and_renderers[:parent]
  render_found = []
  default_params = { renderers: render_found, id: "element_#{Universe.atomes.length}", type: :element,
                     parents: parent_found, data: '' }
  default_params.merge!(params)
end

generator.build_atome(:collector)

generator.build_sanitizer(:web) do |params|
  default_renderer = Essentials.default_params[:render_engines]

  generated_id = params[:id] || "web_#{Universe.atomes.length}"
  generated_render = params[:renderers] || default_renderer
  generated_parents = params[:parents] || id.value
  # TODO : the line below should get the value from default params Essentials
  temp_default = { renderers: generated_render, id: generated_id, type: :web, parents: [generated_parents],
                   children: [], width: 120, height: 120, path: 'https://www.youtube.com/embed/usQDazZKWAk' }
  params = temp_default.merge(params)
  params
end

generator.build_sanitizer(:animation) do |params|
  default_renderer = Essentials.default_params[:render_engines]
  atome_type = :animation
  generated_render = params[:renderers] || default_renderer
  generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
  generated_parents = params[:parents] || []
  generated_children = params[:children] || []
  params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
  params
end

generator.build_sanitizer(:image) do |params|
  unless params.instance_of? Hash
    # TODO : we have to convert all image to png or maintain a database with extension
    params = { path: "./medias/images/#{params}" }
  end
  default_renderer = Essentials.default_params[:render_engines]
  generated_id = params[:id] || "image_#{Universe.atomes.length}"
  generated_render = params[:renderers] || default_renderer
  generated_parents = params[:parents] || id.value
  # TODO : the line below should get the value from default params Essentials
  temp_default = { renderers: generated_render, id: generated_id, type: :image, parents: [generated_parents],
                   children: [], width: 99, height: 99, path: './medias/images/atome.svg' }
  params = temp_default.merge(params)
  params
end
generator.build_sanitizer(:text) do |params|
  params = { data: params } unless params.instance_of? Hash
  default_renderer = Essentials.default_params[:render_engines]
  atome_type = :text
  generated_render = params[:renderers] || default_renderer
  generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
  generated_parents = params[:parents] || [id.value]
  generated_children = params[:children] || []
  params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
  params
end
