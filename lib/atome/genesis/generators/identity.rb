# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:type)
generator.build_particle(:parents)
generator.build_particle(:children)
generator.build_option(:pre_render_parents) do |parents_ids|
  parents_ids.each do |parents_id|
    parents_id = parents_id.value if parents_id.instance_of? Atome
    parents_found = grab(parents_id)
    family(parents_id)
    parents_found.atome[:children] << atome[:id]
  end
end

generator.build_option(:pre_render_children) do |children_ids|
  children_ids.each do |child_id|
    child_id = child_id.value if child_id.instance_of? Atome
    child_found = grab(child_id)
    parents_found = @atome[:id]
    # FIXME : broadcast may malfunction because of the commented line below,
    # FIXME suite : if uncomment object hierreachy is broken (cf Vie Project)
    # child_found.family(parents_found)
    child_found.atome[:parents] = [parents_found]
  end
end

generator.build_particle(:family, { render: true, store: false })

generator.build_particle(:link) do |child_id|
  child_found = grab(child_id)
  child_found.atome[:parents] << @atome[:id]
  child_found.refresh
end

generator.build_particle(:id)
generator.build_sanitizer(:id) do |params|
  if @atome[:id] != params
    Universe.update_atome_id(params, self, @atome[:id])
  else
    Universe.add_to_atomes(params, self)
  end
  params
end

generator.build_particle(:name)

generator.build_particle(:active)

generator.build_particle(:attach)
generator.build_particle(:attached)
generator.build_sanitizer(:attached) do |params|
  unless params.instance_of? Array
    params = [params]
  end
  params
end
generator.build_particle(:detached) do |attach_to_remove|
  attached.value.delete(attach_to_remove)
end

generator.build_option(:pre_render_attach) do |parents_ids|
  parents_ids.each do |parents_id|
    parents_id = parents_id.value if parents_id.instance_of? Atome
    parents_found = grab(parents_id)
    family(parents_id)
    parents_found.atome[:attached] = [] unless parents_found.atome[:attached]
    parents_found.atome[:attached] << atome[:id]
  end
end

generator.build_option(:pre_render_attached) do |children_ids|
  children_ids.each do |child_id|
    child_id = child_id.value if child_id.instance_of? Atome
    child_found = grab(child_id)
    parents_found = @atome[:id]
    child_found.family(parents_found)
    # parents_found.atome[:attach] = [] unless parents_found.atome[:attach]
    child_found.atome[:attach] = [parents_found]
  end
end

generator.build_particle(:intricate, { type: :array })

generator.build_particle(:clones) do |clones_found|
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
