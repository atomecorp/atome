# this class is used to define newly created atomes
class Atome < Renderer
  include Utilities
  include Properties

  # the method below initialize the creation of atome properties
  def self.sparkle
    # the line below define all atome's properties from atome_method's list
    atome_methods = Properties.atome_methods
    atome_methods.each do |method_name, options|
      Properties.methods_genesis(method_name, options)
    end
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
    send(property, value)
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