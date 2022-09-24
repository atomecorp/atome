# frozen_string_literal: true

# used to generate atome
# module ParticleGenesis
#   def particle_setter_helper(params, particle_name)
#     if @content
#       @content[particle_name] = params
#     else
#       instance_variable_set("@#{particle_name}", params)
#     end
#     atomisation({ particle_name => params })
#   end
#
#   def particle_helper(params, particle_name)
#     if params
#       particle_setter_helper(params, particle_name)
#     elsif @content
#       content[particle_name]
#     else
#       instance_variable_get("@#{particle_name}")
#     end
#   end
# end

# used to store and retrieve atome optional methods
module Genesis
  # include ParticleGenesis
  @optional_methods = {}

  def self.set_optional_methods_helper(property_name, &proc)
    @optional_methods[property_name] = proc
  end

  def self.run_optional_methods_helper(method_name)
    # puts   "options are: #{@optional_methods[method_name] if @optional_methods}"
    @optional_methods[method_name] if @optional_methods
  end

  def self.new_atome_helper(property_name, &proc)
    proc = Genesis.set_optional_methods_helper(property_name, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
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

  def atome_already_created?(atome_name)
    if instance_variable_get("@#{atome_name}")
      puts :case1
      #   new_params = send(atome_name).content(params)
      #   send(atome_name).content(new_params)
    else
      puts :case2
      #   # no colors found : we create it
      #   new_atome_id = "a_#{atome_name}_#{Utilities.atomes.length}"
      #   # send(pluralized_name, { new_atome_id => params })
    end
    # atomisation({ atome_name => params })
  end

  # def atome_decision_stack(method_name, params, proc)
  #   # let's exec the bloc if there's any
  #   # puts method_name
  #   # instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
  #   if params
  #     #let's check if the atome type container is already created or not?
  #     if instance_variable_get("@#{method_name}")
  #     else
  #       instance_variable_set("@#{method_name}",[params])
  #     end
  #   else
  #     instance_variable_get("@#{method_name}")
  #     # send(method_name).read[0]
  #   end
  # end

  def decision_stack(method_name, params, proc)
    # let's exec the bloc if there's any
    # instance_exec({ options: params }, &proc) if proc.is_a?(Proc)
    if params
      # we try to execute the pre_render_proc if any
      Genesis.run_optional_methods_helper("#{method_name}_render_pre_proc".to_sym)
      # render here maybe !!!!!!!!!!
      # let's check if the method already exist?
      if instance_variable_get("@#{method_name}")
      else
        instance_variable_set("@#{method_name}", [params])
      end
      # we try to execute the pre_render_proc if any
      Genesis.run_optional_methods_helper("#{method_name}_render_post_proc".to_sym)
      # puts "method_name : #{params}"
      # send(method_name,params)
    else


      # we try to execute the pre_render_proc if any
      Genesis.run_optional_methods_helper("#{method_name}_getter_pre_proc".to_sym)
      instance_variable_get("@#{method_name}")
      # we try to execute the pre_render_proc if any
      Genesis.run_optional_methods_helper("#{method_name}_getter_post_proc".to_sym)
      # send(method_name)
    end
    # if validation(:particle, method_name, params)
    # nil unless validation(method_name)
  end

  def self.new_atome(method_name, &proc)

    # we store the newly created atome in the atome's list
    Utilities.atomes(method_name)
    # we executed proc for this particular if there's any
    instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)
    # now let's create the method
    Atome.define_method method_name do |params = nil|
      # puts "@optional_methods : #{@optional_methods}"

      # puts "method_name is #{@optional_methods}"
      # optional_pre_render_proc=@optional_methods["#{method_name}_render_pre_proc"]
      # puts "optional_pre_render_proc : #{optional_pre_render_proc}"
      # instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)


      # send the methods and params to the atome decision stack
      decision_stack(method_name, params, proc) if validation(method_name)

   end
    # also create the corresponding 'method_name=' method
    method_equal(method_name)
  end

  def self.new_particle(method_name, &proc)
    # Utilities.particles(particle_name)
    Atome.define_method method_name do |params = nil|

      # puts method_name
      # instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)
      decision_stack(method_name, params, proc) if validation(method_name)
      # particle_helper(params, method_name)
    end
    method_equal(method_name)
  end

end
