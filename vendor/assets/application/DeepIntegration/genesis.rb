# frozen_string_literal: true

# used to store and retrieve atome optional methods
module Genesis
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

  def pluralized_helper(atome_type, params)
    params.each do |atome_id, property|
      if property.instance_of?(Hash)
        property[:parent] = id
        # property[:type] = :color
      end
      # TODO : check if we need to pass the id or not
      # we only add id for the renderer
      render({ atome_type => property.merge({ id: atome_id }) })
      send(atome_type).class.send(:attr_accessor, atome_id)
      new_atome = Atome.new
      new_atome.instance_variable_set('@content', property)
      send(atome_type).instance_variable_set("@#{atome_id}", new_atome)
    end
  end

  def create_pluralized_setter(atome_type, params)
    pluralised_instance_variable = "@#{atome_type}"
    unless instance_variable_get(pluralised_instance_variable)
      instance_variable_set(pluralised_instance_variable, Atome.new)
    end
    pluralized_helper(atome_type, params)
  end

  def get_atome(atome_name)
    instance_variable_get("@#{atome_name}")
  end

  def self.pluralized(atome_type)
    define_method atome_type do |params = nil|
      if params
        create_pluralized_setter(atome_type, params)
      else
        get_atome(atome_type)
      end
    end
  end

  def self.create_alternates_methods(atome_name, pluralized_name)
    method_equal(atome_name)
    pluralized(pluralized_name || "#{atome_name}s")
  end

  def atome_decision_stack(atome_name, params, proc)
    instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
    pluralized_atome_name = "#{atome_name}s".to_sym
    if params
      if  instance_variable_get("@#{pluralized_atome_name}")
        new_params = send(pluralized_atome_name)[0].content.merge(params)
        send(pluralized_atome_name)[0].content(new_params)
      else
        # no colors found : we create it
        new_atome_id = "a_#{atome_name}_#{Utilities.atomes.length}"
        puts new_atome_id
        # send({ new_atome_id => params })
      end

    else
      send(pluralized_atome_name).read[0]
    end
  end

  def self.new_atome(atome_name, pluralized_name = nil, &proc)
    Utilities.atomes(atome_name)
    Atome.define_method atome_name do |params = nil|
      atome_decision_stack(atome_name, params, proc)
    end
    create_alternates_methods(atome_name, pluralized_name)
  end

  def particle_setter_helper(params, particle_name)
    if @content
      @content[particle_name] = params
    else
      render({ particle_name => params })
      # instance_variable_set("@#{particle_name}", params)
      content[particle_name] = params
    end
  end

  def self.new_particle(particle_name, pluralized_name = nil, &proc)
    Utilities.particles(particle_name)
    # TO_DO: "we don't have to pass the atome just add the the atome hash "
    Atome.define_method particle_name do |params = nil|
      instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)
      if params
        particle_setter_helper(params, particle_name)
        # content[particle_name] = params
      elsif @content
        content[particle_name]
      else
        instance_variable_get(particle_name)
      end
    end
    create_alternates_methods(particle_name, pluralized_name)
  end
end
