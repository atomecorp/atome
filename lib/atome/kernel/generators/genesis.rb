# frozen_string_literal: true

# used to generate atome
module ParticleGenesis
  def particle_setter_helper(params, particle_name)
    if @content
      @content[particle_name] = params
    else
      instance_variable_set("@#{particle_name}", params)
    end
    atomisation({ particle_name => params })
  end

  def particle_helper(params, particle_name)
    if params
      particle_setter_helper(params, particle_name)
    elsif @content
      content[particle_name]
    else
      instance_variable_get("@#{particle_name}")
    end
  end
end

# used to store and retrieve atome optional methods
module Genesis
  include ParticleGenesis
  @optionals_methods = {}

  def self.set_atome_helper(property_name, &proc)
    @optionals_methods[property_name] = proc
  end

  def self.get_atome_helper(method_name)
    @optionals_methods[method_name] if @optionals_methods
  end

  def self.new_atome_helper(property_name, &proc)
    Genesis.set_atome_helper(property_name, &proc)
  end

  def self.method_equal(method_name)
    define_method("#{method_name}=") do |params, &proc|
      send(method_name, params, &proc)
    end
  end

  def set_essential_properties(atome_type, atome_id, property)
    property[:parent] = id
    property[:type] = atome_type.to_sym
    property[:id] = atome_id
    nil unless property.instance_of?(Hash)
  end

  def pluralized_helper(pluralized_type, atome_type, params)
    params.each do |atome_id, property|
      set_essential_properties(atome_type, atome_id, property)
      # TODO : check if we need to pass the id or not
      atomisation({ pluralized_type => property })
      send(pluralized_type).class.send(:attr_accessor, atome_id)
      new_atome = Atome.new
      new_atome.instance_variable_set('@content', property)
      send(pluralized_type).instance_variable_set("@#{atome_id}", new_atome)
    end
  end

  def create_pluralized_setter(pluralized_type, atome_type, params)
    pluralised_instance_variable = "@#{pluralized_type}"
    unless instance_variable_get(pluralised_instance_variable)
      instance_variable_set(pluralised_instance_variable, Atome.new)
    end
    pluralized_helper(pluralized_type, atome_type, params)
  end

  def get_atome(atome_name)
    instance_variable_get("@#{atome_name}")
  end

  def self.pluralized(atome_type)
    pluralized_type = "#{atome_type}s"
    define_method pluralized_type do |params = nil|
      if validation(:atomes, atome_type, params)
        if params
          create_pluralized_setter(pluralized_type, atome_type, params)
        else
          get_atome(pluralized_type)
        end
      end
    end
  end

  def self.create_alternates_methods(atome_type, pluralized_name)
    method_equal(atome_type)
    pluralized(pluralized_name || atome_type)
  end

  def atome_test_if_already_exist(atome_name, pluralized_name, params)
    if instance_variable_get("@#{pluralized_name}")
      new_params = send(pluralized_name)[0].content.merge(params)
      send(pluralized_name)[0].content(new_params)
    else
      # no colors found : we create it
      new_atome_id = "a_#{atome_name}_#{Utilities.atomes.length}"
      send(pluralized_name, { new_atome_id => params })
    end
    atomisation({ atome_name => params })
  end

  def atome_decision_stack(atome_name, params, proc)
    instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
    pluralized_atome_name = "#{atome_name}s".to_sym
    if params
      atome_test_if_already_exist(atome_name, pluralized_atome_name, params)
    else
      send(pluralized_atome_name).read[0]
    end
  end

  def self.new_atome(atome_name, pluralized_name = nil, &proc)
    Utilities.atomes(atome_name)
    Atome.define_method atome_name do |params = nil|
      atome_decision_stack(atome_name, params, proc) if validation(:atome, atome_name, params)
    end
    create_alternates_methods(atome_name, pluralized_name)
  end

  def self.new_particle(particle_name, &proc)
    Utilities.particles(particle_name)
    Atome.define_method particle_name do |params = nil|
      if validation(:particle, particle_name, params)
        instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)
        particle_helper(params, particle_name)
      end
    end
  end


end
