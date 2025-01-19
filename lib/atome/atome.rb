# frozen_string_literal: true

# main Atome entry here
# used as a callback when the atome is ready
# Atome.instance_variable_set('@initialized',{})
class Atome
  include Essentials
  # controller_proc is used to stack multiple procs from native controller
  attr_accessor :controller_proc#, :view_logs

  def aid(_v = nil)
    @aid
  end

  # dummy method to catch a method get all instance variable and try to call a method but initialized is only an
  # instance variable not a method
  # FIXME : replace all

  def initialize(new_atome = {}, &atomes_proc)
    # TODO: atome format should always be as followed : {value: 0.44, unit: :px, opt1: 554}
    # the keys :renderers, :type and :id should be placed in the first position in the hash
    @history = {}
    @tag = {}
    @tick = {}
    @storage = {}
    @behavior = {}
    @selected = false
    @unit = {}
    @apply = []
    @collect = {}
    @int8 = {}
    # @language = :english
    @css = {}
    @code = {}
    @aid = new_atome[:aid] || identity_generator
    @controller_proc = []
    @id = new_atome[:id] || @aid
    Universe.atomes.each_value do |atome_f|
      # we affect the already existing atome to target
      next unless atome_f.id == @id

      new_atome[:affect].each do |affected|
        grab(affected).apply(@id)
      end if new_atome[:affect]
      return false
    end
    Universe.add_to_atomes(@aid, self)
    Universe.id_to_aid(@id, @aid)
    @type = new_atome[:type] || :element
    @fasten = []
    @affect = []
    @category = []
    @html = HTML.new(@id, self)
    @headless = Headless.new(@id, self)
    @initialized = {}
    @creator = Universe.current_user
    # now we store the proc in a an atome's property called :bloc
    new_atome[:code] = atomes_proc if atomes_proc
    # we reorder the hash
    reordered_atome = reorder_particles(new_atome)
    # FIXME : try to remove the condition below (it crash in the method :  def generator ... in genesis.rb)
    collapse(reordered_atome)
  end

  def js
    html.object
  end

  def particle_creation(element, params, store, rendering, &user_proc)

    params = particle_main(element, params, &user_proc)
    # Params is now an instance variable so it should be passed thru different methods
    instance_variable_set("@#{element}", params) if store
    # pre rendering processor
    params = particle_pre(element, params, &user_proc)
    # we create a proc holder of any new particle if user pass a bloc
    particle_callback(element)
    store_proc(element, params, &user_proc) if user_proc
    render(element, params, &user_proc) if rendering
    # post rendering processor
    params = particle_post(element, params, &user_proc)
    instance_variable_set("@#{element}", params) if store
    Universe.historicize(@aid, :write, element, params)
    particle_after(element, params, &user_proc)
  end

  def inspect
    filtered_vars = instance_variables.reject { |var| var == :@html_object || var == :@history }
    content = filtered_vars.map do |var|
      "#{var}=#{instance_variable_get(var).inspect}"
    end.join(", ")

    "#<#{self.class}: #{content}>"
  end
end
