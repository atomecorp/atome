# frozen_string_literal: true

# class Atome
#
#   # here we create the group renderers
#   particle_list_found = Universe.particle_list.keys
#   # atome_list_found = Universe.atome_list
#   # full_list = particle_list_found.concat(atome_list_found)
#
#   def each(_params, &proc)
#     data.each do |atome_id_found|
#       atome_found=grab(atome_id_found)
#       atome.instance_exec(atome_found, &proc) if proc.is_a?(Proc)
#     end
#
#   end
#
#
#   particle_list_found.each do |the_particle|
#     define_method("group_#{the_particle}") do |params, &bloc|
#       if !(the_particle == :type && params == :group || the_particle == :id) && !(the_particle == :attach && params[0] == :nil) && !(the_particle == :renderers && params[0] == :group)
#         data.each do |atome_found|
#           grab(atome_found).send(the_particle, params, &bloc)
#         end
#       end
#     end
#   end
# end

# we create dummy methods for pluralised atome

Universe.atome_list.each do |atome_name|
  pluralised_atome_name = "#{atome_name}s"
  Atome.define_method pluralised_atome_name do |params = nil, &method_proc|
    instance_exec(params, &method_proc) if method_proc.is_a?(Proc)
    @atome[pluralised_atome_name] = params
  end
end

class Atome


  def group_particle_analysis(particle, params, &bloc)
    # if params
      @atome[:data].each do |atome_id_found|
        if !(particle == :type && params == :group || particle == :id) && !(particle == :attach && params[0] == :nil) && !(particle == :renderers && params[0] == :group)
          atome_found = grab(atome_id_found)
          atome_found.send(particle, params, &bloc)
        end
      end
    # alert  @atome[:data]
    #
    @atome[:data]
    # else
    #   alert "zebulon"
    #   end
    #   grab(:b3).atome[:data]=[:b1]
    #   grab(:b3)
    #   end
      # group(@atome[:data])[:data]
    # alert self

      # alert self.id
      # @atome[:id]
      # grab(@atome[:id])
    # else
    #   if group(@atome[:data])[:data]
    #     "group(@atome[:data])"
    #   else
    #     "self"
    #   end
    #
    # #   # [:b1]
    # #   # alert @atome[:id]
    # #   # grab(@atome[:id])
    # #   # group(@atome[particle])
    # end

    # instance_exec(params,  &bloc) if bloc.is_a?(Proc)
    # params = sanitize(particle, params, &bloc)
    # create_particle(particle, store, render)

  end

  def group_atome_analysis(parents_found)
    parents_found.data.each_with_index do |atome_id_found, index|
      # we increment atome id to create a new a atome for each element of the group
      atome[:id] = "#{atome[:id]}_#{index}" if index > 0
      # remove the group from the attach
      atome[:attach].delete(parents_found.atome[:id])
      # we attach the the atome
      atome[:attach] << atome_id_found
      # puts "grab(#{atome_id_found}).send(#{type}, #{atome})"
      grab(atome_id_found).send(type, atome)
    end
  end
end