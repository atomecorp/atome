# frozen_string_literal: true

# for testing only
class Universe
  def self.add(value)
    @Sparkles ||= []
    @Sparkles.push(value)
  end

  class << self
    attr_reader :Sparkles
  end
end

# for testing only
class Singularity
  # dummy helper methods here
  def initialize
    Universe.add(self)
    atome_methods = %i[new_method my_prop my_method]
    atome_methods.each do |method_name|
      create_method(method_name)
      create_equal_method(method_name)
    end
  end

  # dummy methods here
  def broadcast(params)
    # to allow system to be notified of property modification
    params
  end

  def atome_id
    :zid_654
  end
end

# for testing only
class AtomeProperties < Singularity
  # specific property methods
  def my_prop_proc(proc)
    # if the object property contain a Proc it'll be processed here
    proc
  end

  def my_prop_rendering(params)
    # if the object property needs to be refresh then I'm your method
    puts params
    # Render.render_my_prop(self, params) if params[:refresh].nil? || params[:refresh] == true
  end

  def my_prop_processing(properties)
    # let's go with the DSP ...
    properties
  end
end

# for testing only
class Sparkle < AtomeProperties
  # global property methods
  def magic_return(method)
    # the aim of this method is filter the return of the property,
    # so if it found a single content, it only return the value ex : a.color => :red instead of {content: :red}
    if method.length == 1 && method.class == hash
      method[:content]
    else
      method
    end
  end

  def array_parsing(params, method_name, proc)
    # this method change the params send by user so each data found in the params is added to the property array
    params.each do |param|
      if param.class == Hash
        param[:add] = true
        send(method_name, param)
      else
        send(method_name, { content: param, add: true })
      end
    end
    send(method_name, { proc: proc, add: true }) if proc
    {}
  end

  def add_parsing(params, method_name)
    # this method is called when the property hash contain {add: true}
    # then hash property is turn into an array so it can accept many times the same property.
    # use for gradient or multiple shadows, etc...  ex : color: [{content : red, x: 0},{content : pink, x: 200}]
    params.delete(:add)
    previous_params = instance_variable_get("@#{method_name}")
    if previous_params.empty?
      instance_variable_set("@#{method_name}", [params])
    elsif previous_params.class == Hash
      instance_variable_set("@#{method_name}", [previous_params, params])
    elsif previous_params.class == Array
      instance_variable_set("@#{method_name}", previous_params << params)
    end
  end

  def reformat_params(params, method_name, proc)
    # this method allow user to input simple datas and reformat the incoming datas so it always store a Hash
    # if its a string then the datas is put into the property content
    #   ex with color property : {color: {content: :red}}
    # if it's an array then property itself change from Hash type to array
    #   ex with color property{color: [{content: :red}{content: :yellow, x: 200}]}
    if params.class == Hash
      params[:proc] = proc if proc
      params
    elsif params.class == Array
      array_parsing params, method_name, proc
    elsif proc
      { content: params, proc: proc }
    else
      { content: params }
    end
  end

  def send_hash(params, method_name)
    send(method_name.to_s + '_proc', params[:proc]) if params && params[:proc]
    send(method_name.to_s + '_processing', params)
    # if prop needs to be refresh we send it to the Render engine
    send(method_name.to_s + '_rendering', params)
  end

  def property_parsing(params, method_name)
    # here happen the specific treatment for the current property
    if params.class == Hash
      send_hash(params, method_name)
    elsif params.class == Array
      # if params is an array is found we send each item of the array to 'my_prop_treatment' as a Hash
      params.each do |param|
        send(method_name.to_s + '_parsing', param)
      end
    end
    broadcast(atome_id => { my_prop: params })
  end

  def method_analysis(params, instance_variable, method_name, proc)
    # this method first send the params to the 'reformat_params' method to ensure it return a hash or an array
    params = reformat_params params, method_name, proc
    # then either it parse the params if {add: true} is found, so it add the params to the property hash,
    # either it add any {key: :value} found to the instance variable property
    if params[:add] && params[:add] == true
      add_parsing params, method_name
    elsif instance_variable.class == Array
      instance_variable_set("@#{method_name}", params)
    elsif params.each do |key, value|
      instance_variable[key] = value
    end
    end
    # now we apply the specific treatment according to the property found if the hash is not empty
    property_parsing(params, method_name) if params != {}
  end

  def create_method(method_name)
    Object.define_method method_name do |params = nil, &proc|
      # This is the entry point for property getter and setter:
      # this is the main entry method for the current property treatment
      # first we create a hash for the property if t doesnt exist
      # we don't create a object init time, to only create property when needed
      @my_prop ||= {}
      # we send the params to the 'reformat_params' if there's a params
      method_analysis params, @my_prop, :my_prop, proc if params || proc
      # finally we return the current property using magic_return
      if params
        self
      else
        magic_return @my_prop
      end
    end
  end

  def create_equal_method(method_name)
    Object.define_method method_name.to_s + '=' do |params = nil, &proc|
      send(method_name, params, proc)
    end
  end
end

# verification

a = Sparkle.new
# a.my_prop(:my_data)
# a.my_prop({ content: :doto, kool: :ok })
# a.my_prop({ content: :didi, kool: :pas_ok, refresh: false })
# puts "message : #{a.my_prop} : #{a.my_prop.class} from : app.rb : 80\n\n"
# a.my_prop([{ content: :datos, x: 0 }, :toto])
# a.my_prop({ content: :titi, kool: :ok2, add: true })
# a.my_prop(:mimi)
a.my_prop([{ content: :ditos, x: 0, add: false }, :toti]) do
  puts 'it works'
end
puts "message : #{a.my_prop} : #{a.my_prop.class} from : app.rb : 83"

# line 81 :     send(method_name, { proc: proc, add: true }) if proc
# proc should be integrated first ()before sending it to the property hash) for now it is not integrated n the current
# see above