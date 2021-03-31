# this class is used to define newly created atomes
class Atome
  include DefaultValues
  include Properties
  include Processors
  include RenderHtml
  include InternalHelpers
  include AtomeHelpers

  # the method below initialize the creation of atome properties
  def self.sparkle
    # the line create a space to hold new created atomes
    Quark.space
  end

  # atome creation
  def initialize(properties = {})
    # the hash below add the missing properties without creating a condition
    sanitizer = { atome_id: identity,render: true, type: :particle }.merge(properties)
    atome_id=sanitizer.delete(:atome_id)
    type=sanitizer.delete(:type)
    render=sanitizer.delete(:render)
     sanitizer.each do |atome_property, value|
       instance_variable_set("@#{atome_property}", atomise(atome_property, value))
     end
    essential={atome_id: atome_id}.merge({type: type}).merge({render: render})
    create(essential)
  end

  def create(properties)
    atome_id = properties.delete(:atome_id)
    self.atome_id(atome_id)
    register_atome
    set properties
  end

  def get(property)
    send(property)
  end

  def set(properties)
    properties.each do |property, value|
      send(property.to_s, value)
    end
  end

  def register_atome
    # now we add the new atome to the atomes's list
    Atome.class_variable_get("@@atomes")[atome_id] = self
  end

  def self.atomes
    # this method return all created atomes
    Atome.class_variable_get("@@atomes") # allow access without offense
  end

  def self.atomes=(atome_list)
    # refresh atome list
    Atome.class_variable_set("@@atomes", atome_list)
  end

  def [](query = nil)
    if query
      self.properties[query]
    else
      self.properties
    end
  end
end