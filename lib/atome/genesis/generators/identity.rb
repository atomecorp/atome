# frozen_string_literal: true

def attachment_common(children_ids, parents_ids, &user_proc)
  # FIXME : it seems we sometime iterate when for nothing
  parents_ids.each do |parent_id|
    # FIXME : find a more optimised way to prevent atome to attach to itself
    parent_found = grab(parent_id)
    parent_found.atome[:attached].concat(children_ids).uniq!
    children_ids.each do |child_id|
      child_found = grab(child_id)
      child_found.render(:attach, parent_id, &user_proc) if child_found
    end
  end
end

new({ particle: :attach, render: false }) do |parents_ids, &user_proc|
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  children_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)
  parents_ids
end

new({ particle: :apply, render: false }) do |parents_ids, &user_proc|
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  children_ids = [id]
  parents_ids.each do |parent_id|
    parent_found = grab(parent_id)
    children_ids.each do |child_id|
      child_found = grab(child_id)
      child_found.render(:apply, parent_found, &user_proc) if child_found
    end
  end
  parents_ids
end

new({ particle: :affect, render: false }) do |children_ids, &user_proc|
  children_ids.each do |child_id|
    child_found = grab(child_id)
    child_found.render(:apply, self, &user_proc) if child_found
  end
  children_ids
end

new({ particle: :attached, render: false }) do |children_ids, &user_proc|
  # fastened
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)
  children_ids
end
new({ particle: :detached, store: false }) # unfastened
new({ sanitizer: :detached }) do |values| # unfastened
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

new({ particle: :real })
new({ particle: :type })

new({ particle: :id })
new({ sanitizer: :id }) do |params|
  # first we sanitize the the id below
  params=params.to_sym
  if @atome[:id].to_sym != params
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

new({ particle: :markup })