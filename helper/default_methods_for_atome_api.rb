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

# the class below initialize the default values and generate functions such  properties's methods
class Sparkle
  def initialize
    # the line below create atomes's methods using meta-programming
    atome_methods = %i[atome_id toto]
    atome_methods.each do |method_name|
      Atome.define_method method_name do |params = nil, &proc|
        # this is the main entry method for the current property treatment
        ## first we create a hash for the property if t doesnt exist
        ## we don't create a object init time, to only create property when needed
        instance_method_name = if instance_variable_defined?("@" + method_name.to_s)
          instance_variable_get("@" + method_name.to_s)
        else
          instance_variable_set("@" + method_name.to_s, {})
        end
        # we send the params to the 'reformat_params' if there's a params
        method_analysis params, instance_method_name, method_name, proc if params || proc
        # finally we return the current property using magic_getter
        unless params
          magic_getter instance_method_name
        end
      end
      # the class below create the same method as above, but add equal at the end of the name to allow assignment
      # ex : for : "def color"  = > "def color= "
      Atome.define_method method_name.to_s + "=" do |params = nil, &proc|
        send(method_name, params, proc)
      end
    end
  end
end
# the class below contains all common properties's methods
module Properties
  # the method below must be executed once only

  def reformat_params(params, method_name, proc)
    # this method allow user to input simple datas and reformat the incoming datas so it always store a Hash
    # if its a string then the data is put into the property content
    #   ex with color property : {color: {content: :red}}
    # if it's an array then property itself change from Hash type to array
    #   ex with color property{color: [{content: :red}{content: :yellow, x: 200}]}
    if params.instance_of?(Hash)
      params[:proc] = proc if proc
      params
    elsif params.instance_of?(Array)
      params.each do |param|
        if param.instance_of?(Hash)
          param[:add] = true
          send(method_name, param)
        else
          send(method_name, {content: param, add: true})
        end
      end
      send(method_name, {proc: proc, add: true}) if proc
      {}
    elsif proc
      {content: params, proc: proc}
    else
      {content: params}
    end
  end

  def send_hash(params, method_name)
    # if prop needs to be refresh we send it to the Render engine
    broadcast(atome_id => {method_name => params})
    send(method_name.to_s + "_dsp", params)
  end

  def property_parsing(params, method_name)
    # here happen the specific treatment for the current property
    if params.instance_of?(Hash)
      send_hash(params, method_name)
    elsif params.instance_of?(Array)
      # if params is an array we send each item of the array to 'found_property_parsing' as a Hash
      params.each do |param|
        send(method_name.to_s + "_parsing", param)
      end
    end
  end
  #def method_analysis(params, instance_variable, method_name, proc)
  #  # this method first send the params to the 'reformat_params' method to ensure it return a hash or an array
  #  params = reformat_params params, method_name, proc
  #  # then either it parse the params if {add: true} is found, so it add the params to the property hash,
  #  # either it add any {key: :value} found to the instance variable property
  #  if params[:add] && params[:add] == true
  #    # this method is called when the property hash contain {add: true}
  #    # then hash property is turn into an array so it can accept many times the same property.
  #    # use for gradient or multiple shadows, etc...  ex : color: [{content : red, x: 0},{content : pink, x: 200}]
  #    #params.delete(:add)
  #    previous_params = instance_variable_get("@#{method_name}")
  #    if previous_params.empty?
  #      instance_variable_set("@#{method_name}", [params])
  #    elsif previous_params.instance_of?(Hash)
  #      instance_variable_set("@#{method_name}", [previous_params, params])
  #    elsif previous_params.instance_of?(Array)
  #      instance_variable_set("@#{method_name}", previous_params << params)
  #    end
  #  #elsif instance_variable.instance_of?(Array) || params[:content]
  #    #params.delete(:add)
  #    #puts "************11*************"
  #    #
  #    #instance_variable_set("@#{method_name}", params)
  #  #elsif params[:content]
  #  #  puts "***********22**************"
  #    #params.delete(:add)
  #    #params.each do |key, value|
  #    #  instance_variable[key] = value
  #    #end
  #    instance_variable_set("@#{method_name}", params)
  #  elsif !params[:content]
  #    #puts "############000############"
  #
  #    #params.delete(:add)
  #    #params.delete(:content)
  #    #instance_variable.delete(:content)
  #    #instance_variable_set("@#{method_name}", params)
  #    params.each do |key, value|
  #      instance_variable[key] = value
  #    end
  #  else
  #    #puts "************11*************"
  #
  #    instance_variable_set("@#{method_name}", params)
  #  end
  #  #puts "#{params.class}"
  #  params.delete(:add)
  #  #instance_variable.delete(:add)
  #  # now we apply the specific treatment according to the property found if the hash is not empty
  #  property_parsing(params, method_name) if params != {}
  #end

  # original version below
  #def method_analysis(params, instance_variable, method_name, proc)
  #  # this method first send the params to the 'reformat_params' method to ensure it return a hash or an array
  #  params = reformat_params params, method_name, proc
  #  # then either it parse the params if {add: true} is found, so it add the params to the property hash,
  #  # either it add any {key: :value} found to the instance variable property
  #  if params[:add] && params[:add] == true
  #    # this method is called when the property hash contain {add: true}
  #    # then hash property is turn into an array so it can accept many times the same property.
  #    # use for gradient or multiple shadows, etc...  ex : color: [{content : red, x: 0},{content : pink, x: 200}]
  #    #params.delete(:add)
  #    previous_params = instance_variable_get("@#{method_name}")
  #    if previous_params.empty?
  #      instance_variable_set("@#{method_name}", [params])
  #    elsif previous_params.instance_of?(Hash)
  #      instance_variable_set("@#{method_name}", [previous_params, params])
  #    elsif previous_params.instance_of?(Array)
  #      instance_variable_set("@#{method_name}", previous_params << params)
  #    end
  #  elsif instance_variable.instance_of?(Array)
  #    #params.delete(:add)
  #    instance_variable_set("@#{method_name}", params)
  #  elsif params[:content]
  #    #params.delete(:add)
  #    params.each do |key, value|
  #      instance_variable[key] = value
  #    end
  #  else
  #    #params.delete(:add)
  #    #params.delete(:content)
  #    #instance_variable.delete(:content)
  #    #params[:content]="#############"
  #    #instance_variable_set("@#{method_name}", params)
  #    params.each do |key, value|
  #      instance_variable[key] = value
  #    end
  #  end
  #  #instance_variable.delete(:add)
  #  # now we apply the specific treatment according to the property found if the hash is not empty
  #  property_parsing(params, method_name) if params != {}
  #end

  def method_analysis(params, instance_variable, method_name, proc)
    add = nil
    #if params.instance_of?(Array)
    #  params.each do |property|
    #    #puts "line 189 : #{property}"
    #    #add=true if property[:add]
    #  end
    #  #puts params.class
    #else
    #  #add=true if params[:add]
    #end
    #puts "###### if  #{add} parse content ######"

    # this method first send the params to the 'reformat_params' method to ensure it return a hash or an array
    puts "#########"
    puts "pre  : #{params} : #{params.class}"
    params = reformat_params params, method_name, proc
    puts "post : #{params} : proc : #{proc}"
    ## then either it parse the params if {add: true} is found, so it add the params to the property hash,
    ## either it add any {key: :value} found to the instance variable property
    #if add
    #  # this method is called when the property hash contain {add: true}
    #  # then hash property is turn into an array so it can accept many times the same property.
    #  # use for gradient or multiple shadows, etc...  ex : color: [{content : red, x: 0},{content : pink, x: 200}]
    #  #params.delete(:add)
    #  previous_params = instance_variable_get("@#{method_name}")
    #  if previous_params.empty?
    #    instance_variable_set("@#{method_name}", [params])
    #  elsif previous_params.instance_of?(Hash)
    #    instance_variable_set("@#{method_name}", [previous_params, params])
    #  elsif previous_params.instance_of?(Array)
    #    instance_variable_set("@#{method_name}", previous_params << params)
    #  end
    #elsif instance_variable.instance_of?(Array)
    #  #params.delete(:add)
    #  instance_variable_set("@#{method_name}", params)
    #elsif params[:content]
    #  #params.delete(:add)
    #  params.each do |key, value|
    #    instance_variable[key] = value
    #  end
    #else
    #  #params.delete(:add)
    #  #params.delete(:content)
    #  #instance_variable.delete(:content)
    #  #params[:content]="#############"
    #  #instance_variable_set("@#{method_name}", params)
    #  params.each do |key, value|
    #    instance_variable[key] = value
    #  end
    #end
    ##instance_variable.delete(:add)
    ## now we apply the specific treatment according to the property found if the hash is not empty
    #property_parsing(params, method_name) if params != {}
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

#  the class below contains all the specifics  code for properties
module Singularity

  include Properties
  def toto_dsp(params)
    "toto dsp :  #{params}"
  end

  def atome_id_dsp(params)
    "atome_id DSP#{params}"
  end
end

#  the class below create all new user's atomes
class Atome
  include Singularity
  def initialize
    Universe.add(self)
    atome_id("a_" + object_id.to_s)
  end

  # for testing only, just to simulate broadcast
  def broadcast(params)
    # to allow system to be notified of property modification
    "I broadcast :" + params.to_s
  end
end

## ------- verification 1 -------
#Sparkle.new
#a = Atome.new
#a.toto(:my_data)
#a.toto(:tutu)
#puts "line 263 :\"#{a.toto}\" "
#a.toto(:ok_for_now)
#a.toto({content: :doto, kool: :ok})
#a.toto({content: :didi, kool: :pas_ok, refresh: false})
#puts "line 266 : #{a.toto}"
#a.toto([{content: :datos, x: 0}, :toto])
##a.toto(:dudu)
#a.toto({content: :titi, kool: :ok2, add: true})
#puts "line 270 : #{a.toto}"
#a.toto(:mimi)
##a.atome_id(:my_id)
##puts "line 273 : #{a.atome_id}"
#a.toto([{content: :ditos, x: 0, add: false}, :toti]) do
#  puts "it works"
#end
#puts "line 277 : #{a.toto}"
#a.toto({add: true, content: :conteni})
#puts "line 280 : #{a.toto}"
#a.toto({add: false}) do
#  puts "it's cool"
#end
#puts "line 284 : #{a.toto}"
#
#a.toto() do
#  puts "it's cool"
#end
#puts "line 286 : #{a.toto}"
## line 92 :     send(method_name, {proc: proc, add: true}) if proc
## proc should be integrated first ()before sending it to the property hash) for now it is not integrated in the current, if not it may fuck the entire project
## see above
##b = Atome.new
##b.toto(:my_give)
##puts "universe is #{Universe.atomes}"

# ------- verification 2 -------
Sparkle.new
a = Atome.new
a.toto(:my_data)
a.toto(:tutu)
a.toto(:ok_for_now)
a.toto({content: :doto, kool: :ok})
a.toto({content: :didi, kool: :pas_ok, refresh: false})
a.toto([{content: :datos, x: 0}, :tomoldu])
a.toto(:dudu)
a.toto({content: :titi, kool: :ok2, add: true})
a.toto(:mimi)
a.toto([{content: :ditos, x: 0, add: false}, :toti]) do
  puts "it works"
end
a.toto({add: true, content: :conteni})
a.toto({add: false}) do
  puts "it's cool"
end

a.toto() do
  puts "it's cool"
end

## ------- verification 3 -------
#Sparkle.new
#a = Atome.new
###a.toto([:my_data, :toto, :tutu])
##a.toto([{content: :datos, x: 0}, :toto])
###a.toto(:tutu)