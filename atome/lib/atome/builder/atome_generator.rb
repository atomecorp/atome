# this class is used to define newly created atomes
class Atome
  include DefaultValues
  #if Quark.property_generation == :static
    include Properties
  #else
  #  Quark.genesis
  #end
  include Processors
  include RenderHtml
  include InternalHelpers
  include AtomeHelpers

  # the method below initialize the creation of atome properties
  def self.sparkle
    # the line create a space to hold new created atomes
    Quark.space
    # genesis uses meta programing to generate atome's methods
    #if Quark.property_generation== :dynamic
    #  Quark.genesis
    #end
  end

  # atome creation
  def initialize(properties = {})
    # the hash below add the missing properties without creating a condition
    sanitizer = {atome_id: identity, type: :particle, x: 0, y: 0}.merge(properties)
    create(sanitizer)
    register_atome
  end

  def create(properties)
    atome_id = properties.delete(:atome_id)
    send("atome_id=", atome_id)
    properties.each do |property, value|
      set(property, value)
    end
  end

  def get(property)
    send(property)
  end

  def set(property, value)
    send(property.to_s + "=", value)
  end

  def register_atome
    # now we add the new atome to the atomes's list
    Atome.class_variable_get("@@atomes")[atome_id] = self
  end

  def self.atomes
    # this method return all created atomes
    Atome.class_variable_get("@@atomes") # you can access without offense
  end
end