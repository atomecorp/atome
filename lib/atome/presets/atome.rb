# frozen_string_literal: true
# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below

# shaper creation
class Atome
  def box(params = {}, &bloc)

    default_renderer = Sanitizer.default_params[:render]

    generated_id = params[:id] || "box_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    temp_default = { render: [generated_render], id: generated_id, type: :shape, parent: [generated_parent],
                     width: 99, height: 99,top: 0, bottom: 9, right: 0,
                     color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                              parent: [generated_id], red: 0.69, green: 0.69, blue: 0.69, alpha: 1 } }
    params = temp_default.merge(params)
    new_atome = Atome.new({ shape: params }, &bloc)
    new_atome.shape
  end

  def circle(params = {}, &bloc)
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "circle_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    temp_default = { render: [generated_render], id: generated_id, type: :shape, parent: [generated_parent], width: 99, height: 99,
                     color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                              red: 0.69, green: 0.69, blue: 0.69, alpha: 1 }, smooth: "100%" }
    params = temp_default.merge(params)
    new_atome = Atome.new({ shape: params }, &bloc)
    new_atome.shape
  end

end