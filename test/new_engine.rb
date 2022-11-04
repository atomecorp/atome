class Atome

  def shape(params)
    @atome = params
  end

  def initialize(params = {}, &bloc)
    @render = []
    @child = []
    @html_type = :unset
    # # TODO: check if we need to add properties for the root object before sending the params
    # puts params[:type]
    # puts "------"
    send(params[:type], params)
  end

  def left
    @atome[:left]
  end

  def right
    @atome[:right]
  end

  def particle
    @particle
  end

  def set_particle val
    # puts "the val is #{val}"
    @particle = val
  end

  def color
    Atome.new({ type: :set_particle, particle: :color, value: @atome[:color] })
  end

  def value
    ({id:  @particle[:value].keys[0] } ).merge(@particle[:value].values[0][:value])

  end

  def values
    values={}
    @particle[:value].each do |k,v|
      values[k]=v[:value]
      # puts k
      # puts ({ id: k }).merge(v[:value])
      #  puts "----"
    end
    values
  end

end

# a=Atome.new({type: :shape,left: [{ id: :a_0, value: 33 } ], color: [{id: :a_1, value: :red }, {id: :a_1, value: :green }]})

a = Atome.new({ type: :shape, left: { a_0: {value:  33 } }, color: { a1: { value: { red: 1, green: 0 } }, a2: {value: { red: 0.3, green: 0 }} } })

# puts "a.color : #{a.color}"
# puts "a.color.class : #{a.color.class}"
puts "a.color.values : #{a.color.values}"
puts "a.color.value : #{a.color.value}"
# a.color.each do |k,v|
#   puts "v is :#{v}"
# end