# the class below initialize the default values and generate properties's methods

module AtomeMethodsList
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
    communication = %i[share send]
    utility = %i[delete record enliven selector]
    spatial | events | helper | visual | audio | geometry | effect | identity | media | hierarchy | communication | utility
  end

  # the line below specify if the properties need specific processing
  def self.need_pre_processing
    %i[add shadow]
  end

  def self.no_broadcast
    %i[atome_id]
  end

  def self.need_processing
    %i[delete color]
  end

  def self.need_post_processing
    %i[]
  end

  def self.no_rendering
    %i[shadow enliven tactile selector atome_id]
  end
end
# the class below initialize the default values and generate property's methods

class Sparkle
  include AtomeMethodsList
  def initialize
    # the line below create atomes's methods using meta-programming
    atome_methods = AtomeMethodsList.atome_methods
    atome_methods.each do |method_name|
      Sparkle.methods_genesis(method_name)
    end
  end

  def self.methods_genesis(method_name)
    Nucleon.define_method method_name do |params = nil, &proc|
      if params
        # this is the main entry method for the current property treatment
        # first we create a hash for the property if it doesn't already exist
        if proc
          params[:proc] = {value: proc}
        end
        method_analysis method_name, params
      else
        # no params send, we call the getter using magic_getter
        instance_variable_get("@#{method_name}")
      end
    end
    # the meta-program below create the same method as above, but add equal at the end of the name to allow assignment
    # ex : for : "def color"  = > "def color= "
    Nucleon.define_method method_name.to_s + "=" do |params = nil, &proc|
      send(method_name, params, proc)
    end
  end
end

# the class below contains all common propertiy's methods
module Properties
  # the methods below must be executed once only
  def send_hash(params, method_name)
    puts "#{params} #{method_name}"
    self
  end

  def property_save(params, method_name)
    previous_content = instance_variable_get("@#{method_name}")
    if params[:add] && previous_content.instance_of?(Hash) && previous_content != {}
      params.delete(:add)
      params = [previous_content, params]
    elsif params[:add] && previous_content.instance_of?(Array)
      params.delete(:add)
      params = previous_content << params
    elsif previous_content.instance_of?(Hash)
      params.delete(:add)
    end
    send_hash(params, method_name)
    # instance_variable_set("@#{method_name}", params)
  end

  def format_params_send(params)
    unless params.instance_of?(Hash)
      params = {value: params}
    end
    params
  end

  def store_instance_variable(method_name, params)
    if params[:add] == true
      params.delete(:add)
      prev_value = instance_variable_get("@#{method_name}")
      instance_variable_set("@#{method_name}", [prev_value, params])
    else
      instance_variable_set("@#{method_name}", params)
    end
  end

  def method_analysis(method_name, params, proc)
    # we reformat the params to be hash with :avalue as key
    # we don't create a object init time, to only create property when needed
    # now we look if the datas passed needs some processing before beeing stored
    if AtomeMethodsList.need_pre_processing.include?(method_name)
      params = send("#{method_name}_pre_processor", params)
    end

    if params.instance_of?(Array)
      params.each_with_index do |param, index|
        # We reformat the params in case user doesn't format the params using a Hash
        param = format_params_send(param)
        if index == 0
          store_instance_variable method_name, param
        else
          store_instance_variable method_name, param.merge(add: true)
        end
      end
    else
      # We reformat the params in case user doesn't format the params using a Hash
      params = format_params_send(params)
      # now we feed the instance_variable with the new value
      store_instance_variable method_name, params
    end

    if params && !params.instance_of?(Hash)
      params = {value: params}
    end
    params ||= {}
    params[:proc] = proc if proc
    property_save(params, method_name)
  end
end