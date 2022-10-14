# frozen_string_literal: true
# TODO: params shouldn't be merge but they must respect the order

class Atome
  def box(params = {})
    default_renderer=Sanitizer.default_params[:render]
    generated_id = params[:id] || "box_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    temp_default = { render: [generated_render], id: generated_id, type: :shape, parent: generated_parent, width: 99, height: 99, left: 9, top: 9,
                     color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                              red: 0.69, green: 0.69, blue: 0.69, alpha: 1 } }
    params = temp_default.merge(params)
    Atome.new(params)
  end

  def circle(params = {})
    default_renderer=Sanitizer.default_params[:render]

    generated_id = params[:id] || "circle_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    temp_default = { render: [generated_render], id: generated_id, type: :shape, parent: generated_parent, width: 99, height: 99, left: 9, top: 9,
                     color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                              red: 0.69, green: 0.69, blue: 0.69, alpha: 1 }, smooth: "100%" }
    params = temp_default.merge(params)

    Atome.new(params)

  end
end

def box(params = {})
  Utilities.grab(:view).box(params)
end

def circle(params = {})
  Utilities.grab(:view).circle(params)
end