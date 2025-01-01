# # frozen_string_literal: true

class Atome
  class << self
    def monitoring(atomes_to_monitor, particles_to_monitor, &bloc)
      atomes_to_monitor.each do |atome_to_monitor|
        particles_to_monitor.each do |monitored_particle|
          # storing original method
          original_method = atome_to_monitor.method(monitored_particle)
          # redefine the method
          atome_to_monitor.define_singleton_method(monitored_particle) do |*args, &proc|
            # monitoring bloc before calling original method
            value_before = atome_to_monitor.instance_variable_get("@#{monitored_particle}")
            if args.empty?
              # args = nil
            else
              if monitored_particle == :touch
                # instance_variable_set("@#{monitored_particle}", { tap: args[0] })
                # instance_variable_set("@#{monitored_particle}_code", { touch: proc })
                # args = { tap: args[0] }
              elsif monitored_particle == :apply
                # alert monitored_particle

              else
                instance_variable_set("@#{monitored_particle}", args[0])
                args = args[0]
              end

            end

            if value_before != args # we check if the value ahs changed prior bloc call
              instance_exec({ original: value_before, altered: args, particle: monitored_particle }, &bloc) if bloc.is_a?(Proc)
              original_method.call(*args)
            end

          end
        end
      end
    end
  end
end

c = circle({ id: :the_circle, left: 12, top: 0, color: :orange, drag: { move: true, inertia: true, lock: :start } })
b = box({ top: 123, drag: true })

# #######################
atomes_monitored = [b]
# particles_monitored=[:left, :width, :touch, :apply]
particles_monitored = [:left, :touch, :apply]
Atome.monitoring(atomes_monitored, particles_monitored) do |monitor_infos|
  puts monitor_infos
  # atomes_monitored.each do |atome_to_update|
  #   puts "updating : #{atome_to_update.instance_variable_get('@left')}"
  #   # puts "updating : #{atome_to_update.left}"
  #   # we exclude the current  changing atome to avoid infinite loop
  #   # unless atome_to_update == self || (monitor_infos[:original] == monitor_infos[:altered]) || !monitor_infos[:altered]
  #   #   atome_to_update.send(monitor_infos[:particle], monitor_infos[:altered])
  #   # end
  # end
end

# verif
b.resize(true) do

end
c.resize(true) do
end

b.touch(true) do
  puts :touched!
end
c.touch(:down) do
  puts :touchy
end
color({ blue: 1, id: :big_col })
wait 2 do
  b.apply(:big_col)
end