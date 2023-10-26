# frozen_string_literal: true

# main entry here
class Atome
  # class << self
  #   attr_accessor :atomes
  #   def atomes(id, artome)
  #     @!atomes[id]=atome
  #   end
  #
  #   def atomes(id, artome)
  #     @!atomes[id]=atome
  #   end
  # end
  # TODO : clean or delete @private_atome
  include Essentials

  # private
  # attr_reader :atome #, :structure # , :at_time

  def initialize(new_atome = nil, &atomes_proc)
    # alert "new_atome : #{new_atome}"
    # the keys :renderers, :type and :id should be placed in the first position in the hash
    @broadcast = {}
    @history = {}
    @security = {}
    @callback = {}
    @unit = {}
    @id=new_atome[:id]
    @type=new_atome[:type]
    # now we store the proc in a an atome's property called :bloc
    new_atome[:code] = atomes_proc if atomes_proc
    # @atome = new_atome
    # we reorder the hash
    # # #########
    # # hash = {:renderers => [], :id => :eDen, :type => :element, :tag => {:system=>true}, :attach => [], :attached => []}
    # ordered_keys = [:id, :type, :renderers]
    # ordered_part = ordered_keys.map { |k| [k, new_atome[k]] }.to_h
    # other_part = new_atome.reject { |k, _| ordered_keys.include?(k) }
    # # Fusionner les deux parties pour obtenir le hash réorganisé
    # reordered_atome = ordered_part.merge(other_part)
    # # #########

    # @!atome[:forbidden]='you are not allow to read protected particle'
    # we initiate the rendering using set_type method,
    # eg : for for browser we will call :browser_type generate method in identity.rb file
    # FIXME : try to remove the condition below (it crash in the method :  def generator ... in genesis.rb)
    collapse(new_atome) if new_atome


  end

  def store_value(element, params)
    instance_variable_set("@#{element}", params)
    # params = instance_variable_get("@#{element}")
    # puts "add the line below to make it work"
    # @atome[element] = params

  end

  # public

  # the line below is used for ephemera atomes
  # attr_accessor :property, :value, :real_atome, :user_proc

  # not sure the method below is still used
  # def set(value)
  #   @real_atome[@property] = value
  # end

  def particle_creation(element, params, store, rendering, &user_proc)
    @store_allow = false
    # Params is now an instance variable so it should be passed thru different methods
    instance_variable_set("@#{element}", params) if store
    if Atome.instance_variable_get("@pre_#{element}").is_a?(Proc) # post is before rendering and broadcasting
      instance_exec(params, user_proc, self, &Atome.instance_variable_get("@pre_#{element}"))
    end
    # we create a proc holder of any new particle if user pass a bloc
    particle_callback(element)
    store_proc(element, params, &user_proc) if user_proc
    render(element, params, &user_proc) if rendering
    broadcasting(element)
    if Atome.instance_variable_get("@post_#{element}").is_a?(Proc) # post is after rendering and broadcasting
      instance_exec(params, user_proc, self, &Atome.instance_variable_get("@post_#{element}"))
    end
    store_value(element, params) if store
    @store_allow = true
    if Atome.instance_variable_get("@after_#{element}").is_a?(Proc) # after is post saving
      instance_exec(params, user_proc, self, &Atome.instance_variable_get("@after_#{element}"))
    end
    self
  end
  # def renderers(p)
  #   @renderers=p
  # end
  #
  # def id(p)
  #   @id=p
  # end
  # def type(p)
  #   @type=p
  # end

  # def get(element)
  #   @!atome[element]
  # end

  # Universe.connected
  def inspect
    filtered_vars = instance_variables.reject { |var| var == :@html_object ||var == :@history  }
    content = filtered_vars.map do |var|
      "#{var}=#{instance_variable_get(var).inspect}"
    end.join(", ")

    "#<#{self.class}: #{content}>"
  end
end
