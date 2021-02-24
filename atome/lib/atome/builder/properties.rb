class Quark
  def initialize(property)
    @property = property
  end

  def read
    @property
  end

  def write(value)
    @property = value
  end

  def self.atome_methods
    audio = %i[color opacity border overflow]
    communication = %i[share]
    effect = %i[blur shadow]
    events = %i[touch drag over]
    geometry = %i[width height rotation]
    helper = %i[tactile display]
    hierarchy = %i[parent child insert]
    identity = %i[atome_id id type language]
    spatial = %i[width height size x xx y yy z]
    media = %i[content image sound video]
    utility = %i[delete record enliven selector render preset tactile]
    visual = %i[color opacity border overflow]
    spatial | helper | visual | audio | geometry | effect | media | hierarchy | utility | communication | identity | events
    spatial | helper | visual | audio | geometry | effect | media | hierarchy | utility | communication | identity | [:drag]
  end

  # generate methods
  def self.genesis
    Quark.atome_methods.each do |method_name|
      Atome.define_method method_name do |value, &proc|
        if proc && value.instance_of?(Hash)
          value[:content] = proc
        elsif proc && (value.instance_of?(String) || value.instance_of?(Symbol))
          property = {}
          property[:value] = proc
          property[:options] = value
          value = property
        elsif proc
          value = {value: proc}
        end
        if value || value == false
          property_instance = instance_variable_set("@#{method_name}", atomise(value))
          send(method_name + "_html", property_instance)
        else
          instance_variable_get("@#{method_name}").read
        end
      end

      Atome.define_method method_name.to_s + "=" do |value|
        send(method_name, value)
      end
    end
  end

  # recipient for created atome
  def self.space
    # this method create a class variable to store all created atomes
    Atome.class_variable_set("@@atomes", []) # you can access without offense
  end
end