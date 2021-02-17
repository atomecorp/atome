# the class below initialize the default values and generate properties's methods
#this module contain the methods to be created and those who needs extra processing
# class Matiere
#   def initialize(property)
#     @property = property
#   end
#
#   def collapse
#     puts @property
#     @property
#   end
#
#   def matiere
#     self
#   end
#
#   def length
#     @property.length
#   end
#
#   def []
#     # alert @property
#     # @property
#     "true"
#   end
#
#   # def class
#   #   @property.class
#   # end
#
# end

module Atome_methods_list

  def self.atome_methods
    spatial = %i[width height size x xx y yy z ]
    events = %i[touch drag over]
    helper = %i[tactile display]
    visual = %i[color opacity border overflow]
    geometry = %i[width height rotation]
    effect = %i[blur shadow]
    identity = %i[atome_id id type]
    media = %i[image sound video content]
    hierarchy = %i[parent child insert]
    communication = %i[share send]
    utility = %i[delete record enliven selector]
    spatial | events | helper | visual | geometry | effect | identity | media | hierarchy | communication | utility
  end

  #the line below specify if the properties need specific processing
  def self.need_pre_processing
    %i[add shadow atome_id]
  end

  def self.no_broadcast
    %i[atome_id tabalou]
  end

  def self.need_processing
    %i[delete]
  end

  def self.need_post_processing
    %i[]
  end

  def self.no_rendering
    %i[shadow enliven tactile selector atome_id tabalou]
  end
end
# the class below initialize the default values and generate property's methods

class Sparkle
  include Atome_methods_list

  def initialize
    # the line below create atomes's methods using meta-programming
    atome_methods = Atome_methods_list.atome_methods
    atome_methods.each do |method_name|
      Sparkle.methods_genesis(method_name)
    end
  end

  def self.methods_genesis(method_name)
    # alert " create #{method_name}"
    Nucleon.define_method method_name do |params = nil, &proc|
      if params
        # this is the main entry method for the current property treatment
        # first we create a hash for the property if it doesn't already exist
        method_analysis params, method_name, proc if params || proc
      else
        # no params send we call the getter using magic_getter
        instance_method_name = instance_variable_get("@#{method_name}")
        magic_getter instance_method_name, method_name
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
    # if self.type[:content]==:collector
    #    self.content.each do |atome_to_be_processed|
    #      atome_to_be_processed.send(method_name,params)
    #    end
    # else
    #   # if prop needs to be refresh we send it to the Render engine
    #   unless  Atome_methods_list.no_broadcast.include?(method_name)
    #     broadcast(atome_id[:value]=> {method_name => params})
    #   end
    #
    #   if Atome_methods_list.need_processing.include?(method_name)
    #     params= send("#{method_name}_processor", params)
    #   end
    #
    #   unless Atome_methods_list.no_rendering.include?(method_name)
    #     Render.send("render_#{method_name}", self, params) if params.class==Array || params[:render].nil? || params[:render] == true
    #   end
    #
    #   if Atome_methods_list.need_post_processing.include?(method_name)
    #     send("#{method_name}_post_processor", params)
    #   end
    # end
    # if self.type[:content]==:collector
    #   alert "property.rb line 63 should delete the collector"
    #   # self.content=""
    #   # self.delete(true)
    # end
    self
  end

  # def array_parsing(params, method_name, proc)
  #   params.each_with_index do |param, index|
  #     if param.instance_of?(Hash) && param[:add] != false && index != 0
  #       param[:add] = true
  #     elsif !param.instance_of?(Hash)
  #       param = { value: param, add: true }
  #     end
  #     if index == params.length - 1
  #       # when we reach the last element of the array we add the proc
  #       method_analysis param, method_name, proc
  #     else
  #       method_analysis param, method_name, nil
  #     end
  #   end
  # end

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

  def store_instance_variable params, method_name, proc
    if params[:add] == true
      params.delete(:add)
      prev_value = instance_variable_get("@#{method_name}")
      instance_variable_set("@#{method_name}", [prev_value, params])
    else
      instance_variable_set("@#{method_name}", params)
    end
  end

  def method_analysis(params, method_name, proc)
    # we reformat the params to be hash with :avalue as key
    # we don't create a object init time, to only create property when needed
    #now we look if the datas passed needs some processing before beeing stored
    if Atome_methods_list.need_pre_processing.include?(method_name)
      params = send("#{method_name}_pre_processor", params)
    end

    if params.instance_of?(Array)
      params.each_with_index do |param, index|
        # We reformat the params in case user doesn't format the params using a Hash
        param = format_params_send(param)
        if index == 0
          store_instance_variable param, method_name, proc
        else
          store_instance_variable param.merge(add: true), method_name, proc
        end
      end
    else
      # We reformat the params in case user doesn't format the params using a Hash
      params = format_params_send(params)
      # now we feed the instance_variable with the new value
      store_instance_variable params, method_name, proc
    end

    if params && !params.instance_of?(Hash)
      params = {value: params}
    end
    params ||= {}
    params[:proc] = proc if proc
    property_save(params, method_name)
    # end
  end

  def magic_getter(method, instance_method_name)
    # the aim of this method is only return the value of the content if the property hash only have a content set
    # if method.length == 1 && method.instance_of?(Hash) && method[:content]
    #   if instance_method_name ==:atome_id
    #     method[:content]
    #   else
    #     method
    #   end
    # else
    #   method
    # end
    # a=Matiere.new
    # Nucleon.toto(method)
    # alert self
    # method=Matiere.new(method)
    # # # method a.content.class
    # method.matiere
    puts "#{instance_method_name}: #{method}"
    method
  end
end

