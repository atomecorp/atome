# the class below initialize the default values and generate properties's methods
#this module contain the methods to be created and those who needs extra processing

module Atome_methods_list
  def self.atome_methods
    %i[border display capture tactile]
  end
  #the line below specify if the properties need specific processing
  def self.need_processing
    %i[border]
  end
end
# the class below initialize the default values and generate properties's methods
class Sparkle
  include Atome_methods_list
  def initialize
    # the line below create atomes's methods using meta-programming
    atome_methods = Atome_methods_list.atome_methods
    #the line below specify if the properties need specific processing
    #need_processing=%i[ color border]
    atome_methods.each do |method_name|
      Nucleon.define_method method_name do |params = nil, &proc|
        # this is the main entry method for the current property treatment
        # first we create a hash for the property if t doesnt exist
        # we don't create a object init time, to only create property when needed
        instance_method_name = if instance_variable_defined?("@" + method_name.to_s)
                                 instance_variable_get("@#{method_name}")
                               else
                                 instance_variable_set("@#{method_name}", {})
                               end
        # we send the params to the 'reformat_params' if there's a params
        method_analysis params, instance_method_name, method_name, proc if params || proc
        # finally we return the current property using magic_getter
        unless params
          # no params send we call the getter
          magic_getter instance_method_name
        end
      end
      # the meta-program below create the same method as above, but add equal at the end of the name to allow assignment
      # ex : for : "def color"  = > "def color= "
      Nucleon.define_method method_name.to_s + "=" do |params = nil, &proc|
        send(method_name, params, proc)
      end
    end
  end
end
# the class below contains all common properties's methods
module Properties

  # the methods below must be executed once only
  def send_hash(params, method_name)
    # if prop needs to be refresh we send it to the Render engine
    broadcast(atome_id => {method_name => params})
    if Atome_methods_list.need_processing.include?(method_name)
      send("#{method_name}_processing", params)
    end
    Render.send("render_#{method_name}", self, params) if params[:render].nil? || params[:render] == true
  end

  def property_parsing(params, method_name)
    # here happen the specific treatment for the current property
    if params.instance_of?(Hash)
      send_hash(params, method_name)
    elsif params.instance_of?(Array)
      # if params is an array we send each item of the array to 'found_property_parsing' as a Hash
      params.each do |param|
        property_parsing param, method_name
      end
    end
  end

  def array_parsing(params, instance_variable, method_name, proc)
    params.each_with_index do |param, index|
      if param.instance_of?(Hash) && param[:add] != false
        param[:add] = true
      elsif !param.instance_of?(Hash)
        param = {content: param, add: true}
      end
      if index == params.length - 1
        # when we reach the last element of the array we add the proc
        method_analysis param, instance_variable, method_name, proc
      else
        method_analysis param, instance_variable, method_name, nil
      end
    end
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
    instance_variable_set("@#{method_name}", params)
  end

  def method_analysis(params, instance_variable, method_name, proc)
    if params.instance_of?(Array)
      array_parsing params, instance_variable, method_name, proc
    else
      if params && !params.instance_of?(Hash)
        params = {content: params}
      end
      params ||= {}
      params[:proc] = proc if proc
      property_save(params, method_name)
    end
  end

  def magic_getter(method)
    # the aim of this method is only return the value of the content if the property hash only have a content set
    if method.length == 1 && method.instance_of?(Hash) && method[:content]
      method[:content]
    else
      method
    end
  end
end

