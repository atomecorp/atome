# frozen_string_literal: true

# Genesis helper
module GenesisHelper
  def drms(method)
    {} if method
  end

  def broadcaster(property, value)
    "historise : #{property} #{value}"
  end

  def history(property, value)
    "broadcast : #{property} #{value}"
  end

end

# genesis kernel
module GenesisKernel
  # particle's methods
  def set_new_particle(particle, params, proc)
    return false unless validation(particle)

    Genesis.run_optional_methods_helper("#{particle}_pre_save_proc".to_sym)
    particle_instance_variable = "@#{particle}"
    instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
    instance_variable_set(particle_instance_variable, params)
    Genesis.run_optional_methods_helper("#{particle}_pre_render_proc".to_sym)
    Render.render(particle, params, self, &proc)
    Genesis.run_optional_methods_helper("#{particle}_post_render_proc".to_sym)
    broadcaster(particle, params)
    history(particle, params)
  end

  def get_new_particle(particle)
    return false unless validation(particle)

    Genesis.run_optional_methods_helper("#{particle}_getter_pre_proc".to_sym)
    particle_instance_variable = "@#{particle}"
    instance_variable_get(particle_instance_variable)
  end

  def new_particle(particle, params, proc)
    if params
      set_new_particle(particle, params, proc)
    else
      get_new_particle(particle)
    end
  end

  # atome's methods

  def set_new_atome(atome, params, proc)
    return false unless validation(atome)

    atome_instance_variable = "@#{atome}"
    # now we exec the method specific to the tyupe if it exist
    instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
    new_atome = Atome.new({})
    # now we exec the first optional method
    Genesis.run_optional_methods_helper("#{atome}_pre_save_proc".to_sym)
    instance_variable_set(atome_instance_variable, new_atome)
    params.each do |param, value|
      new_atome.send(param, value)
    end
    Genesis.run_optional_methods_helper("#{atome}_post_save_proc".to_sym)
  end

  def get_new_atome(atome)
    return false unless validation(atome)

    Genesis.run_optional_methods_helper("#{atome}_getter_pre_proc".to_sym)
    atome_instance_variable = "@#{atome}"
    instance_variable_get(atome_instance_variable)
  end

  def new_atome(atome, params, proc)
    if params
      sanitizer(params)
      add_missing(params)
      set_new_atome(atome, params, proc)
    else
      get_new_atome(atome)
    end
  end

  def additional_atomes(atome, params, _proc)
    atome_instance_variable = "@#{atome}"
    if params
      instance_variable_get(atome_instance_variable).additional(params)
    else
      instance_variable_get(atome_instance_variable).additional
    end
  end
end

# main entry for genesis
module Genesis
  include GenesisHelper
  include GenesisKernel

  def self.default_value
    { render: [:html] }
  end

  # include ParticleGenesis
  @optionals_methods = {}
  @optionals_methods = {}

  def self.atome_creator_option(property_name, &proc)
    @optionals_methods[property_name] = proc
  end

  def self.run_optional_methods_helper(method_name)
    proc = nil
    proc = @optionals_methods[method_name] if @optionals_methods
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def self.additional_atome_methods(method_name, render, &proc)
    # here is the pluralized
    Atome.define_method "#{method_name}s" do |params = nil|
      additional_atomes(method_name, params, render, &proc)
    end

    # here is the fast methods
    Atome.define_method "set_#{method_name}" do |params = nil|
      set_new_atome(method_name, params, render, &proc)
    end
    Atome.define_method "get_#{method_name}" do
      get_new_atome(method_name)
    end
  end

  # we create the easy methods here : ¬
  def self.atome_creator(method_name, render = Genesis.default_value[:render], &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    # we add the new method to the atome's collection of methods
    Utilities.atomes(method_name)
    # we define many methods : easy, method=,pluralised and the fasts one, here is the easy
    Atome.define_method method_name do |params = nil|
      new_atome(method_name, params, render, &proc)
    end

    # no we also add the method= for easy setting
    define_method("#{method_name}=") do |params|
      new_atome(method_name, params, render, &proc)
    end
    additional_atome_methods(method_name, render, &proc)
  end

  def self.additional_particle_methods(method_name)
    # here is the fast methods
    Atome.define_method "set_#{method_name}" do |params, &proc|
      set_new_particle(method_name, params, &proc)
    end

    Atome.define_method "get_#{method_name}" do
      get_new_particle(method_name)
    end
  end

  def self.particle_creator(method_name, &proc)
    # we add the new method to the particle's collection of methods
    Utilities.particles(method_name)
    Atome.define_method method_name do |params = nil|
      new_particle(method_name, params, proc)
    end
    # no we also add the method= for easy setting
    define_method("#{method_name}=") do |params|
      new_particle(method_name, params, proc)
    end
    additional_particle_methods(method_name, &proc)
  end
end
