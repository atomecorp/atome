# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear

# additional Atome methods
class Atome
  def atome_common(atome_preset, params)
    basic_params = { renderers: [] }
    # TODO : remove Essentials.default_params[atome_preset] || {} as it is
    # applyied twice because preset is now a particle
    essential_params = Essentials.default_params[atome_preset] || {}
    basic_params[:type] = essential_params[:type] || :element
    basic_params[:id] = params[:id] || identity_generator(atome_preset)
    basic_params[:renderers] = @renderers || essential_params[:renderers]
    essential_params = basic_params.merge(essential_params)
    reordered_params = essential_params.reject { |key, _| params.has_key?(key) }
    params = reordered_params.merge(params)
    # condition to handle color/shadow/paint atomes that shouldn't be attach to view
    if params[:type] == :color || params[:type] == :shadow || params[:type] == :paint
      params[:affect] = [id] unless params[:affect]
    else
      params[:attach] = params[:attach] || [@id] || [:view]
    end

    params
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



