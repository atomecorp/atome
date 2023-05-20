# frozen_string_literal: true

new({ particle: :attach })
new({ sanitizer: :attach }) do |parents_ids|
  puts "=> attach it! : #{parents_ids} <="

  parents_ids = parents_ids if parents_ids.instance_of? Atome
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  parents_ids.each do |parents_id|
    parents_id = parents_id if parents_id.instance_of? Atome
    parents_found = grab(parents_id)
    # TODO : factorise the code below
    current_type = atome[:type]
    parents_found.atome[current_type] = [] unless parents_found.atome[current_type]

    # the condition below is needed when user passed a hash instead of the id of the child cf :
    parent_type_container = if parents_found.atome[current_type].instance_of? Array
                              parents_found.atome[current_type]
                            else
                              [parents_found.atome[current_type][:id]]
                            end
    # here we add the child into it's parents type container
    parent_type_container << atome[:id]
    # TODO : factorise the code above
    parents_found.atome[:attached] = [] unless parents_found.atome[:attached]
    parents_found.atome[:attached] << atome[:id]
  end
  parents_ids
end

new({ particle: :attached })
new({ sanitizer: :attached }) do |children_ids|
  puts "=> attached now! : #{children_ids}<="
  children_ids = children_ids if children_ids.instance_of? Atome
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  children_ids.each do |child_id|
    child_id = child_id if child_id.instance_of? Atome
    child_found = grab(child_id)
    parents_found = @atome[:id]
    # TODO : factorise the code below
    child_found_type = child_found.type
    @atome[child_found_type] = [] unless @atome[child_found_type]

    # the condition below is needed when user passed a hash instead of the id of the child cf :
    # circle(color: {red: 0, green: 1}) instead of color({id: :the_col}); circle(color: [:the_col])
    child_type_container = if @atome[child_found_type].instance_of? Array
                             @atome[child_found_type]
                           else
                             [@atome[child_found_type][:id]]
                           end
    child_type_container << child_id
    # TODO : factorise the code above
    child_found.atome[:attach] = [parents_found]
  end
end

new({ particle: :detached, store: false })

new({ sanitizer: :detached }) do |values|
  if values.instance_of? Array
    values.each do |value|
      detach_atome(value)
    end
  else
    detach_atome(values)
    # we sanitize the values so it always return an array to the renderer
    values = [values]
  end
  values
end

new({ particle: :type })
new({ particle: :id })
new({ sanitizer: :id }) do |params|
  if @atome[:id] != params
    Universe.update_atome_id(params, self, @atome[:id])
  else
    Universe.add_to_atomes(params, self)
  end
  params
end
new({ particle: :name })
new({ particle: :active })

new({ particle: :intricate, type: :array })
new({ particle: :clones }) do |clones_found|
  clones_found.each_with_index do |clone_found, index|
    particles_intricated = clone_found[:intricate] ||= []
    clone_id = "#{particles[:id]}_clone_#{index}"
    original_id = atome[:id]
    clone_found[:id] = clone_id
    clone_found = particles.merge(clone_found)
    cloned_atome = Atome.new({ clone: clone_found })
    cloned_atome.monitor({ atomes: [original_id], particles: particles_intricated }) do |_atome, particle, value|
      cloned_atome.send(particle, value)
    end
  end
end
