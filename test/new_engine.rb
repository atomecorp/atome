class Atome

  def shape(params)
    @atome=params
  end

  def initialize(params = {}, &bloc)
    @render = []
    @child = []
    @html_type = :unset
    # # TODO: check if we need to add properties for the root object before sending the params
    # puts params[:type]
    # puts "------"
    send(params[:type],params )
  end

  def left
    @atome[:left]
  end

  def right
    @atome[:right]
  end

  def particle val
    puts "the val is #{val}"
  end


  def color
    @particle= Atome.new({type: :particle,particle: :color, value: @atome[:color]} )
  end

  def value
    @particle
  end

  def values
    @particle
  end

  def to_s
    # values
  end


end

# a=Atome.new({type: :shape,left: [{ id: :a_0, value: 33 } ], color: [{id: :a_1, value: :red }, {id: :a_1, value: :green }]})

a=Atome.new({type: :shape,left: { a_0: 33 } , color:{a1: :red, a2: :green}})

# puts "a.color : #{a.color}"
# puts "a.color.class : #{a.color.class}"
# puts "a.color.values : #{a.color.values}"
puts "a.color.value : #{a.color.value}"
 # a.color.each do |k,v|
 #   puts "v is :#{v}"
 # end