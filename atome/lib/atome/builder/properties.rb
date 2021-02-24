class Quark
  def initialize(property)
    @property = property
  end

  def read
    # if @property.instance_of?(Hash)
    #  @property = @property[:value]
    # end
    @property
  end

  def self.atome_methods
    spatial = %i[width height size x xx y yy z]
    events = %i[touch drag over]
    helper = %i[tactile display]
    visual = %i[color opacity border overflow]
    audio = %i[color opacity border overflow]
    geometry = %i[width height resize rotation]
    effect = %i[blur shadow]
    identity = %i[atome_id id type]
    media = %i[content image sound video]
    hierarchy = %i[parent child insert]
    communication = %i[share]
    utility = %i[delete record enliven selector render preset]
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
        if value
          property_instance = instance_variable_set("@#{method_name}", Quark.new(value))
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
  def self.atomise
    # this method create a class variable to store all created atomes
    Atome.class_variable_set("@@atomes", []) # you can access without offense
  end
end