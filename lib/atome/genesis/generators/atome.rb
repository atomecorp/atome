# frozen_string_literal: true

generator = Genesis.generator

generator.build_atome(:animation)
generator.build_atome(:color)
generator.build_sanitizer(:color) do |params|
  parent_found = found_parents_and_renderers[:parent]
  render_found = found_parents_and_renderers[:renderers]
  default_params = { renderers: render_found, id: "color_#{Universe.atomes.length}", type: :color,
                     parents: parent_found,
                     red: 0, green: 0, blue: 0, alpha: 1 }
  params = create_color_hash(params) unless params.instance_of? Hash
  default_params.merge!(params)
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
  render_found = found_parents_and_renderers[:renderers]
  default_params = { renderers: render_found, id: "shadow_#{Universe.atomes.length}", type: :shadow,
                     parents: parent_found,
                     red: 0, green: 0, blue: 0, alpha: 1 , blur: 3, left: 3, top: 3}
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
                     parents: parent_found }
  default_params.merge!(params)
end
