class Quark
  def initialize(property)
    @property = property
  end

  def read
    @property
  end
  #
  def write(value)
    @property = value
  end


  def self.atome_methods
    audio = %i[color opacity border overflow]
    communication = %i[share]
    effect = %i[blur shadow smooth]
    events = %i[touch drag over]
    geometry = %i[width height rotation]
    helper = %i[tactile display]
    hierarchy = %i[parent child insert]
    identity = %i[atome_id id type language private can]
    spatial = %i[width height size x xx y yy z center]
    media = %i[content image sound video box circle text image video audio]
    utility = %i[edit record enliven selector render preset tactile]
    visual = %i[color opacity border overflow]
    spatial | helper | visual | audio | geometry | effect | media | hierarchy | utility | communication | identity | events
  end

  def self.setter_need_pre_processing
    %i[atome_id private can box circle text image video audio]
  end

  def self.getter_need_pre_processing
    %i[private can box circle text image video audio]
  end

  def self.no_rendering
    %i[child]
  end

  # generate methods
  def self.genesis
    Quark.atome_methods.each do |method_name|
      Atome.define_method method_name do |value, &proc|
        if proc && value.instance_of?(Hash)
          value[:value] = proc
        elsif proc && (value.instance_of?(String) || value.instance_of?(Symbol))
          property = {}
          property[:value] = proc
          property[:options] = value
          value = property
        elsif proc
          value = {value: proc}
        end
        if value || value == false
          if Quark.setter_need_pre_processing.include?(method_name)
            # Attention!! :if this property needs processing, the instance variable is not created !
            send(method_name + "_processor", value)
          elsif Quark.no_rendering.include?(method_name)
            # only set the instance variable but no rendering
            instance_variable_set("@#{method_name}", atomise(value))
          else
            # we set yhe instance variable
            property_instance = instance_variable_set("@#{method_name}", atomise(value))
            # and send it to the renderer
            send(method_name + "_html", property_instance)
          end
          # below this is the method getter it return the instance variable if it is define(&.rea)
        elsif Quark.getter_need_pre_processing.include?(method_name)
          send(method_name + "_getter_processor", value)
        else
          instance_variable_get("@#{method_name}")&.read
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
    Atome.class_variable_set("@@atomes", {}) # you can access without offense
  end
end