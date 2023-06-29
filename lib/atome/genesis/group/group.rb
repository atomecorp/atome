# frozen_string_literal: true

class Atome

  # here we create the group renderers
  particle_list_found = Universe.particle_list.keys
  # atome_list_found = Universe.atome_list
  # full_list = particle_list_found.concat(atome_list_found)

  def each(_params, &proc)
    data.each do |atome_id_found|
      atome_found=grab(atome_id_found)
      atome.instance_exec(atome_found, &proc) if proc.is_a?(Proc)
    end

  end


  particle_list_found.each do |the_particle|
    define_method("group_#{the_particle}") do |params, &bloc|
      if !(the_particle == :type && params == :group || the_particle == :id) && !(the_particle == :attach && params[0] == :nil) && !(the_particle == :renderers && params[0] == :group)
        data.each do |atome_found|
          grab(atome_found).send(the_particle, params, &bloc)
        end
      end
    end
  end
end