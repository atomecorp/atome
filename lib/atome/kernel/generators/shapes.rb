# frozen_string_literal: true
# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
class Atome
  def box(params = {}, &bloc)
    default_renderer = Sanitizer.default_params[:render]
    generated_id = params[:id] || "box_#{Universe.atomes.length}"
    generated_render = params[:render] || default_renderer unless params[:render].instance_of? Hash
    generated_parent = params[:parent] || id

    temp_default = { render: [generated_render], id: generated_id,  type: :shape, parent: [generated_parent], width: 99, height: 99,
                     color: { render: [generated_render], id: "color_#{generated_id}", type: :color,
                              red: 0.69, green: 0.69, blue: 0.69, alpha: 1 } }
    params = temp_default.merge(params)
    new_atome = Atome.new({ shape: params},&bloc )
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
    new_atome = Atome.new({ shape: params },&bloc)
    new_atome.shape
  end

end

def box(params = {}, &proc)
  Utilities.grab(:view).box(params,&proc)
end

def circle(params = {}, &proc)
  Utilities.grab(:view).circle(params,&proc)
end

def text(params = {}, &bloc)
  Utilities.grab(:view).text(params, &bloc)
end

def image(params = {}, &bloc)
  Utilities.grab(:view).image(params, &bloc)
end

def video(params = {}, &bloc)
  Utilities.grab(:view).video(params, &bloc)
end



def drag(params = {}, &bloc)
  Utilities.grab(:view).drag(params, &bloc)
end