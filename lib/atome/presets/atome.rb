# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear

class Atome
  def atome_common(atome_preset, params)

    basic_params = { renderers: [] }
    # TODO : optimise the whole code below and make it rubocop friendly
    essential_params = Essentials.default_params[atome_preset] || {}
    basic_params[:type] = essential_params[:type] || :element
    # condition to handle color's atome that shouldn't be attach to view
    if params[:type] == :color || basic_params[:type] == :color
      params[:affect] = [id]
    else
      params[:attach] = [id] # if essential_params[:attach] && essential_params[:attach][0] == nil
    end

    params[:attached] = [] unless params[:attached]

    basic_params[:id] = params[:id] || identity_generator(atome_preset)
    basic_params[:attach] = params[:attach] || [@atome[:id]] || [:view]

    basic_params[:renderers] = @atome[:renderers] || essential_params[:renderers]

    essential_params = basic_params.merge(essential_params)

    essential_params.merge(params)
  end

  def preset_common(params, &bloc)
    params[:attached] = [] unless params[:attached]
    Atome.new(params, &bloc)
  end

  def box(params = {}, &bloc)
    atome_preset = :box
    params = atome_common(atome_preset, params)
    preset_common(params, &bloc)
  end

  def circle(params = {}, &bloc)
    atome_preset = :circle
    params = atome_common(atome_preset, params)
    preset_common(params, &bloc)
  end

  def vector(params = {}, &bloc)
    atome_preset = :vector
    params = atome_common(atome_preset, params)
    preset_common(params, &bloc)
  end

end



