# frozen_string_literal: true

# TODO : remove monitoring
# TODO : remove child
# TODO : remove parents

# main entry here
class Atome
  # TODO : clean or delete @private_atome
  include Essentials

  private

  def initialize(atomes = {}, &atomes_proc)

    atomes.each_value do |elements|

      if Universe.atomes.key?(elements[:id])
        # alert "id : #{self.id}, element: #{elements[:id]}"
        # alert "id : #{elements[:id]}"
        puts "The id #{elements[:id]} is already taken, you must change it"
        # `throw new Error("this id is already exist, you must change it");`
      else
        # the instance variable below contain the id all any atomes that need to be informed when changes occurs
        @broadcast = {}
        # # now we store the proc in a an atome's property called :bloc
        elements[:code] = atomes_proc if atomes_proc

        @atome = elements
        # we initiate the rendering suing set_type method,
        # eg for for browser we will call :browser_type generate method in identity.rb file
        collapse
      end
    end
  end

  def new_particle(element, store, render, &method_proc)
    Atome.define_method element do |params = nil, &user_proc|
      if params || params == false
        # the line below execute the proc created when using the build_particle method
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        params = sanitize(element, params, &user_proc)
        create_particle(element, store, render)
        send("set_#{element}", params, &user_proc)
      elsif element == :batch # TODO : find a better solution than a condition if possible
        @atome[:batch]
      else

        @atome[element]
        # get_particle(element, &user_proc)
      end
    end
  end

  def additional_particle_methods(element, store, render, &method_proc)
    Atome.define_method "#{element}=" do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
      params = sanitize(element, params)
      particle_creation(element, params, store, render, &user_proc)
    end
  end

  def atome_parsing(element, params, &user_proc)
    params = sanitize(element, params)
    # current_atome = send(element)

    # The condition below check if we need to add or replace the newly created atome
    # if current_atome && !(@atome[:add] && @atome[:add][element])
    #   detached(current_atome)
    #   # @atome["#{element}s"] = []
    # end
    # TODO: replace with the line below but need extensive testing as it crash some demos ex: animation
    params = atome_common(element, params)
    run_optional_proc("pre_render_#{@atome[:type]}".to_sym, self, params, &user_proc)
    run_optional_proc("post_render_#{@atome[:type]}".to_sym, self, params, &user_proc)
    send("set_#{element}", params, &user_proc) # it call  Atome.define_method "set_#{element}" in  new_atome method
  end

  def atome_catcher(atome_catch)
    # if atome_catch.nil?
    #   alert "=======> #{self.id} is nil!!!"
    # end
    new_atome = Atome.new(container: { type: :element, data: atome_catch, renderers: [] })
    batch_found = new_atome.batch(atome_catch)
    batch_found.batch
    atome_catch
    # end
    # if atome_catch.instance_of?(Array)
    #   puts "case 1 : #{atome_catch}, #{atome_catch.class}"

    # else
    #   puts "case 2 : #{atome_catch}, #{atome_catch.class}"
    #   atome_catch
    # end

  end

  def new_atome(element, &method_proc)
    # the method define below is the slowest but params are analysed and sanitized
    Atome.define_method element do |params = nil, &user_proc|
      if params
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        atome_parsing(element, params, &user_proc)
      else
        # element_found = @atome["#{element}s"]
        # atome_catcher(element_found)
        # alert  element
        atome_catcher(@atome["#{element}s"])
      end

    end

    # the method define below is the fastest params are passed directly
    Atome.define_method "set_#{element}" do |params, &user_proc|
      # we add the newly created atome to the list of "child in it's category, eg if it's a shape we add the new atome
      # to the shape particles list : @atome[:shape] << params[:id]
      # puts "=> params : #{params}"
      new_atome = Atome.new({ element => params }, &user_proc)
      # Now we return the newly created atome instead of the current atome that is the parent cf: b=box; c=b.circle
      atome_catcher([new_atome.id])
      # new_atome
    end
    # the method below generate Atome method creation at Object level
    # create_method_at_object_level(element)
  end

  def new_render_engine(renderer_name, &method_proc)
    Atome.define_method renderer_name do |params = nil, &user_proc|
      instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
    end
  end

  def run_optional_proc(proc_name, atome = self, params, &user_proc)
    # params = instance_variable_get("@#{element}")
    option_found = Universe.get_optional_method(proc_name)

    # if option_found.is_a?(Proc)
    #   # alert  "#{proc_name} : #{params} "
    # else
    #   puts "proc_name : #{proc_name}, \noption_found : (#{option_found})"
    # end
    atome.instance_exec(params, user_proc, atome, &option_found) if option_found.is_a?(Proc)
  end

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

  def particle_creation(element, params, store, render, &user_proc)
    return false unless security_pass(element, params)

    # we create a proc holder of any new particle if user pass a bloc
    store_code_bloc(element, &user_proc) if user_proc
    # Params is now an instance variable so it should be passed thru different methods
    instance_variable_set("@#{element}", params) if store
    run_optional_proc("pre_render_#{element}", self, params, &user_proc)
    rendering(element, params, &user_proc) if render
    run_optional_proc("post_render_#{element}", self, params, &user_proc)
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
