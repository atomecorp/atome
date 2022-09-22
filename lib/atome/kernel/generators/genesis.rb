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
  # include ParticleGenesis
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

  # def set_essential_properties(atome_type, atome_id, property)
  #   property[:parent] = id
  #   property[:type] = atome_type.to_sym
  #   property[:id] = atome_id
  #   nil unless property.instance_of?(Hash)
  # end



  # def get_atome(atome_name)
  #   instance_variable_get("@#{atome_name}")
  # end



  # def self.create_alternates_methods(atome_type, pluralized_name)
  #   method_equal(atome_type)
  # end

  def atome_test_if_already_exist(atome_name, params)
    if instance_variable_get("@#{atome_name}")
      new_params = send(atome_name).content(params)
      send(atome_name).content(new_params)
    else
      # no colors found : we create it
      new_atome_id = "a_#{atome_name}_#{Utilities.atomes.length}"
      # send(pluralized_name, { new_atome_id => params })
    end
    atomisation({ atome_name => params })
  end

  def atome_decision_stack(method_name, params, proc)

    instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
    # if params
    #   # atome_test_if_already_exist(method_name, params)
    # else
    #   # send(method_name).read[0]
    # end
  end

  def self.new_atome(method_name, &proc)
    Utilities.atomes(method_name)
    Atome.define_method method_name do |params = nil|
      atome_decision_stack(method_name, params, proc) if validation(:atome, method_name, params)
    end
    method_equal(method_name)
  end

  def self.new_particle(particle_name, &proc)
    # Utilities.particles(particle_name)
    # Atome.define_method particle_name do |params = nil|
    #   if validation(:particle, particle_name, params)
    #     instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)
    #     particle_helper(params, particle_name)
    #   end
    # end
  end


end
