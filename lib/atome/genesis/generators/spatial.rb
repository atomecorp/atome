# frozen_string_literal: true

new({ particle: :left, type: :integer })
new({ particle: :right, type: :integer })
new({ particle: :top, type: :integer })
new({ particle: :bottom, type: :integer })
new({ particle: :rotate, type: :integer })
new({ particle: :direction, type: :string })
new({ particle: :center, type: :string})
new({particle: :depth, type: :integer})
new({ particle: :position })
new({ particle: :organise })
new({ particle: :spacing })
new({ particle: :display }) do |params|
  unless params.instance_of? Hash
    params = { mode: params }
  end
  params
end
new({ particle: :layout }) do |params|

  mode_found = params.delete(:mode) || :list
  elements_style = params.delete(:element) || {}
  # now we get the list of the atome to layout
  atomes_to_organise = []
  if type == :group
    atomes_to_organise = collect
  end
  # if params[:listing] is specified group collection is override
  atomes_to_organise = params[:listing] if params[:listing]
  if mode_found == :default
    # the user want to revert the layout to the default
    atomes_to_organise.each do |atome_id_to_organise|
      atome_found = grab(atome_id_to_organise)
      # now restoring
      if atome_found.backup
        atome_found.backup.each do |particle, value|
          atome_found.send(:delete, particle)
          atome_found.send(particle, value)
        end
        atome_found.remove_layout
      end

    end
  else

    if params[:id]
      container_name = params[:id]
      container = grab(:view).box({ id: container_name })
      container_class = container_name
    else
      container = grab(:view).box
      id_found = container.id
      params[:id] = id_found
      container_class = id_found
    end
    container.remove({ category: :atome })
    container.category(:matrix)
    if mode_found == :list
      params[:organise] = '1fr'
    end
    params.each do |particle, value|
      container.send(particle, value)
    end
    # now we add user wanted particles
    atomes_to_organise.each do |atome_id_to_organise|
      atome_found = grab(atome_id_to_organise)
      # now restoring
      if atome_found.backup
        atome_found.backup.each do |particle, value|
          atome_found.send(:delete, particle)
          atome_found.send(particle, value)
        end
        # atome_found.remove_layout
      end
      # we remove previous display mode
      atome_found.remove_layout
      atome_found.display[:mode] = mode_found
      atome_found.display[:layout] = id_found
      atome_found.attach(container_class)
      atome_found.remove({ category: :atome })
      atome_found.category(container_class)
      # the hash below is used to restore element state

      # we only store the state if  atome_found.display[:default]== {} it means this is the original state
      elements_style.each do |particle, value|
        # we have to store all elements particle to restore it later
        atome_found.backup({}) unless atome_found.backup
        unless atome_found.backup[particle]
          particle_to_save = atome_found.send(particle) || 0
          atome_found.backup[particle] = particle_to_save
        end

        atome_found.send(particle, value)
      end
    end
  end
  params
end


