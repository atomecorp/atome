# this class is used to define newly created atomes
class Atome
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
  include RenderHtml
  include AtomeUtilities

  # the method below initialize the creation of atome properties
  def self.sparkle
    # the line below define all atome's properties from atome_method's list
    Atome.atomise
  end

  # atome creation
  def initialize(properties = {type: :particle})
    properties.each do |property, value|
      set(property, value)
    end
    register_atome
  end

  def set(property, value)
    send(property.to_s + "=", value)
  end

  def register_atome
    # now we add the new atome to the atomes's list
    Atome.class_variable_get("@@atomes") << self
  end

  # recipient for created atome
  def self.atomise
    # this method create a class variable to store all created atomes
    Atome.class_variable_set("@@atomes", []) # you can access without offense
  end

  def self.atomes
    # this method return all created atomes
    Atome.class_variable_get("@@atomes") # you can access without offense
  end
end