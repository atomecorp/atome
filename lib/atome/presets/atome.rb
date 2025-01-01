# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear

# additional Atome methods
class Atome
  def atome_common(preset_list, params)

    basic_params = { renderers: [] }
    # TODO : remove Essentials.default_params[preset_list] || {} as it is
    # applied twice because preset is now a particle
    preset_params = Essentials.default_params[preset_list] || {}
    basic_params[:type] = preset_params[:type] || :element
    basic_params[:id] = params[:id] || identity_generator
    basic_params[:renderers] = @renderers || preset_params[:renderers]
    essential_params = basic_params.merge(preset_params)
    reordered_params = essential_params.reject { |key, _| params.has_key?(key) }
    params = reordered_params.merge(params)
    params[:id] = params[:id].to_sym
    # condition to handle color/shadow/paint atomes that shouldn't be attach to view
    if Universe.applicable_atomes.include?(preset_list)
      unless params[:affect]
        params[:affect] = if @id == :view
                            [:black_matter]
                          else
                            [@id]
                          end
      end
    else
      params[:attach] = params[:attach] || @id || :view
    end
    # we reorder the hash
    reorder_particles(params)
  end

  def preset_common(params, &bloc)
    Atome.new(params, &bloc)
  end

end



