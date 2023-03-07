# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear

class Atome
  def atome_common(atome_type, params)
    essential_params = Essentials.default_params[atome_type] || {}
    if @atome
      essential_params[:parents] = params[:attach] || [@atome[:id]]
      essential_params[:renderers] = essential_params[:renderers] || @atome[:renderers]
    else
      essential_params[:parents] = []
      essential_params[:renderers] = Essentials.default_params[:render_engines]
    end
    essential_params[:attach] = essential_params[:parents]
    essential_params[:id] = params[:id] || identity_generator(atome_type)
    essential_params[:type] = essential_params[:type] || :element
    essential_params[:clones] = []
    essential_params.merge(params)
  end

  def box(params = {}, &bloc)
    # default_renderer = Essentials.default_params[:render_engines]
    atome_type = :box
    # generated_render = params[:renderers] || default_renderer
    # generated_id = params[:id] || identity_generator(:box)
    # generated_parents = params[:attach] || [id.value]
    params = atome_common(atome_type, params)
    Atome.new({ atome_type => params }, &bloc)
  end

  def circle(params = {}, &bloc)
    # default_renderer = Essentials.default_params[:render_engines]
    atome_type = :circle
    # generated_render = params[:renderers] || default_renderer
    # generated_id = params[:id] || identity_generator(:circle)
    # generated_parents = params[:attach] || [id.value]
    params = atome_common(atome_type, params)
    Atome.new({ atome_type => params }, &bloc)
  end

end
