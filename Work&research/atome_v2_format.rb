require "./atome_v2_methods_tests.rb"

# module Universe contain basic elements
class Universe
  def self.creator(user = nil)
    user ||= :universe
    @user = user
  end

  def self.current_user
    @user ||= :universe
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

  def self.atomes(new_atome = nil)
    @atomes ||= []
    if new_atome
      @atomes << new_atome
    else
      @atomes
    end
  end
end

module Electron

  def properties_common(property, value, stack_property, optional_processor)
    # stack_property is a boolean that indicate if the property should stack or replace the previous property
    # optional_processor when the property needs pre or post processing
    if value.class == Particle
      puts "check first if the property need to be dynamic"
      if stack_property
        puts "--- needs an extra treatment to be added ---"
        @atome[property] ||= Particle.atomise({})
        @atome[property] = @atome[property].merge(value)
      else
        @atome[property] = value
      end
    else
      getter_setter(property, value, stack_property, optional_processor)
    end
  end

  def getter_setter(property, value, stack_property, optional_processor)
    if value.nil?
      # so the methods is a getter it return the content of the atome (the value of the property)
      if @atome
        @atome[property]
      else
        puts " we  really need to pass the atome here or think about another architecture. property: #{property}, @atome : #{@atome}"
      end
    else
      # We we will create anew atome but before we must check and sanitize the datas passed
      atome_sanitizer(property, value, stack_property, optional_processor)
    end
  end

  def atome_sanitizer(property, values, stack_property, optional_processor)
    if values.instance_of? Hash
      # if the values passed is a hash we will check it's content
      check_hash_content(property, values)
    elsif values.instance_of? Array
      # if values.instance_of? Array
      # if it is an array we add each values found to the current property
      values.each do |value|
        internal_add(property, value)
      end
    else
      # the data seems to formatted and ready to be treated and rendered and stored if needed
      # below we set the render_property and the store_property at true because
      # those properties should be stored and rendered as default
      properties_router(property, values, optional_processor, stack_property)
    end
  end

  # def check_hash_content(property, values_to_parse)
  #   # values_to_parse.delete(:a_id)
  #   if values_to_parse[:add].instance_of?(Array)
  #     # we must check the added content in case it comes from another atome (if it contains an array )
  #     values_to_parse[:add].each do |value|
  #       # value.delete(:a_id)
  #       # we extract the value from the atome passed
  #       value = value.values[0]
  #       # we send the added value to the current atome
  #       add({ property => value })
  #     end
  #   else
  #     # send(property, values_to_parse, true)
  #     # instance_exec(property => values_to_parse, &block)
  #   end
  # end

  def properties_router(property, value, options, stack_property)
    value = send("#{property}_pre_processor", value) if options[:pre_process]
    # if the pre_processor decide that the value shouldn't be store and render it must return nil
    atome_creation(property, value, stack_property) if options[:store_property] != false
    send_to_render_engine(property, value) if options[:render_property] != false
    value = send("#{property}_post_processor", value) if options[:post_process]
    method_return value
    @atome[property]
  end

  def atome_creation(property, value, need_to_be_stacked)
    # the method below delete any identical property if it doesnt need to be stack
    unless @monitor.nil? || @monitor == false
      # if the atome is monitored it broadcast the changes
      broadcast(property, value)
     end
    if need_to_be_stacked
      # in this case we get the old property's value or create the property if it doesn't exist
      # then we merge with the values to be added
      @atome[property] ||= Particle.atomise({})
      hash_to_merge = Particle.atomise({ Universe.atomes.length => { property: property, value: value, date: Time.now, creator: Universe.current_user,
                                                                     machine: Universe.current_machine } })
      @atome[property] = @atome[property].merge(hash_to_merge)
    else
      @atome[property] = Particle.atomise({ Universe.atomes.length => { property: property,
                                                                        value: value,
                                                                        date: Time.now,
                                                                        creator: Universe.current_user,
                                                                        machine: Universe.current_machine } })
    end
    Universe.atomes(self)
  end

  def method_return(params)
    params
  end

  def find_property(property)
    # @atome.each do |a_id_found, atome_found|
    #   yield a_id_found if atome_found[property]
    # end
  end

  def delete_property(property)
    @atome[property]=nil
    # find_property(property) do |properties_found|
    #   # @atome.delete(properties_found)
    # end
  end
end

class Atome
  include AtomeDummyMethods
  include Electron

  def initialize(params = {})
    @atome = {}
    # now wee wil parse the params passed and create an atome for each property found
    params.each_pair do |property, value|
      send(property, value)
    end
  end


  def send_to_render_engine(property, value)
    render_engines = @atome[:render] || [:html]
    render_engines.each do |render_engine|
      "rendering prop: '#{property}'  value:  '#{value}, with engine : #{render_engine}'"
    end
  end

  def internal_add(property, value)
    send(property, value, true)
  end

  def add(params)
    internal_add(params.keys[0], params.values[0])
  end

  def self.atomise(value)
    # this method create a quark object from atome properties for further processing
    # typically this method is used to change an object without displaying the changes
    Particle.new(value)
  end

end

class Particle < Atome

  def inspect
    #this method allow to make atome more human readable
    self.q_read
  end

  def initialize(value)
    @value = value
  end

  def merge(value)
    new_value = value.q_read
    value = @value.merge(new_value)
    @value = Particle.new(value)
  end

  def delete(val)
    if val== true
      # puts @value
        @value.values[0][:property]
       puts "we have to pass the 'atome' to to be able to delete the wanted property"
    end
  end

  def q_read
    @value
  end

  def to_s
    values = []
    @value.values.each do |hash_content|
      values << hash_content[:value]
    end
    values.to_s
  end

  def each(&proc)
    @value.each do |property, value|
    proc.call(Particle.new({ property => value })) if proc.is_a?(Proc)
  end
end
end

Universe.creator(:jeezs)
verif = Atome.new({ universe: :mind, top: [44, 55] })
verif.add({ top: 66 })
verif.add({ left: 33 })

verif.left(verif.top)

# verif.add({ left: verif.top })
# puts verif.left
 verif.left.delete(true)
puts verif.left.parent
# puts verif.left.class
# puts verif.top.left(66)
# universe.add(99)
# puts Universe.current_user
# puts universe.universe
# puts Universe.atomes
# puts   atome_nunber= Universe.atomes[1].left.inspect

