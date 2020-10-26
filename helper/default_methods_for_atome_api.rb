# frozen_string_literal: true

# for testing only
class Universe
  def self.add(value)
    @eves ||= []
    @eves.push(value)
  end

  class << self
    attr_reader :eves
  end
end

# for testing only
class Eve
  # dummy methods here
  def initialize
    Universe.add(self)
  end

  def broadcast(params)
    # to allow system to be notified of property modification
    params
  end

  def atome_id
    :zid_654
  end

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

  def array_parsing(params, method_name)
    # this method change the params send by user so each data found in the params is added to the property array
    params.each do |param|
      if param.class == Hash
        param[:add] = true
        send(method_name, param)
      else
        send(method_name, { content: param, add: true })
      end
    end
    {}
  end

  def add_parsing(params, method_name)
    # this method is used the property hash contain {add: true} key value pair
    # when so the hash property is turn into an array so it can accept many times the same property.
    # use for gradient or multiple shadows, etc...  ex : color: [{content : red, x: 0},{content : pink, x: 200}]
    params.delete(:add)
    previous_params = instance_variable_get("@#{method_name}")
    if previous_params.empty?
      instance_variable_set("@#{method_name}", [params])
    else
      instance_variable_set("@#{method_name}", [previous_params, params])
    end
  end

  def reformat_params(params, method_name)
    # this method allow user to input simple datas and reformat the incoming datas so it always store a Hash
    # if its a string then the datas is put into the property content
    #   ex with color property : {color: {content: :red}}
    # if it's an array then property itself change from Hash type to array
    #   ex with color property{color: [{content: :red}{content: :yellow, x: 200}]}
    if params.class == Hash
      params
    elsif params.class == Array
      array_parsing params, method_name
    else
      { content: params }
    end
  end

  def method_analysis(params, instance_variable, method_name)
    # this method first send the params to the 'reformat_params' method to ensure it return a hash or an array
    params = reformat_params params, method_name
    # then etheir it parse the params if {add: true} is found, so it add the params to the property hash,
    # etheir it add any {key: :value} found to the instance variable property
    if params[:add] && params[:add] == true
      add_parsing params, method_name
    else
      params.each do |key, value|
        instance_variable[key] = value
      end
    end
    # now we apply the specific treatment according to the property found if the hash is not empty
    send(method_name + '_treatment', params) if params != {}
  end

  # specific property methods
  def proc_parsing(proc)
    # if the object property contain a Proc it'll be processed here
    proc
  end

  def render_parsing(params)
    # if the object property needs to be refresh then I'm your method
    Render.render_my_prop(self, params) if params[:refresh].nil? || params[:refresh] == true
  end

  def property_parsing(properties)
    # let's go with the DSP ...
    properties
  end

  def my_prop_treatment(params)
    # here happen the specific treatment for the current property
    if params.class == Hash
      proc_parsing params[:proc] if params && params[:proc]
      property_parsing params
      # if prop needs to be refresh we send it to the Render engine
      render_parsing params
    elsif params.class == Array
      # if params is an array is found we send each item of the array to 'my_prop_treatment' as a Hash
      params.each do |param|
        my_prop_treatment param
      end
    end
    broadcast(atome_id => { my_prop: params })
  end

  def my_prop(params = nil)
    # This is the entry point for property getter and setter:
    # this is the main entry method for the current property treatment
    # first we create a hash for the property if t doesnt exist
    # we don't create a object init time, to only create property when needed
    @my_prop ||= {}
    # we send the params to the 'reformat_params' if there's a params
    method_analysis params, @my_prop, :my_prop if params
    # finally we return the current property using magic_return
    magic_return @my_prop
  end
end

t = text({ content: '', y: 0 })
a = Eve.new
a.my_prop(:datas)
a.my_prop({ content: :doto, kool: :ok })
a.my_prop({ content: :didi, kool: :pas_ok, refresh: false })
t << "message :\n#{a.my_prop} : #{a.my_prop.class}\n from : app.rb : 80\n\n"
a.my_prop([{ content: :datos, x: 0 }, :toto])
a.my_prop({ content: :titi, kool: :ok2, add: true })
t << "message :\n#{a.my_prop} : #{a.my_prop.class}\n from : app.rb : 83"