# for testing only, a replacement for @@atomes
module Universe
  def self.add(value)
    @atomes ||= []
    @atomes.push(value)
  end

  class << self
    attr_reader :atomes
  end
end

# for test purpose only
class Render
  def self.render_atome_id(*params)
    puts "rendering the atome_id on screen with #{params}"
  end

  def self.render_color(*params)
    puts "rendering the color on screen with #{params}"
  end
end

#this module contain the methods to be created and those who needs extra processing
module Atome_methods_list
  def self.atome_methods
    %i[ color border atome_id]
  end
  #the line below specify if the properties need specific processing
  def self.need_processing
    %i[  border]
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

#  the module below contains all the specifics code for properties
module Processing
  include Properties

  def color_processing(params)
    "toto dsp :  #{params}"
  end

  def atome_id_processing(params)
    puts "atome_id DSP is #{params}"
  end
end

#  the class below create all new user's atomes
class Nucleon
  include Processing

  def initialize
    Universe.add(self)
    atome_id("a_#{object_id}")
  end

  # for testing only, just to simulate broadcast
  def broadcast(params)
    # to allow system to be notified of property modification
    "I broadcast :#{params}"
  end
end

## ------- verification 1 -------
# Sparkle.new
# a = Nucleon.new
# a.toto(:my_data)
# a.toto(:tutu)
# puts "line 263 :\"#{a.toto}\" "
# a.toto(:ok_for_now)
# a.toto({content: :doto, kool: :ok})
# a.toto({content: :didi, kool: :pas_ok, refresh: false})
# puts "line 266 : #{a.toto}"
# a.toto([{content: :datos, x: 0}, :toto])
# #a.toto(:dudu)
# a.toto({content: :titi, kool: :ok2, add: true})
# puts "line 270 : #{a.toto}"
# a.toto(:mimi)
# #a.atome_id(:my_id)
# #puts "line 273 : #{a.atome_id}"
# a.toto([{content: :ditos, x: 0, add: false}, :toti]) do
#  puts "it works"
# end
# puts "line 277 : #{a.toto}"
# a.toto({add: true, content: :conteni})
# puts "line 280 : #{a.toto}"
# a.toto({add: false}) do
#  puts "it's cool"
# end
# puts "line 284 : #{a.toto}"
#
# a.toto() do
#  puts "it's cool"
# end
# puts "line 286 : #{a.toto}"
## line 92 :     send(method_name, {proc: proc, add: true}) if proc
## proc should be integrated first ()before sending it to the property hash) for now it is not integrated in the current, if not it may fuck the entire project
## see above
# #b = Nucleon.new
# #b.toto(:my_give)
# #puts "universe is #{Universe.atomes}"

# ------- verification 2 -------
Sparkle.new
a = Nucleon.new
a.color({content: :my_data, render: false})

 a.color(:tutu)
 a.color(:ok_for_now)
# a.color({content: :doto, kool: :ok})
# a.color({content: :didi, kool: :pas_ok, refresh: false})
# a.color([{content: :datos, x: 0}, :tomoldu, {content: :tibidi}, {content: [color: {content: :red, x: [color: :blue, y: 90]}]}])
# a.color([{content: :datos, x: 0}, :tomoldu, {content: :tibidi}, {content: [color: {content: :red, x: [color: :blue, y: 90]}], add: false}])
# a.color([{content: :datos, x: 0}, {content: :tomoldu, add: false}, :tibidi, {content: [color: {content: :red, x: [color: :blue, y: 90]}]}]) do
#  puts "kool"
# end
# a.color(:dudu)
# a.color({content: :titi, kool: :ok2, add: true})
# a.color(:mimi)
# a.color([:toti,{content: :ditos, x: 0, add: false}]) do
#  puts "it works"
# end
# a.color()
# a.color({add: true, content: :conteni})
# a.color({add: false}) do
#  puts "it's cool"
# end
#
# a.color() do
#  puts "it's cool"
# end
puts "--------"
puts a.color.to_s
## ------- verification 3 -------
# Sparkle.new
# a = Nucleon.new
# ##a.toto([:my_data, :toto, :tutu])
# #a.toto([{content: :datos, x: 0}, :toto])
# ##a.toto(:tutu)
puts Universe.atomes.class
