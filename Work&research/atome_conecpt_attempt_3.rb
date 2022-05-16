require "./atome_v2_methods_tests"

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

class Atome
  include AtomeDummyMethods

  def initialize(params = {})
    puts object_id
  end

  def properties_common(value, current_property, stack_property, optional_processor)
    ;
  end

end

# Universe.initialize
Universe.connected

# puts Universe.atomes
#
# a = Atome.new({ top: 22 })
# a = Atome.new({ top: 22 })
# a = Atome.new({ top: 22 })
# a.left(33)