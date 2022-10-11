# frozen_string_literal: true

# Genesis helper
module GenesisHelper
  def broadcaster(property, value)
    "historize : #{property} #{value}"
  end

  def history(property, value)
    "broadcast : #{property} #{value}"
  end
end

# genesis kernel
module GenesisKernel
  # particle's methods
  def set_new_particle(particle, value, &proc)
    return false unless validation(particle)

    # instance_exec({ options: value }, &proc) if proc.is_a?(Proc)
    Genesis.run_optional_methods_helper("#{particle}_pre_render_proc".to_sym,
                                        { method: particle, value: value, atome: self })
    # render option below
    Genesis.run_optional_methods_helper("#{particle}_render_proc".to_sym,
                                        { method: particle, value: value, atome: self, proc: proc })
    Genesis.run_optional_methods_helper("#{particle}_post_render_proc".to_sym,
                                        { method: particle, value: value })
    broadcaster(particle, value)
    history(particle, value)
  end

  def get_new_particle(particle)
    return false unless validation(particle)

    Genesis.run_optional_methods_helper("#{particle}_getter_pre_proc".to_sym, { value: false })
    particle_instance_variable = "@#{particle}"
    instance_variable_get(particle_instance_variable)
  end

  def new_particle(particle, params, proc)
    if params
      set_new_particle(particle, params, &proc)
    else
      get_new_particle(particle)
    end
  end

  # atome's methods

  def create_new_atomes(params, instance_var, _atome)
    new_atome = Atome.new({})
    instance_variable_set(instance_var, new_atome)
    # FIXME : move this to sanitizer and ensure that no reorder happen for "id" and "render" when
    # creating an atome using Atome.new
    # params = { type: atome }.merge(params)
    # # we extract render to ensure it's the first element of the hash
    # params = { render: params.delete(:render) }.merge(params)
    params.each do |param, value|
      new_atome.send(param, value)
    end
  end

  def set_new_atome(atome, params, proc)
    return false unless validation(atome)

    instance_var = "@#{atome}"
    # now we exec the method specific to the type if it exist
    # instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
    # now we exec the first optional method
    Genesis.run_optional_methods_helper("#{atome}_pre_save_proc".to_sym, { value: params })
    create_new_atomes(params, instance_var, atome)
    Genesis.run_optional_methods_helper("#{atome}_post_save_proc".to_sym, { value: params })
    @dna = "#{Atome.current_user}_#{Universe.app_identity}_#{Universe.atomes.length}"
  end

  def get_new_atome(atome)
    return false unless validation(atome)

    Genesis.run_optional_methods_helper("#{atome}_getter_pre_proc".to_sym, { value: false })
    atome_instance_variable = "@#{atome}"
    instance_variable_get(atome_instance_variable)
  end

  def new_atome(atome, params, proc)
    if params
      params = add_essential_properties(atome, params)
      params = sanitizer(params)
      set_new_atome(atome, params, proc)
    else
      get_new_atome(atome)
    end
  end

  def additional_atomes(atome, params)
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

  def self.run_optional_methods_helper(method_name, params)
    proc = nil
    proc = @optionals_methods[method_name] if @optionals_methods
    instance_exec(params, &proc) if proc.is_a?(Proc)
  end

  def self.additional_atome_methods(method_name)
    # here is the pluralized
    Atome.define_method "#{method_name}s" do |params = nil|
      additional_atomes(method_name, params)
    end
    # here is the fast methods
    Atome.define_method "set_#{method_name}" do |params = nil, &proc|
      set_new_atome(method_name, params, proc)
    end
    Atome.define_method "get_#{method_name}" do
      get_new_atome(method_name)
    end
  end

  # we create the easy methods here : ¬
  def self.atome_creator(method_name, &proc)
    instance_exec(method_name, &proc) if proc.is_a?(Proc)
    # we add the new method to the atome's collection of methods
    Utilities.atomes(method_name)
    # we define many methods : easy, method=,pluralised and the fasts one, here is the easy
    Atome.define_method method_name do |params = nil, &user_proc|
      new_atome(method_name, params, user_proc)
    end
    # no we also add the method= for easy setting
    define_method("#{method_name}=") do |params, &user_proc|
      new_atome(method_name, params, user_proc)
    end
    additional_atome_methods(method_name)
  end

  def self.optional_particle_methods(method_name)
    # The rendering occur here setting up the optional rendering  by default
    Genesis.atome_creator_option("#{method_name}_render_proc".to_sym) do |params|
      params[:atome].render_engine(params[:method], params[:value], params[:atome], &params[:proc])
    end
    Genesis.atome_creator_option("#{method_name}_pre_render_proc".to_sym) do |params|
      particle_instance_variable = "@#{params[:method]}"
      params[:atome].instance_variable_set(particle_instance_variable, params[:value])
    end
  end

  def self.additional_particle_methods(method_name)
    # here is the fast methods
    Atome.define_method "set_#{method_name}" do |params, &proc|
      set_new_particle(method_name, params, &proc)
    end

    Atome.define_method "get_#{method_name}" do
      get_new_particle(method_name)
    end
    optional_particle_methods(method_name)
  end

  def self.particle_creator(method_name, &proc)
    instance_exec(method_name, &proc) if proc.is_a?(Proc)
    # we add the new method to the particle's collection of methods
    Utilities.particles(method_name)
    Atome.define_method method_name do |params = nil, &user_proc|
      new_particle(method_name, params, user_proc)
    end
    # no we also add the method= for easy setting
    define_method("#{method_name}=") do |params, &user_proc|
      new_particle(method_name, params, user_proc)
    end
    additional_particle_methods(method_name)
  end
end
