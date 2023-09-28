# frozen_string_literal: true

# TODO : remove monitoring
# TODO : remove child
# TODO : remove parents

# main entry here
class Atome
  # TODO : clean or delete @private_atome
  include Essentials

  private

  def initialize(new_atome = nil, &atomes_proc)

    # the keys :renderers, :type and :id should be placed in the first position in the hash
    @broadcast = {}
    # now we store the proc in a an atome's property called :bloc
    new_atome[:code] = atomes_proc if atomes_proc
    @atome = new_atome
    # we initiate the rendering using set_type method,
    # eg : for for browser we will call :browser_type generate method in identity.rb file
    # FIXME : try to remove the condition below (it crash in the method :  def generator ... in genesis.rb)
    collapse if new_atome

  end

  def new_particle(element, store, render, &method_proc)
    Atome.define_method element do |params = nil, &user_proc|
      if params || params == false
        # the line below execute the proc created when using the build_particle method
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        params = particle_sanitizer(element, params, &user_proc)
        create_particle(element, store, render)
        group_particle_analysis(element, params, &user_proc) if @atome[:type] == :group
        send("set_#{element}", params, &user_proc)
      else
        @atome[element]
      end
    end
  end

  def additional_particle_methods(element, store, rendering, &method_proc)
    Atome.define_method "#{element}=" do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
      params = particle_sanitizer(element, params)
      particle_creation(element, params, store, rendering, &user_proc)
    end
  end

  def new_atome(element, &method_proc)
    # the method define below is the slowest but params are analysed and sanitized
    Atome.define_method element do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)

      atome_sanitizer(element, params, &user_proc)

    end

    # the method define below is the fastest params are passed directly
    Atome.define_method "set_#{element}" do |params, &user_proc|
      # we generate the corresponding module here:
      # Object.const_set(element, Module.new)
      # we add the newly created atome to the list of "child in it's category, eg if it's a shape we add the new atome
      # to the shape particles list : @atome[:shape] << params[:id]
      new_atome = Atome.new(params, &user_proc)
      new_atome
      # Now we return the newly created atome instead of the current atome that is the parent cf: b=box; c=b.circle
    end
  end

  def store_value(element)

    params = instance_variable_get("@#{element}")
    @atome[element] = params

  end

  public

  # the line below is used for ephemera atomes
  attr_accessor :property, :value, :real_atome, :user_proc
  attr_reader :atome, :structure # , :at_time

  def set(value)
    @real_atome[@property] = value
  end

  def particle_creation(element, params, store, rendering, &user_proc)
    return false unless security_pass(element, params)

    @store_allow = false
    # Params is now an instance variable so it should be passed thru different methods
    instance_variable_set("@#{element}", params) if store
    if Atome.instance_variable_get("@pre_#{element}").is_a?(Proc) # post is before rendering and broadcasting
      instance_exec(params, user_proc, self, &Atome.instance_variable_get("@pre_#{element}"))
    end
    render(element, params, &user_proc) if rendering
    broadcasting(element)
    if Atome.instance_variable_get("@post_#{element}").is_a?(Proc) # post is after rendering and broadcasting
      instance_exec(params, user_proc, self, &Atome.instance_variable_get("@post_#{element}"))
    end

    store_value(element) if store
    # we create a proc holder of any new particle if user pass a bloc
    store_proc(element, params, &user_proc) if user_proc
    @store_allow = true

    if Atome.instance_variable_get("@after_#{element}").is_a?(Proc) # after is post saving
      instance_exec(params, user_proc, self, &Atome.instance_variable_get("@after_#{element}"))
    end

    self
  end

  def create_particle(element, store, render)
    Atome.define_method "set_#{element}" do |params, &user_proc|
      particle_creation(element, params, store, render, &user_proc)
    end
  end

  def get(element)
    @atome[element]
  end

  Universe.connected
end

