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
    # applied twice because preset is now a particle
    preset_params = Essentials.default_params[atome_preset] || {}

    basic_params[:type] = preset_params[:type] || :element
    # basic_params[:aid] =  identity_generator(:a)
    basic_params[:id] = params[:id]|| identity_generator(atome_preset)
    basic_params[:renderers] = @renderers || preset_params[:renderers]
    essential_params = basic_params.merge(preset_params)
    #
    reordered_params = essential_params.reject { |key, _| params.has_key?(key) }
    params = reordered_params.merge(params)
    params[:id]=params[:id].to_sym
    # condition to handle color/shadow/paint atomes that shouldn't be attach to view
    # TODO : add category for atome( material/physical vs modifier : color, shadow, .. vs shape, image ..)
    # then add condition same things fo code in genesis new_atome
    if %i[color shadow paint].include?(atome_preset)
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
    # # we reorder the hash
    reordered_params =reorder_particles(params)
    reordered_params
  end

  def preset_common(params, &bloc)
    ## if an atome with current id exist we update the ID in the params
    # params[:id] = "#{params[:id]}_#{Universe.atomes.length}" if grab(params[:id])
    # if Universe.atomes[params[:id]]
    #   alert "atome found : #{ grab(params[:id])}"
    #   grab(params[:id])
    # else
    Atome.new(params, &bloc)
    # end
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
end



