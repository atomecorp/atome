# frozen_string_literal: true

# this class hold all created atomes
class Universe
  def self.initialize
    Atome.new({ type: :user })
  end

  def self.atomes_add(new_atome)
    @atomes << new_atome
  end

  class << self
    attr_reader :atomes
  end

  def self.connected
    true
  end
end

# this class build atomes
class Atome
  include AtomeDummyMethods

  def initialize(params = {})
    puts "the object id is : #{object_id} , #{params}"
  end

  def properties_common(value, current_property, stack_property, optional_processor)
    puts "#{value}, #{current_property}, #{stack_property}, #{optional_processor}"
  end
end
# Universe.initialize
Universe.connected

puts Universe.atomes

Atome.new({ top: 22 })
Atome.new({ top: 22 })
a = Atome.new({ top: 22 })
a.left(33)
