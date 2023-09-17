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
        params = sanitize(element, params, &user_proc)
        create_particle(element, store, render)
        if @atome[:type] == :group
          group_particle_analysis(element, params, &user_proc)
        end
        send("set_#{element}", params, &user_proc)
      else
        @atome[element]
      end
    end
  end

  def additional_particle_methods(element, store, rendering, &method_proc)
    Atome.define_method "#{element}=" do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
      params = sanitize(element, params)
      particle_creation(element, params, store, rendering, &user_proc)
    end
  end

  def atome_parsing(element, params, &user_proc)
    if params
      params = sanitize(element, params)
      # TODO: replace with the line below but need extensive testing as it crash some demos ex: animation
      params = atome_common(element, params)
      # run_optional_proc("pre_render_#{@atome[:type]}".to_sym, self, params, &user_proc)
      # run_optional_proc("post_render_#{@atome[:type]}".to_sym, self, params, &user_proc)
      self.instance_exec(params, user_proc, self, &Atome.instance_variable_get("@pre_#{element}")) if Atome.instance_variable_get("@pre_#{element}").is_a?(Proc)
      self.instance_exec(params, user_proc, self, &Atome.instance_variable_get("@post_#{element}")) if Atome.instance_variable_get("@post_#{element}").is_a?(Proc)
      send("set_#{element}", params, &user_proc) # it call  Atome.define_method "set_#{element}" in  new_atome method
    else
      group(@atome["#{element}s"])
    end

  end

  def new_atome(element, &method_proc)
    # the method define below is the slowest but params are analysed and sanitized
    Atome.define_method element do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
      atome_parsing(element, params, &user_proc)
    end

    # the method define below is the fastest params are passed directly
    Atome.define_method "set_#{element}" do |params, &user_proc|
      capitalized_element=element.to_s.capitalize
      # we generate the corresponding module here:
      puts "#{element} : #{params}"
      Object.const_set(capitalized_element, Module.new)
      # we add the newly created atome to the list of "child in it's category, eg if it's a shape we add the new atome
      # to the shape particles list : @atome[:shape] << params[:id]
      alert 'the lone below create an infinite loop'
      new_atome = Atome.new({ element => params }, &user_proc)
      module_to_extend = Object.const_get(element)
      new_atome.extend(module_to_extend)
      new_atome
      # Now we return the newly created atome instead of the current atome that is the parent cf: b=box; c=b.circle
    end
  end

  # def new_render_engine(renderer_name, &method_proc)
  #   # puts "renderer_name : #{renderer_name}"
  #   Atome.define_method renderer_name do |params = nil, &user_proc|
  #     instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
  #   end
  # end

  # def run_optional_proc(proc_name, atome = self, params, &user_proc)
  #   option_found = Universe.get_optional_method(proc_name)
  #   # puts "=> #{Universe.optional_get_optional_method[:post_render_touch].class}"
  #   # optional_found = Universe.optional_get_optional_method[:post_render_touch]
  #   # atome.instance_exec( &optional_found) if optional_found.is_a?(Proc)
  #
  #   # if option_found
  #   #   alert option_found.class
  #   # end
  #   atome.instance_exec(params, user_proc, atome, &option_found) if option_found.is_a?(Proc)
  # end

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

    # we create a proc holder of any new particle if user pass a bloc
    store_code_bloc(element, &user_proc) if user_proc
    # Params is now an instance variable so it should be passed thru different methods
    instance_variable_set("@#{element}", params) if store
    # run_optional_proc("pre_render_#{element}", self, params, &user_proc)
    self.instance_exec(params, user_proc, self, &Atome.instance_variable_get("@pre_#{element}")) if Atome.instance_variable_get("@pre_#{element}").is_a?(Proc)
    render(element, params, &user_proc) if rendering
    self.instance_exec(params, user_proc, self, &Atome.instance_variable_get("@post_#{element}")) if Atome.instance_variable_get("@post_#{element}").is_a?(Proc)
    # run_optional_proc("post_render_#{element}", self, params, &user_proc)
    broadcasting(element)
    store_value(element) if store
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

