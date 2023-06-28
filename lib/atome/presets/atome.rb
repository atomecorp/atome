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
    essential_params[:renderers] = essential_params[:renderers] || @atome[:renderers]
    essential_params[:id] = params[:id] || identity_generator(atome_preset)
#     alert "self: #{self.id}
# attach => #{params[:id]}"
#     if  essential_params[:type] ==:group
#
#     else
      essential_params[:attach] = params[:attach] || [@atome[:id]] || [:view]
    # end

    # essential_params[:attach] = params[:attach] || [@atome[:id]] || [:view]

    if params[:definition]
      # if it is a vector we reorder the params
      attached = params.delete(:attached)
      params = params.merge({ attached: attached })
    end
    # puts "=> params too : #{essential_params.merge(params)}"
    # alert essential_params.merge(params)
    essential_params.merge(params)
  end

  def box(params = {}, &bloc)
    atome_preset = :box
    params = atome_common(atome_preset, params)
    # b= send(params[:type],params , &bloc)
  Atome.new({ atome_preset => params }, &bloc)

  end



  def circle(params = {}, &bloc)
    atome_preset = :circle
    params = atome_common(atome_preset, params)
    # send(params[:type],params , &bloc)
    Atome.new({ atome_preset => params }, &bloc)
    # new_atome=Atome.new({ atome_preset => params }, &bloc)
    # alert self
    # self.attached(new_atome.id)
    # new_atome
    # # new_atome.attach(self.id)
  end


  def vector(params = {}, &bloc)
    atome_preset = :vector
    params = atome_common(atome_preset, params)
    # send(params[:type],params, &bloc )
    Atome.new({ atome_preset => params }, &bloc)


  end

end



