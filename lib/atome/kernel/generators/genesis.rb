# frozen_string_literal: true
# TODO: parent are not set correctly if not explicitly specified when attaching a child ex: b=box();c=b.box, c is not
# attached to b
# Genesis helper
module GenesisHelper
  def broadcaster(property, value)
    "broadcast : #{property} #{value}"
  end

  def history(property, value)
    "historize : #{property} #{value}"
  end
end

# genesis kernel
module GenesisKernel
  # particle's methods
  def set_new_particle(particle, value, &proc)
    return false unless validation(particle)

    # instance_exec({ options: value }, &proc) if proc.is_a?(Proc)
    # now we exec the first optional method
    value = Genesis.run_optional_methods_helper("#{particle}_pre_render_proc".to_sym,
                                                { method: particle, value: value, atome: self, proc: proc })
    # render option below
    Genesis.run_optional_methods_helper("#{particle}_render_proc".to_sym,
                                        { method: particle, value: value, atome: self, proc: proc })
    # now we exec post render optional proc
    value = Genesis.run_optional_methods_helper("#{particle}_post_render_proc".to_sym,
                                                { method: particle, value: value, proc: proc })
    broadcaster(particle, value)
    history(particle, value)
    self
  end

  def get_new_particle(particle)
    return false unless validation(particle)
    particle_instance_variable = "@#{particle}"
    value_getted=instance_variable_get(particle_instance_variable)
    Genesis.run_optional_methods_helper("#{particle}_getter_pre_proc".to_sym, { value: value_getted, atome: self })
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
    params.each do |param, value|
      new_atome.send(param, value)
    end
  end

  def set_new_atome(atome, params, proc)
    return false unless validation(atome)

    instance_var = "@#{atome}"
    # now we exec the first optional method
    params=Genesis.run_optional_methods_helper("#{atome}_pre_save_proc".to_sym, { value: params, proc: proc })
    create_new_atomes(params[:value], instance_var, atome)
    # now we exec the second optional method
    Genesis.run_optional_methods_helper("#{atome}_post_save_proc".to_sym, { value: params, proc: proc })
    @dna = "#{Atome.current_user}_#{Universe.app_identity}_#{Universe.atomes.length}"
    self
  end

  def get_new_atome(atome)
    return false unless validation(atome)

    # Genesis.run_optional_methods_helper("#{atome}_getter_pre_proc".to_sym, { value: false })
    atome_instance_variable = "@#{atome}"
    value_getted=instance_variable_get(atome_instance_variable)
    Genesis.run_optional_methods_helper("#{atome}_getter_pre_proc".to_sym, { value: value_getted })

  end

  def new_atome(atome, params, userproc, &methodproc)
    if params
      params = instance_exec(params, &methodproc) if methodproc.is_a?(Proc)
      params = add_essential_properties(atome, params)
      params = sanitizer(params)
      set_new_atome(atome, params, userproc)
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

  # include ParticleGenesis
  @optionals_methods = {}

  def self.atome_creator_option(property_name, &proc)
    @optionals_methods[property_name] = proc
  end

  def self.run_optional_methods_helper(method_name, params, atome=nil)
    proc = nil
    proc = @optionals_methods[method_name] if @optionals_methods
    instance_exec(params,atome, &proc) if proc.is_a?(Proc)
  end

  # #fIXME : we may have to remove the 2 methods below its only for test

  # render methods generator
  def self.generate_html_renderer(method_name, &methods_proc)
    current_renderer = :html
    generated_method_name = "#{method_name}_#{current_renderer}".to_sym
    Atome.define_method generated_method_name do |value, atome, &user_proc|
      instance_exec(value, atome, user_proc, &methods_proc) if methods_proc.is_a?(Proc)
    end
  end

  def self.generate_server_renderer(method_name, &methods_proc)
    current_renderer = :headless
    generated_method_name = "#{method_name}_#{current_renderer}".to_sym
    Atome.define_method generated_method_name do |value, atome, &user_proc|
      instance_exec(value, atome, user_proc, &methods_proc) if methods_proc.is_a?(Proc)
    end
  end

  # rendering methods are generated below:
  def self.generate_renderers_methods(method_name)
    # now we auto generate all rendering methods
    Utilities.renderer_list.each do |render_method|
      define_singleton_method("generate_#{render_method}_renderer") do |method_name, &methods_proc|
        current_renderer = render_method
        generated_method_name = "#{method_name}_#{current_renderer}".to_sym
        Atome.define_method generated_method_name do |value, atome, &user_proc|
          instance_exec(value, atome, user_proc, &methods_proc) if methods_proc.is_a?(Proc)
        end
      end

      send("generate_#{render_method}_renderer", method_name)
    end

    Genesis.atome_creator_option("#{method_name}_post_render_proc".to_sym) do |params|
      # we return the value
      params[:value]
    end
  end

  def self.optional_atome_methods(method_name)
    Genesis.atome_creator_option("#{method_name}_pre_save_proc".to_sym) do |params, proc|
      # we return the value
      params
    end

    Genesis.atome_creator_option("#{method_name}_sanitizer_proc".to_sym) do |params,atome, proc|
      # we return the value
      params
    end

    Genesis.atome_creator_option("#{method_name}_getter_pre_proc".to_sym) do |params,atome, proc|
      # we return the value
      params[:value]
    end

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
    generate_renderers_methods(method_name)
  end

  # we create the easy methods here : ¬
  def self.atome_creator(method_name, &methodproc)
    # instance_exec(method_name, &methodproc) if methodproc.is_a?(Proc)
    # we add the new method to the atome's collection of methods
    Utilities.atome_list(method_name)
    # we define many methods : easy, method=,pluralised and the fasts one, here is the easy
    Atome.define_method method_name do |params = nil, &user_proc|
      new_atome(method_name, params, user_proc, &methodproc)
    end
    # no we also add the method= for easy setting
    Atome.define_method("#{method_name}=") do |params, &user_proc|
      new_atome(method_name, params, user_proc)
    end
    optional_atome_methods(method_name)
    additional_atome_methods(method_name)
  end

  def self.optional_particle_methods(method_name)
    # The rendering occur here setting up the optional rendering  by default
    Genesis.atome_creator_option("#{method_name}_render_proc".to_sym) do |params|
      params[:atome].render_engine(params[:method], params[:value], params[:atome], &params[:proc])
      # we return the value
      params[:value]
    end
    Genesis.atome_creator_option("#{method_name}_pre_render_proc".to_sym) do |params|
      particle_instance_variable = "@#{params[:method]}"
      params[:atome].instance_variable_set(particle_instance_variable, params[:value])
      # we return the value
      params[:value]
    end
    Genesis.atome_creator_option("#{method_name}_post_render_proc".to_sym) do |params|
      # we return the value
      params[:value]
    end
    Genesis.atome_creator_option("#{method_name}_getter_pre_proc".to_sym) do |params|
      # we return the value
      params[:value]
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
    # now we generate all basic default rendering methods
    generate_renderers_methods(method_name)
    # now we generate all optional methods
    optional_particle_methods(method_name)
  end

  def self.particle_creator(method_name, &proc)
    instance_exec(method_name, &proc) if proc.is_a?(Proc)
    # we add the new method to the particle's collection of methods
    Utilities.particle_list(method_name)
    Atome.define_method method_name do |params = nil, &user_proc|
      new_particle(method_name, params, user_proc)
    end
    # no we also add the method= for easy setting
    Atome.define_method("#{method_name}=") do |params, &user_proc|
      new_particle(method_name, params, user_proc)
    end
    additional_particle_methods(method_name)
  end
end
