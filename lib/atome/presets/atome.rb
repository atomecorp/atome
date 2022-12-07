# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear

# shaper creation
class Atome
  def atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    temp_default = Essentials.default_params[atome_type] || {}
    temp_default[:id] = generated_id
    temp_default[:parents] = generated_parents
    temp_default[:renderers] = generated_render
    temp_default.merge(params)
  end

  def box(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :box
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
    generated_parents = params[:parents] || [id.value]
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    color_generated = sanitize(:color, { attach: [generated_id], red: 0.3, green: 0.3, blue: 0.3 })
    params[:color] = color_generated
    Atome.new({ atome_type => params }, &bloc)
  end

  def circle(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :circle
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
    generated_parents = params[:parents] || [id.value]
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    color_generated = sanitize(:color, { attach: [generated_id], red: 0.6, green: 0.6, blue: 0.6 })
    params[:color] = color_generated
    Atome.new({ atome_type => params }, &bloc)
  end

  def image(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]

    generated_id = params[:id] || "image_#{Universe.atomes.length}"
    generated_render = params[:renderers] || default_renderer
    generated_parents = params[:parents] || id.value
    # TODO : the line below should get the value from default params Essentials
    temp_default = { renderers: generated_render, id: generated_id, type: :image, parents: [generated_parents],
                     children: [], width: 99, height: 99, path: './medias/images/atome.svg' }
    params = temp_default.merge(params)
    Atome.new({ image: params }, &bloc)
  end

  def text(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :text
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
    generated_parents = params[:parents] || [id.value]
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    color_generated = sanitize(:color, { attach: [generated_id], red: 0.9, green: 0.9, blue: 0.9 })
    params[:color] = color_generated
    Atome.new({ atome_type => params }, &bloc)
  end

  def element(params = {}, &bloc)
    atome_type = :element
    generated_render = params[:renderers] || []
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
    generated_parents = params[:parents] || [id.value]
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    Atome.new({ atome_type => params }, &bloc)
  end

  def web(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]

    generated_id = params[:id] || "web_#{Universe.atomes.length}"
    generated_render = params[:renderers] || default_renderer
    generated_parents = params[:parents] || id.value
    # TODO : the line below should get the value from default params Essentials
    temp_default = { renderers: generated_render, id: generated_id, type: :web, parents: [generated_parents],
                     children: [], width: 120, height: 120, path: 'https://www.youtube.com/embed/usQDazZKWAk' }
    params = temp_default.merge(params)
    Atome.new({ image: params }, &bloc)
  end

  def animation(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :animation
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
    generated_parents = params[:parents] || []
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    Atome.new({ atome_type => params }, &bloc)
  end
end
