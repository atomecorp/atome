# frozen_string_literal: true

new({ particle: :attached })
new({ sanitizer: :attached }) do |params|
  params = [params] unless params.instance_of? Array
  params
end
new({ pre: :attached }) do |children_ids|
  children_ids.each do |child_id|
    child_id = child_id.value if child_id.instance_of? Atome
    child_found = grab(child_id)
    parents_found = @atome[:id]
    child_found.family(parents_found)
    child_found.atome[:attach] = [parents_found]
  end
end
new({ particle: :type })
new({ particle: :children })

new ({ sanitizer: :children }) do |params|
  # TODO factorise the line below and 'sanitized_params' for all particle type of Array
  params = [params] unless params.instance_of? Array
  sanitized_params = []
  params.each do |child_id|
    child_id = child_id.value if child_id.instance_of? Atome
    sanitized_params << child_id
    child_found = grab(child_id)
    parents_found = @atome[:id]
    # FIXME : parent child problem may be caused by the line below
    child_found.family(parents_found)
    child_found.atome[:parents] = [parents_found]
  end
  sanitized_params
end

new({ particle: :parents })
new({ sanitizer: :parents }) do |params|
  params = [params] unless params.instance_of? Array
  sanitized_params = []
  params.each do |parents_id|
    parents_id = parents_id.value if parents_id.instance_of? Atome
    sanitized_params << parents_id
    parents_found = grab(parents_id)
    family(parents_id)
    parents_found.atome[:children] << atome[:id]
  end
  sanitized_params
end

new({ particle: :family })
new({ particle: :link })
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
new({ particle: :attach })
new({ pre: :attach }) do |parents_ids|
  parents_ids.each do |parents_id|
    parents_id = parents_id.value if parents_id.instance_of? Atome
    parents_found = grab(parents_id)
    family(parents_id)
    parents_found.atome[:attached] = [] unless parents_found.atome[:attached]
    parents_found.atome[:attached] << atome[:id]
  end
end
new({ particle: :detached }) do |value|
  attached.value.delete(value)
end
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
