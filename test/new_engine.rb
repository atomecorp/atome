# frozen_string_literal: true

# main atome class
class Atome

  def initialize(params = {}, &bloc)
    params[:bloc] = bloc if bloc
    params[:child] = [] unless params[:child]
    params[:render] = [] unless params[:child]
    params[:html_type] = :unset unless params[:child]
    send("#{params[:type]}_setter", params)
  end

  def atome_setter(params)
    puts "rendering atome : #{params[:model]} with id : #{params[:id]}"
    @atome = params
  end

  def particle_setter(params, &bloc)
    puts "rendering particle : #{params[:particle]}, #{params[:value]}"
    params[:bloc] = bloc if bloc
    @atome = params
  end

  # def shape_setter(params)
  #   @atome = params
  # end

  ###################### to meta-programming ######################

  def left(value = nil, &bloc)
    if value
      # TODO :  sanitize the particle
      # FIXME : for now we impose value waiting for the sanitizer to be finished
      @atome[:left] = { red: value, bloc: bloc }.compact
    else
      left_getter
    end
  end

  def left_getter
    Atome.new({ type: :particle, particle: :left, value: @atome[:left] })
  end

  ######

  def color(value = nil, &bloc)
    if value
      # TODO :  sanitize the particle
      # FIXME : for now we impose value waiting for the sanitizer to be finished
      @atome[:color] = { red: value, bloc: bloc }.compact
    else
      color_getter
    end
  end

  def color_getter
    Atome.new({ type: :particle, particle: :color, value: @atome[:color] })
  end

  ######

  def model(value = nil, &bloc)
    if value
      # TODO :  sanitize the particle
      # FIXME : for now we impose value waiting for the sanitizer to be finished
      @atome[:model] = { value: value, bloc: bloc }.compact
    else
      color_getter
    end
  end

  def model_getter
    Atome.new({ type: :particle, particle: :model, value: @atome[:color] })
  end

  ###################### Outputs ######################

  def value
    { id: @atome[:value].keys[0] }.merge(@atome[:value].values[0])
    # @atome[:value]
    # @atome

  end

  def values
    values = {}
    @atome[:value].each do |k, v|
      values[k] = v
    end
    values
  end

  def to_s
    inspect
  end
end

a = Atome.new({ type: :atome, model: :shape, id: :a000, left: { a00: { value: 33 }, a01: { value: 66 } },
                color: { a1: { red: 1, green: 0 }, a2: { red: 0.3, green: 0 } } }) do
  puts 'So coll!!'
end

# attention the code below work but crash .value because of it's corrupt format


# a.left(999)

# puts a
# puts a.left
puts a.left.value
puts a.model.value

# puts a.color
# puts "a.color : #{a.color}"
# puts "a.color.class : #{a.color.class}"
# puts "a.color.values : #{a.color.values}"
# puts "a.left.values : #{a.left.values}"
# puts "a.color.value : #{a.color.value}"
# puts "a.left.value : #{a.left.value}"
# puts a.left.values
# puts a.get_color
# a.left(666)
# a.left(999) do
#   puts 'it works!!'
# end
# puts a.left
a.color(:red) do
  puts 'hello world'
end
puts a
