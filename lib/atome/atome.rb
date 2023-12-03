# frozen_string_literal: true

# main Atome entry here
class Atome
  include Essentials

  def initialize(new_atome = {}, &atomes_proc)
    # the keys :renderers, :type and :id should be placed in the first position in the hash
    #@broadcast = {}
    @history = {}
    @callback = {}
    @tag = {}
    @selected = false
    @unit = {}
    @collect = {}
    @id = new_atome[:id] || identity_generator(:element)
    @type = new_atome[:type] || :element
    @attached = []
    @category = []
    # @copy = []
    @html = HTML.new(@id, self)
    @headless = Headless.new(@id, self)
    # now we store the proc in a an atome's property called :bloc
    new_atome[:code] = atomes_proc if atomes_proc
    # we reorder the hash
    ordered_keys = %i[renderers id type]
    ordered_part = ordered_keys.map { |k| [k, new_atome[k]] }.to_h
    other_part = new_atome.reject { |k, _| ordered_keys.include?(k) }
    # merge the parts  to obtain an re-ordered hash
    reordered_atome = ordered_part.merge(other_part)

    # FIXME : try to remove the condition below (it crash in the method :  def generator ... in genesis.rb)
    collapse(reordered_atome)
  end

  def particle_creation(element, params, store, rendering, &user_proc)

    # @store_allow = false
    params = particle_main(element, params, &user_proc)
    # Params is now an instance variable so it should be passed thru different methods
    instance_variable_set("@#{element}", params) if store
    # pre rendering processor
    params = particle_pre(element, params, &user_proc)
    # we create a proc holder of any new particle if user pass a bloc
    particle_callback(element)
    store_proc(element, params, &user_proc) if user_proc
    render(element, params, &user_proc) if rendering
    # broadcasting(element)
    # post rendering processor
    params = particle_post(element, params, &user_proc)
    instance_variable_set("@#{element}", params) if store
    # post storage processor
    particle_after(element, params, &user_proc)

    # self
  end

  def inspect
    filtered_vars = instance_variables.reject { |var| var == :@html_object || var == :@history }
    content = filtered_vars.map do |var|
      "#{var}=#{instance_variable_get(var).inspect}"
    end.join(", ")

    "#<#{self.class}: #{content}>"
  end
end
