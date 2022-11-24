# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below

# shaper creation
class Atome
  def box(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]

    generated_id = params[:id] || "box_#{Universe.atomes.length}"
    generated_render = params[:renderers] || default_renderer
    generated_parents = params[:parents] || id.value

    temp_default = { renderers: generated_render, id: generated_id, type: :shape, parents: [generated_parents],
                     children: [], width: 99, height: 99,
                     color: { renderers: generated_render, id: "color_#{generated_id}", type: :color, children: [],
                              parents: [generated_id], red: 0.69, green: 0.69, blue: 0.69, alpha: 1 } }
    params = temp_default.merge(params)
    Atome.new({ shape: params }, &bloc)
  end

  def circle(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    generated_id = params[:id] || "circle_#{Universe.atomes.length}"
    generated_render = params[:renderers] || default_renderer
    generated_parents = params[:parents] || id.value

    temp_default = { renderers: generated_render, id: generated_id, type: :shape, parents: [generated_parents],
                     children: [], width: 99, height: 99,
                     color: { renderers: generated_render, id: "color_#{generated_id}", type: :color, children: [],
                              parents: [generated_id], red: 0.69, green: 0.69, blue: 0.69, alpha: 1 }, smooth: '100%' }
    params = temp_default.merge(params)
    Atome.new({ shape: params }, &bloc)
  end

  def image(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]

    generated_id = params[:id] || "image_#{Universe.atomes.length}"
    generated_render = params[:renderers] || default_renderer
    generated_parents = params[:parents] || id.value

    temp_default = { renderers: generated_render, id: generated_id, type: :image, parents: [generated_parents],
                     children: [], width: 99, height: 99, path: './medias/images/atome.svg' }
    params = temp_default.merge(params)
    Atome.new({ shape: params }, &bloc)
  end
end
