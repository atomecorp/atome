# frozen_string_literal: true

new({ particle: :left, category: :spatial, type: :int })
new({ particle: :right, category: :spatial, type: :int })
new({ particle: :top, category: :spatial, type: :int })
new({ particle: :bottom, category: :spatial, type: :int })
new({ particle: :rotate, category: :spacial, type: :integer })
new({ particle: :direction, category: :spatial, type: :string })
new({ particle: :depth, category: :spatial, type: :integer })
new({ particle: :position, category: :spatial, type: :int })
new({ particle: :organise, category: :spatial, type: :string })
new({ particle: :spacing, category: :spatial, type: :string })
new({ particle: :display, category: :spatial, type: :boolean }) do |params|
  # params = { mode: params } unless params.instance_of? Hash
  params = case params
           when true
             :block
           when false
             :none
           else
             params

           end
  params = :none if params == false
  params
end
new({ particle: :layout, category: :spatial, type: :int }) do |params|
  mode_found = params.delete(:mode) || :list
  elements_style = params.delete(:element) || {}
  # now we get the list of the atome to layout
  atomes_to_organise = []
  atomes_to_organise = collect if type == :group
  # if params[:listing] is specified group collection is override
  atomes_to_organise = params[:listing] if params[:listing]
  if mode_found == :default
    # the user want to revert the layout to the default
    atomes_to_organise.each do |atome_id_to_organise|
      atome_found = grab(atome_id_to_organise)
      # now restoring
      next unless atome_found.backup

      atome_found.backup.each do |particle, value|
        atome_found.send(:delete, particle)
        atome_found.send(particle, value)
      end
      atome_found.remove_layout
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
    params[:organise] = '1fr' if mode_found == :list
    params.each do |particle, value|
      container.send(particle, value)
    end
    # now we add user wanted particles
    atomes_to_organise.each do |atome_id_to_organise|
      atome_found = grab(atome_id_to_organise)
      # now restoring
      # atome_found.remove_layout
      atome_found.backup&.each do |particle, value|
        atome_found.send(:delete, particle)
        atome_found.send(particle, value)
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
new({ particle: :center, category: :spatial, type: :hash }) do |params|
  params = { x: 0, y: 0, dynamic: true } if params == true
  params
end
new ({ particle: :increment, category: :spatial, type: :hash }) do |params|
  params.each do |particle, value|
    prev_value = send(particle)
    send(particle, value + prev_value)
  end
end

new({particle: :longitude}) do |params, _user_proc|
  render(:map, {longitude: params })
  params
end

new({particle: :latitude}) do |params, _user_proc|
  render(:map, {latitude: params })
  params
end

new({particle: :location}) do |params, _user_proc|
  render(:map, params)
  params
end

new({particle: :zoom, specific: :map}) do |params, _user_proc|
  render(:map_zoom, params)
  params
end