# class Atome
#
#   def set_atome(params)
#     @atome = params
#   end
#
#   def initialize(params = {}, &bloc)
#     params[:bloc]=bloc
#     send("set_#{params[:type]}", params)
#   end
#
#   def set_left
#     @atome[:left]
#   end
#
#   def set_right
#     @atome[:right]
#   end
#
#   def set_particle val
#     # @atome = val
#   end
#
#   def set_color
#     @atome=Atome.new({ type: :particle, particle: :color, value: @atome[:color] })
#   end
#
#   def color
#     @atome
#   end
#
#   def value
#     ({ id: @atome[:value].keys[0] }).merge(@atome[:value].values[0][:value])
#   end
#
#   def values
#     values = {}
#     @atome[:value].each do |k, v|
#       values[k] = v[:value]
#     end
#     values
#   end
#   def to_s
#     @atome.inspect
#   end
#
# end
#
# a = Atome.new({ type: :atome,atome: :shape, left: { a_0: { value: 33 } }, color: { a1: { value: { red: 1, green: 0 } }, a2: { value: { red: 0.3, green: 0 } } } }) do
#   alert :kool
# end
# puts a.color
# # puts "a.color : #{a.color}"
# # puts "a.color.class : #{a.color.class}"
# # puts "a.color.values : #{a.color.values}"
# # puts "a.color.value : #{a.color.value}"
#
#  # a.particle(:hello)
# # a.color(:red) do ||
# #   alert :ok
# # end
# # puts a.color
# # puts a

#########################

class Atome

  def set_shape(params)
    @atome = params
  end

  def initialize(params = {}, &bloc)
    send("set_#{params[:type]}", params)
  end

  def set_particle val
    @atome = val
  end

  def left value = nil
    if value
      set_particle({ type: :particle, particle: :left, value: value })
    else
      get_left
    end
  end

  def get_left
    Atome.new({ type: :particle, particle: :left, value: @atome[:left] })
  end

  def color value = nil
    if value
      set_particle({ type: :particle, particle: :color, value: value })
    else
      get_color
    end
  end

  def get_color
    Atome.new({ type: :particle, particle: :color, value: @atome[:color] })
  end

  def value
    { id: @atome[:value].keys[0] }.merge(@atome[:value].values[0])
  end

  def values
    values = {}
    @atome[:value].each do |k, v|
      values[k] = v
    end
        # @atome
    values
  end

  def to_s
    @atome.inspect
  end
end

a = Atome.new({ type: :shape, left: { a_00: { value: 33 }, a_01: { value: 66 }  }, color: { a1: { red: 1, green: 0  }, a2: { red: 0.3, green: 0 }  } })

# puts "a.color : #{a.color}"
# puts "a.color.class : #{a.color.class}"
puts "a.color.values : #{a.color.values}"
puts "a.left.values : #{a.left.values}"
# puts "a.color.value : #{a.color.value}"
# puts "a.left.value : #{a.left.value}"
# puts a.left.values
# puts a.get_color
a.left(666)
puts a