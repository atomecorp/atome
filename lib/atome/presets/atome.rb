# frozen_string_literal: true

# TODO: params shouldn't be merge but they must respect the order
# TODO: Add default value for each methods below
# TODO: Factorise codes below
# TODO we must clarified/unified the usage of presets and sanitizer it is not clear

class Atome
  def atome_common(atome_preset, params)
    # TODO : optimise the whole code below and make it rubocop friendly
    essential_params = Essentials.default_params[atome_preset] || {}
    essential_params[:type] = essential_params[:type] || :element

    essential_params[:id] = params[:id] || identity_generator(atome_preset)

    essential_params[:attach] = params[:attach] || [@atome[:id]] || [:view]
    if params[:definition]
      # if it is a vector we reorder the params
      attached = params.delete(:attached)
      params = params.merge({ attached: attached })
    end
    essential_params[:renderers] = @atome[:renderers] || essential_params[:renderers]
    # puts "essential_params[:renderers]  : => #{essential_params[:renderers]}\n@atome[:renderers] : #{@atome[:renderers]}"

    # puts "params  : => #{params}\nessential_params : #{essential_params}"
    # now we replace the renderers in case this is not a group
    # unless essential_params[:type] == :group && essential_params[:renderers] == :group
    #   essential_params[:renderers] = @atome[:renderers]
    # end

    essential_params.merge(params)
  end

  def preset_common(params, &bloc)
    params[:attach].each do |attach_to_atome|
      # FIXME : may be this is the place to fix :
      #   when multiple  attach, it should be able to be displayed in every attached atome (atome.rb/atome_parsing)
      atome_attach = grab(attach_to_atome)
      if atome_attach.type == :group
        params[:renderers].map! { |element| element == :group ? :browser : element }
        atome_attach.data.each_with_index do |group_item, index|
          params[:attach][params[:attach].length - 1] = group_item
          params[:id] = "#{params[:id]}_#{index}"
          grab(group_item).shape(params)
        end
        alert "group params are #{params}"
        return Atome.new({ :element => params }, &bloc)
      else
        # alert "generic params are #{params}"
        return Atome.new({ :element => params }, &bloc)
      end
      return Atome.new({ :element => params }, &bloc)
    end
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



