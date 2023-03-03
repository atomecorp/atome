# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear


class Atome
  def atome_common(atome_type, generated_id, generated_render, generated_parents,  params)
    temp_default = Essentials.default_params[atome_type] || {}
    temp_default[:id] = generated_id
    temp_default[:attach] = generated_parents
    temp_default[:clones] = []
    temp_default[:renderers] = generated_render
    temp_default.merge(params)
  end

  def box(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :box
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || identity_generator(:box)
    generated_parents = params[:attach] || [id.value]
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    Atome.new({ atome_type => params }, &bloc)
  end

  def circle(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :circle
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || identity_generator(:circle)
    generated_parents = params[:attach] || [id.value]
    params = atome_common(atome_type, generated_id, generated_render, generated_parents,  params)
    Atome.new({ atome_type => params }, &bloc)
  end

end
