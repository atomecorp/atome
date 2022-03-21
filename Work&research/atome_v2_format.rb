require "./atome_v2_methods_tests.rb"
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



  def properties_common(value, current_property, stack_property, optional_processor)
    getter_setter(current_property, value)
      # atome_sanitizer(current_property, value) do |sanitized_value, options|
      #   options = options.merge(optional_processor)
        # properties_router(current_property, sanitized_value, options, stack_property)
      # end
    # end
    # instance_variable_set("@#{current_property}", value)
  end

  def getter_setter(property, value)

    if value.nil?
      instance_variable_get "@#{property}"
    else
      # yield value
      # instance_variable_set("@#{property}", value)
      atome_sanitizer(property, value)
    end
  end

  def atome_sanitizer(property, values, &block)
    if values.instance_of? Hash
      check_hash_content(property, values, &block)
    elsif values.instance_of? Array
      values.each do |value|
        add({ property => value })
      end
    else
      # below we set the render_property at true because the property should be rendered as deafulat
      # instance_exec(values, { render_property: true, store_property: true }, &block)
      options = options.merge(values)
    end
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
end

Universe.creator(:jeezs)
universe = Atome.new({ universe: :mind, top: 44 })
puts universe.top
# puts Universe.user_active
# puts universe.inspect
# puts   atome_number= Universe.atomes[1].left.inspect

