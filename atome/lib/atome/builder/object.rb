# this class is used to define newly created atomes
class Atome
  include DefaultValues
  include AudiosProperties
  include CommunicationsProperties
  include EffectsProperties
  include EventsProperties
  include GeometriesProperties
  include HelpersProperties
  include HierarchiesProperties
  include IdentitiesProperties
  include MediasProperties
  include SpatialsProperties
  include UtilitiesProperties
  include VisualsProperties
  include AudiosProcessors
  include CommunicationsProcessors
  include EffectsProcessors
  include EventsProcessors
  include GeometriesProcessors
  include HelpersProcessors
  include HierarchiesProcessors
  include IdentitiesProcessors
  include MediasProcessors
  include SpatialsProcessors
  include UtilitiesProcessors
  include VisualsProcessors
  include RenderHelper
  include RenderHtml
  include AtomeUtilities

  # the method below initialize the creation of atome properties
  def self.sparkle
    # the line create a space to hold new created atomes
    Quark.space
    # genesis uses meta programing to generate atome methods
    #Quark.genesis
  end

  # atome creation
  def initialize(properties = {})
    # the hash below add the missing properties without creating a condition
    sanitizer = {type: :particle, atome_id: identity, x: 0, y: 0}.merge(properties)
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

  def set(property, value)
    send(property.to_s + "=", value)
  end

  def register_atome
    # now we add the new atome to the atomes's list
    Atome.class_variable_get("@@atomes") << self
  end

  def self.atomes
    # this method return all created atomes
    Atome.class_variable_get("@@atomes") # you can access without offense
  end
end