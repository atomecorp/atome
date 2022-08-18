
# used to store and retrieve atome optional methods
module Genesis

  @optionals_methods = {}
  def self.set_atome_helper(property_name, &proc)
    @optionals_methods[property_name] = proc
  end

  def self.get_atome_helper(method_name)
    @optionals_methods[method_name] if @optionals_methods
  end

  def self.new_atome_helper(property_name,&proc)
    Genesis.set_atome_helper(property_name, &proc)
  end

  def self.method_equal(method_name)
    define_method("#{method_name}=",) do |params,&proc|
      send(method_name, params,&proc)
    end
  end

  def self.pluralized(method_name)
    Object.define_method method_name do |params = nil,&proc|
      if params
        unless @atomes
          @atomes = Atome.new
          @atomes.type(:container)
        end
        param = { red: params, green: 66 }
        # TODO: dont set content this way use  << or create a contents or use content.add(param)
        @atomes.atomes(Atome.new(param))
      else
        @atomes
      end
    end
  end

  def self.create_alternates_methods(atome_name,pluralized_name)
    method_equal(atome_name)
    if pluralized_name
      pluralized(pluralized_name)
    else
      pluralized("#{atome_name}s")
    end
  end

  def get_atome(atome_name)
    # TO_DO: add security check for read method here
    getter_stack(instance_variable_get("@#{atome_name}"))
    property_searched = Atome.new
    @value[:atomes].each do |atome|
      property_searched << atome if atome.value[:type] == atome_name
    end
    property_searched
  end

  def self.new_molecule(atome_name, &proc)
    Object.define_method atome_name do |params = nil|
      params = Sanitizer.default_params[atome_name].merge(params)
      Atome.new.instance_exec(params, &proc) if proc.is_a?(Proc)
    end
  end

  def self.new_atome(atome_name,pluralized_name=nil, &proc)
    Atome.atomes(atome_name)
    # TO_DO: we just have to pass the atome to attach it to the parent'
    Object.define_method atome_name do |params = nil|
      instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
      if params
        atome_stack(atome_name,params)
        # instance_variable_set("@#{atome_name}",params)
      else
        # get_atome(atome_name)
        instance_variable_get("@#{atome_name}")
      end
    end
    create_alternates_methods(atome_name, pluralized_name)
  end

  def self.new_particle(particle_name, pluralized_name=nil,&proc)
    Atome.particles(particle_name)
    # TO_DO: "we don't have to pass the atome just add the the atome hash "
    Object.define_method particle_name do |params = nil|
      instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)
      if params
        particle_stack(particle_name, params)
      else
        # TO_DO: add security check for read method here
        instance_variable_get("@#{particle_name}")
      end
    end
    create_alternates_methods(particle_name,pluralized_name)
  end
end