# frozen_string_literal: true
# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
class Atome
  def box(params = {})
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "box_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    temp_default = { render: [generated_render], id: generated_id, type: :shape, parent: [generated_parent], width: 99, height: 99, left: 9, top: 9,
                     color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                              red: 0.69, green: 0.69, blue: 0.69, alpha: 1 } }
    params = temp_default.merge(params)
    new_atome = Atome.new({ shape: params })
    new_atome.shape
  end

  def circle(params = {})
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "circle_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    temp_default = { render: [generated_render], id: generated_id, type: :shape, parent: [generated_parent], width: 99, height: 99, left: 9, top: 9,
                     color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                              red: 0.69, green: 0.69, blue: 0.69, alpha: 1 }, smooth: "100%" }
    params = temp_default.merge(params)
    new_atome = Atome.new({ shape: params })
    new_atome.shape
  end

  def write(params = {})
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "text_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    temp_default = { render: [generated_render], id: generated_id, type: :text, parent: [generated_parent],
                     visual: { size: 33 }, data: "hello world", left: 39, top: 33, width: 199, height: 33,
                     color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                              red: 0.09, green: 1, blue: 0.12, alpha: 1 }}

    params = temp_default.merge(params)
    new_atome = Atome.new({ text: params })
    new_atome.text
  end
end

def box(params = {})
  Utilities.grab(:view).box(params)
end

def circle(params = {})
  Utilities.grab(:view).circle(params)
end

def write_text(params = {})
  Utilities.grab(:view).write(params)
end