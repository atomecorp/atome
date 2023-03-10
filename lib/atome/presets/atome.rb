# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear

class Atome
  def atome_common(atome_type, params)
    # TODO : optimise the whole code below and make it rubocop friendly
    essential_params = Essentials.default_params[atome_type] || {}
    essential_params[:type] = essential_params[:type] || :element
    essential_params[:renderers] = essential_params[:renderers] || @atome[:renderers]
    essential_params[:id] = params[:id] || identity_generator(atome_type)
    essential_params[:attach] = params[:attach] || [@atome[:id]] || [:view]
    essential_params.merge(params)
  end

  def box(params = {}, &bloc)
    atome_type = :box
    params = atome_common(atome_type, params)
    Atome.new({ atome_type => params }, &bloc)
  end

  def circle(params = {}, &bloc)
    atome_type = :circle
    params = atome_common(atome_type, params)
    Atome.new({ atome_type => params }, &bloc)
  end

end
