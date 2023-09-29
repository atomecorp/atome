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
    params[:attach] = id if essential_params[:attach] && essential_params[:attach][0] == nil
    params[:attached] = [] unless params[:attached]
    basic_params[:id] = params[:id] || identity_generator(atome_preset)
    basic_params[:attach] = params[:attach] || [@atome[:id]] || [:view]

    basic_params[:renderers] = @atome[:renderers] || essential_params[:renderers]

    essential_params = basic_params.merge(essential_params)

    essential_params.merge(params)
  end

  def preset_common(params, &bloc)
    result = params[:attach].detect do |attach_to_atome|
      atome_attach = grab(attach_to_atome)
      if atome_attach.type == :group
        params[:renderers].map! { |element| element == :group ? :browser : element }
        atome_attach.data.each_with_index do |group_item, index|
          params[:attach][params[:attach].length - 1] = group_item

          params[:id] = "#{params[:id]}_#{index}"
          grab(group_item).shape(params)
        end
        alert "group params are #{params}"
      end
      true
    end
    return unless result
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



