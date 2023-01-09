# frozen_string_literal: true

# TODO : remove monitoring
# TODO : remove child
# TODO : remove parents

# main entry here
class Atome
  # TODO : clean or delete @private_atome
  include Essentials

  private

  def initialize(atomes = {}, &atomes_proc)
    atomes.each_value do |elements|
      # the instance variable below contain the id all any atomes that need to be informed when changes occurs
      @broadcast = {}
      # @at_time = {}
      # now we store the proc in a an atome's property called :bloc
      elements[:code] = atomes_proc if atomes_proc
      @atome = elements
      # we initiate the rendering, eg for for browser we will call :browser_type generate method in identity.rb file
      create_particle(:type, true, true)
      # set type is a particle method it's dynamically generated at : generator/identity.rb
      set_type(@atome[:type])
      collapse
    end
  end

  def new_particle(element,store,render, &method_proc)
    Atome.define_method element do |params = nil, &user_proc|
      if params || params == false
        # the line below execute the proc created when using the build_particle method
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        params = sanitize(element, params)
        create_particle(element,store,render)
        send("set_#{element}", params, &user_proc)
      else
        get_particle(element, &user_proc)
      end
    end
  end



  def additional_particle_methods(element,store,render , &method_proc)
    Atome.define_method "#{element}=" do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
      params = sanitize(element, params)
      particle_creation(element, params, store,render,&user_proc)
    end
  end


  def atome_creation_pre_treatment(element, params, &user_proc)
    params = sanitize(element, params)
    create_atome(element)
    send("set_#{element}", params, &user_proc)
  end

  def new_atome(element, &method_proc)
    Atome.define_method element do |params = nil, &user_proc|
      if params
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        atome_creation_pre_treatment(element, params, &user_proc)
      else
        get_atome(element, &user_proc)
      end
    end
    # the method below generate Atome method creation at Object level
    create_method_at_object_level(element)
  end

  def new_render_engine(renderer_name, &method_proc)
    Atome.define_method renderer_name do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
    end
  end

  def run_optional_proc(proc_name, atome = self, element, &user_proc)
    params=instance_variable_get("@#{element}")
    option_found = Universe.get_optional_method(proc_name)
    atome.instance_exec(params, user_proc, atome, &option_found) if option_found.is_a?(Proc)
  end


  def store_value(element)
    params=instance_variable_get("@#{element}")
    @atome[element] = params
  end

  public

  # the line below is used for ephemera atomes
  attr_accessor :property, :value, :real_atome, :user_proc
  attr_reader :atome, :structure#, :at_time

  def set(value)
    @real_atome[@property] = value
  end

  def particle_creation(element, params,store,render, &user_proc)
    return false unless security_pass(element, params)
    # we create a proc holder of any new particle if user pass a bloc
    store_code_bloc(element, &user_proc) if user_proc
    # Params is now an instance variable so it should be passed thru different methods
    instance_variable_set("@#{element}", params)
    run_optional_proc("pre_render_#{@atome[:type]}".to_sym, self, element, &user_proc)
    run_optional_proc("pre_render_#{element}".to_sym, self, element, &user_proc)
    rendering(element, &user_proc) if render
    run_optional_proc("post_render_#{@atome[:type]}".to_sym, self, element, &user_proc)
    run_optional_proc("post_render_#{element}".to_sym, self, element, &user_proc)
    broadcasting(element)
    store_value(element) if store
    self
  end


  def create_particle(element,store,render)
    Atome.define_method "set_#{element}" do |params, &user_proc|
      particle_creation(element, params, store,render,&user_proc)
    end
  end


  def get(element)
    @atome[element]
  end

  def get_particle(element, &user_proc)
    virtual_atome = Atome.new({})
    virtual_atome.value = (@atome[element])
    virtual_atome.real_atome = @atome
    virtual_atome.property = element
    virtual_atome.user_proc = user_proc
    run_optional_proc("pre_get_#{@atome[:type]}".to_sym, "virtual_atome", &user_proc)
    run_optional_proc("pre_get_#{element}".to_sym, self, "virtual_atome", &user_proc)
    virtual_atome
  end

  def get_atome(element, &user_proc)
    virtual_atome = Atome.new({})
    virtual_atome.real_atome = @atome
    virtual_atome.property = element
    virtual_atome.user_proc = user_proc
    virtual_atome.value = @atome[element]
    virtual_atome
  end

  def create_atome(new_atome)
    Atome.define_method "set_#{new_atome}" do |params, &user_proc|
      Atome.new({ new_atome => params }, &user_proc)
    end
  end

  Universe.connected
end
