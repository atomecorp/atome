class Universe
  def self.creator(user)
    @user = user
    Atome.new({ universe: :universe })
  end

  def self.active_creator
    @user
  end

  def self.current_machine
    platform = RUBY_PLATFORM.downcase
    output = `#{(platform =~ /win32/) ? 'ipconfig /all' : 'ifconfig'}`
    case platform
    when /darwin/
      $1 if output =~ /en1.*?(([A-F0-9]{2}:){5}[A-F0-9]{2})/im
    when /win32/
      $1 if output =~ /Physical Address.*?(([A-F0-9]{2}-){5}[A-F0-9]{2})/im
      # Cases for other platforms...
    else
      nil
    end
  end

  def self.location
    :clermont
  end

  def self.identity_generator
    "#{@user}_#{current_machine}_#{location}_#{(Time.now.to_f * 1000).to_i}"
  end
end

class Atome
  def initialize(params)
    @atome = {}
    params.each do |property, value|
      @atome[property] = Particle.new(property, value)
    end
    @atome
  end

  def type
    @atome[:type]
  end

  # def preset
  #   @atome[:preset]
  # end

  def preset=(value)
    @atome[:preset] = Particle.new(:preset, value)
  end

  def add(params)
    params.each do |property, value|
      @atome[property] << { property => value }
    end
  end

  def put(property, value)
    @atome[property] = Particle.new(property, value)
  end

  def read(property)
    @atome[property].value
  end

  def adds(params)
    params.each do |param|
      param.each do |property, value|
        @atome[property] << { property => value }
      end
    end
  end

end

class Particle
  def initialize(param, value)
    instance_variable_set("@#{param}", [{ value: value, id: Universe.identity_generator }])
  end

  def value
    values = []
    instance_variable_get(self.instance_variables[0]).each do |val|
      values << val[:value]
    end
    values
  end

  def <<(val)
    property_we_wil_add_into = instance_variable_get(self.instance_variables[0])
    property_we_wil_add_into << { value: val.values[0], id: Universe.identity_generator }
  end

end

Universe.creator(:eVe)
a = Atome.new({ type: :shape, preset: :box, id: :the_box,
                atome: { type: :child, id: Universe.identity_generator, dynamic: true },
                # atome: {type: :top, id: :a_09865653 } ,
                color: :red })
# puts a.inspect
# puts a.type.inspect

a.add({ preset: :circle })
a.adds([{ preset: :circle }])
puts a.read(:preset)
a.preset = :toto
a.put(:preset,:cube)
puts a.read(:preset)
# puts a.preset.class