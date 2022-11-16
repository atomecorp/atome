# # frozen_string_literal: true
#
# require './new_renderer'
# require './to_meta'
#
# # main entry here
# class Atome
#   private
#
#   attr_reader :private_atome
#
#   public
#
#   def initialize(atomes = {}, &atome_bloc)
#     atomes.each_value do |atome|
#       atome[:bloc] = atome_bloc if atome_bloc
#       @private_atome = atome
#     end
#   end
#
#   def getter(particle)
#     @private_atome[particle]
#   end
#
#   def atome(atome_to_create)
#     Atome.new(atome_to_create)
#   end
#
#   def atome_setter(particle, value)
#     @private_atome[particle] = value
#   end
#
#   def particle_setter(particle, value)
#     @private_atome[particle] = value
#   end
#
#   def inject_particle(particles)
#     # this method is used if user wants to set multiple particle at once
#     particles.each do |particle, value|
#       particle_setter(particle, value)
#     end
#   end
#
#   def check_validity(_particle, _value) end
#
#   def security_layer(particles)
#     particles.each do |particle, value|
#       check_validity(particle, value)
#     end
#     particles
#   end
#
#   def collapse
#     atome = exec_optional_proc(:pre_save, @private_atome)
#     atome = security_layer(atome)
#     @atome = atome
#     @atome = exec_optional_proc(:post_save, @private_atome)
#     rendering(:atome, @atome)
#     exec_optional_proc(:post_render, @private_atome)
#   end
#
#   def collapse_particle(particle)
#     value = @private_atome[particle]
#     atome = security_layer(particle => value)
#     rendering(:particle, atome)
#   end
#
#   def sanitize_particles(particles, &atome_bloc)
#     particles[:bloc] = atome_bloc
#     # add_elemental particles too
#     particles
#   end
#
#   def exec_optional_proc(_proc_to_exec, particle)
#     particle
#   end
#
#   def to_s
#     @atome.to_s
#   end
#
#   def value
#     @private_atome.values[0]
#   end
#
#   def bloc(value = nil)
#     if value
#       particle_setter(:bloc, { value: value })
#       collapse
#     else
#       value = getter(:bloc)
#       particle = exec_optional_proc(:pre_get, { bloc: value })
#       new_atome = atome({ atome: particle })
#       new_atome.collapse
#       new_atome
#     end
#   end
#
#   def id
#     getter(:id)
#   end
# end
