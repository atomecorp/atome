class Atome

  def set_shape(params)
    @atome = params
  end

  def initialize(params = {}, &bloc)
    params[:bloc] = bloc
    send("set_#{params[:type]}", params)
  end

  def set_particle val, &bloc
    val[:bloc]=bloc
    @particle = val
  end

  def left value = nil, &bloc
    if value
      # TODO :  sanitize the particle
      # FIXME : for now we impose value
      @atome[:left] =   {value:  value, bloc: bloc }
    else
      get_left
    end
  end

  def get_left
    Atome.new({ type: :particle, particle: :left, value: @atome[:left] })
  end

  def color value = nil, &bloc
    if value
      # TODO :  sanitize the particle
      @atome[:color] ={red:  value, bloc: bloc }
    else
      get_color
    end
  end

  def get_color
    Atome.new({ type: :particle, particle: :color, value: @atome[:color] })
  end

  def value
    { id: @particle[:value].keys[0] }.merge(@particle[:value].values[0])
  end

  def values
    values = {}
    @particle[:value].each do |k, v|
      values[k] = v
    end
    values
  end

  def to_s
    inspect
  end
end

a = Atome.new({ type: :shape, left: { a_00: { value: 33 }, a_01: { value: 66 } }, color: { a1: { red: 1, green: 0 }, a2: { red: 0.3, green: 0 } } }) do
  puts 'So coll!!'
end
a.color(:red) do
  puts "Super!!!"
end

puts '---------'
puts a
puts '---------'

puts a.color
# puts "a.color : #{a.color}"
# puts "a.color.class : #{a.color.class}"
# puts "a.color.values : #{a.color.values}"
# puts "a.left.values : #{a.left.values}"
# puts "a.color.value : #{a.color.value}"
# puts "a.left.value : #{a.left.value}"
# puts a.left.values
# puts a.get_color
# a.left(666)
a.left(999) do
  puts 'it works!!'
end
puts a.left

puts '------'
puts a
