# frozen_string_literal: true

# main entry here
class Atome
  # TODO : clean or delete @private_atome
  include Sanitizer

  private

  @atome = {}

  def initialize(atomes = {}, &atomes_proc)
    atomes.each_value do |elements|
      @broadcast = {}
      Universe.add_to_atomes({ elements[:id] => self })
      elements[:bloc] = atomes_proc if atomes_proc
      @atome = elements
      collapse
    end
  end

  def new_particle(element, &method_proc)
    Atome.define_method element do |params = nil, &user_proc|
      if params
        # the line below execute the proc created when using the build_particle method
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        sanitize_particle(element, params, &user_proc)
      else
        get_particle(element, &user_proc)
      end
    end
  end

  def additional_particle_methods(element, &method_proc)
    Atome.define_method "#{element}=" do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
      sanitize_particle(element, params, &user_proc)
    end
  end

  def new_atome(element, &method_proc)
    Atome.define_method element do |params = nil, &user_proc|
      if params
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        params = atome_sanitizer(element, params)
        Atome.new({ element => params })
      else
        get_atome(element, &user_proc)
      end
    end
  end

  def new_render_engine(renderer_name, &method_proc)
    Atome.define_method renderer_name do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
    end
  end

  def run_optional_proc(proc_name, atome = self, value = nil)
    option_found = Universe.get_optionals_methods(proc_name)
    atome.instance_exec(value, &option_found) if option_found.is_a?(Proc)
  end

  def inject_value(element, value)
    @atome[element] = value
  end

  def store_value(element, value)
    # this method save the value of the particle and broadcast to the atomes listed in broadcast
    broadcasting(element, value)
    inject_value(element, value)
  end

  public

  # the line below is used for ephemera atomes
  attr_accessor :property, :value, :real_atome, :user_proc

  def set(value)
    @real_atome[@property] = value
  end

  def create_particle(element, value, &user_proc)
    return false unless security_pass(element, value)

    run_optional_proc("pre_save_#{element}".to_sym, self, value)
    store_value(element, value)
    run_optional_proc("post_save_#{element}".to_sym, self, value)
    rendering(element, value, &user_proc)
    run_optional_proc("post_render_#{element}".to_sym, self, value)
    self
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
    run_optional_proc("pre_get_#{element}".to_sym, virtual_atome)
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
    Atome.new(new_atome)
  end

  Universe.connected
end
