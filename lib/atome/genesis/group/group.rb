# frozen_string_literal: true


# we create dummy methods for pluralised atome
def group(params)
  grab(:view).group(params)
end

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
    # alert @atome
    @atome[:data].each do |atome_id_found|
      if !(particle == :type && params == :group || particle == :id) && !(particle == :renderers && params[0] == :group)
        atome_found = grab(atome_id_found)
        puts "clue here @group_initiated: [#{@group_initiated}] #{self.type},  #{particle} : #{params}"
        atome_found.send(particle, params, &bloc)

      end
      #
    end

    # alert  @atome[:data]
    #
    # @atome[:data]
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

  def group(params)
    essential_params = { type: :group, data: [], attach: [:view], width: 0, height: 0, top: 0, left:0 }
    data_found = if params.instance_of? Array
                   # the group renderers is found in : Genesis/group/group.rb
                   params
                 elsif params.instance_of? Hash
                   params[:data]
                 else
                   [params]
                 end
    grouped = shape(essential_params)
    grouped.data(data_found)
  end
end