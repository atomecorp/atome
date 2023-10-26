# frozen_string_literal: true

#  callbacks methods here
# class Atome
# private
#
# attr_accessor :drag_start_proc, :drag_move_proc, :drag_end_proc,
#               :drop_action_proc,:over_action_proc,
#               :play_start_proc, :play_active_proc, :play_end_proc,
#               :animation_start_proc, :animation_active_proc, :animation_stop_proc
#
# public
#
# def schedule_callback(proc)
#   instance_exec(&proc) if proc.is_a?(Proc)
# end
#
# def read_callback(file, proc)
#   file_content=file.split('</head><body>')[1].split('</body></html>')[0]
#   # FIXME : found why '> is converted to &gt;'
#   file_content=file_content.gsub("&gt;", ">")
#   instance_exec(file_content, &proc) if proc.is_a?(Proc)
# end
#


#
# def leave_action_callback(data_found)
#   proc = @leave_action_proc
#   instance_exec( data_found,&proc) if proc.is_a?(Proc)
# end
#
# # sort callbacks
# def sort_callback(atome)
#   sort_proc = @sort_proc
#   instance_exec(atome, &sort_proc) if sort_proc.is_a?(Proc)
# end
#
# # animation
# # def browser_animate_callback(particle_found, value, animation_hash, original_particle, animation_atome)
# #   anim_proc = animation_hash[:code]
# #   #  we exec the callback bloc from :animate
# #   instance_exec({ original_particle => value }, &anim_proc) if anim_proc.is_a?(Proc)
# #   # we exec the callback bloc from :play
# #   play_proc = animation_atome.play_active_proc
# #   instance_exec({ @!atome[particle_found] => value }, &play_proc) if play_proc.is_a?(Proc)
# #   # we animate:
# #   browser_object.style[particle_found] = value if browser_object
# #   # we update the atome property
# #   @!atome[original_particle] = value
# # end
#
# def play_start_callback(_particle_found, _start_value, animation_hash, original_particle, atome_found)
#   value = animation_hash[:begin][original_particle]
#   value = atome_found.atome[original_particle] if value == :self
#   start_proc = @animation_start_proc
  #   @!atome[original_particle] = value
#   instance_exec({ original_particle => value }, &start_proc) if start_proc.is_a?(Proc)
  # end
#
# def play_stop_callback(_particle_found, _end_value, animation_hash, original_particle, _atome_found)
#   value = animation_hash[:end][original_particle]
#   end_proc = @animation_stop_proc
#   @!atome[original_particle] = value
#   instance_exec({ original_particle => value }, &end_proc) if end_proc.is_a?(Proc)
# end
# end
