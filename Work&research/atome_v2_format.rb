require "./atome_v2_methods_tests.rb"

class Particle

  def inspect
    #this method allow to make atome more human readable
    self.q_read
  end

  def initialize(value)
    @value = value
  end

  def self.atomise(value)
    # this method create a quark object from atome properties for further processing
    # typically this method is used to change an object without displaying the changes

    Particle.new(value)
  end

  def a_id
    @value
  end

  def q_read
    @value
  end

  def to_s
    # @value.values[0].to_s
    @value.to_s
  end

  def each(&proc)
    @value.each do |property, value|
      proc.call(Atome.new({ property => value })) if proc.is_a?(Proc)
    end
  end
end

# module Universe contain basic elements
class Universe
  def self.creator(user = nil)
    user ||= :universe
    @user = user
  end

  def self.user_active
    @user
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
    getter_setter(property, value, stack_property, optional_processor)
  end

  def getter_setter(property, value, stack_property, optional_processor)
    if value.nil?
      # so the methods is a getter it return the content of the atome (the value of the property)
      @atome[property]
    else
      # We we will create anew atome but before we must check and sanitize the datas passed
      atome_sanitizer(property, value, stack_property, optional_processor)
    end
  end

  def atome_sanitizer(property, values, stack_property, optional_processor)
    # if values.instance_of? Hash
    #   # if the values passed is a hash we will check it's content
    #   check_hash_content(property, values, &block)
    # elsif values.instance_of? Array
    if values.instance_of? Array
      # if it is an array we add each values found to the current property
      values.each do |value|
        add( property,value )
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
  #   # if values_to_parse[:add].instance_of?(Array)
  #   #   # we must check the added content in case it comes from another atome (if it contains an array )
  #   #   values_to_parse[:add].each do |value|
  #   #     value.delete(:a_id)
  #   #     # we extract the value from the atome passed
  #   #     value = value.values[0]
  #   #     # we send the added value to the current atome
  #   #     add({ property => value })
  #   #   end
  #   # else
  #   #   # instance_exec(property => values_to_parse, &block)
  #   # end
  # end

  def properties_router(property, value, options, stack_property)
    value = send("#{property}_pre_processor", value) if options[:pre_process]
    # if the pre_processor decide that the value shouldn't be store and render it must return nil
    atome_creation(property, value, stack_property) if options[:store_property] != false
    send_to_render_engine(property, value) if options[:render_property] != false
    value = send("#{property}_post_processor", value) if options[:post_process]
    # method_return value
  end

  def atome_creation(property, value, need_to_be_stacked)
    puts value
    # the method below delete any identical property if it doesnt need to be stack
    # delete_property(property) unless need_to_be_stacked
    # @atome[atome_number] = { property => Particle.atomise(property, value) }
    # unless @monitor.nil? || @monitor == false
    #   # if the atome is monitored it broadcast the changes
    #   broadcast(property, value)
    #  end
    @atome[property] = Particle.atomise({Universe.atomes.length => value })
    # instance_variable_set("@#{property}", Particle.atomise([value]))
    Universe.atomes(self)
    # @atome
  end

  def find_property(property)
    # @atome.each do |a_id_found, atome_found|
    #   yield a_id_found if atome_found[property]
    # end
  end

  def delete_property(property)
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
    # render_engines = @atome[:render] || [:html]
    # render_engines.each do |render_engine|
    #   "rendering prop: '#{property}'  value:  '#{value}, with engine : #{render_engine}'"
    # end
  end

  def add(property, value)
    send(property, value)
  end

  # def method_return(params)
  #   params
  # end
end

Universe.creator(:jeezs)
universe = Atome.new({ universe: :mind, top: [44,55]})
# universe.add(99)
# puts Universe.user_active
# puts universe.universe
# puts Universe.atomes
# puts   atome_nunber= Universe.atomes[1].left.inspect

