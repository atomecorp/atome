# frozen_string_literal: true

# main Atome entry here
# used as a callback when the atome is ready
Atome.instance_variable_set('@initialized',{})
class Atome
  include Essentials

  def aid(_v = nil)
    @aid
  end

  def initialize(new_atome = {}, &atomes_proc)
    # TODO: atome format should always be as followed : {value: 0.44, unit: :px, opt1: 554}
    # when using optimised version of atome you must type eg : a.set({left: {value: 33, unit: '%', reference: :center}})
    # if  Universe.atomes[new_atome[:id]]
    #   # puts "------ 2 #{new_atome[:id]} => #{Universe.atomes[new_atome[:id]]}"
    #   # puts 'atome_id already exist'
    #   # old_atome= grab(new_atome[:id])
    #   # new_atome.each do |element, value|
    #   #   old_atome.send(element, value)
    #   # end
    #   # return false
    #    grab(new_atome[:id])
    # else
    # the keys :renderers, :type and :id should be placed in the first position in the hash
    @history = {}
    # @language = :english
    # @callback = {}
    @tag = {}
    @selected = false
    #@metrics = {}
    @unit = {}
    @apply = []
    @collect = {}
    @int8 = {}
    @css = {}
    @aid = identity_generator
    Universe.add_to_atomes(@aid, self)
    @id = new_atome[:id] || @aid
    Universe.id_to_aid(@id, @aid)
    @type = new_atome[:type] || :element
    @attached = []
    @affect = []
    @category = []
    # @display = { mode: :default }
    # @backup={} # mainly used to restore particle when using grid /table /list display mode
    @html = HTML.new(@id, self)
    @headless = Headless.new(@id, self)
    @initialized={}

    # now we store the proc in a an atome's property called :bloc
    new_atome[:code] = atomes_proc if atomes_proc
    # we reorder the hash
    reordered_atome = reorder_particles(new_atome)
    # FIXME : try to remove the condition below (it crash in the method :  def generator ... in genesis.rb)
    collapse(reordered_atome)
    # end
    # puts "@initialized : #{Atome.instance_variable_get('@initialized')}"
    # puts "****> #{Atome.instance_variable_get('@initialized')}"

    # if Atome.instance_variable_get('@initialized')
    # puts  "-----> #{Atome.instance_variable_get('@initialized')}"
    #   Atome.instance_variable_get('@initialized').each do |p_found, bloc|
    #     # puts "==> #{p_found}"
    #     # instance_exec.call
    #     # instance_exec(p_found, &bloc) if bloc.is_a?(Proc)
    #   end
    # end


  end

  def js
    html.object
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
    # after storage processor
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


