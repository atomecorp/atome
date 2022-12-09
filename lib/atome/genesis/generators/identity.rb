# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:type)
generator.build_particle(:parents)
generator.build_particle(:children)
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
generator.build_option(:pre_render_parents) do |parents_id_found|
  parents_id_found.each do |parents_id|
    parents_found = grab(parents_id)
    parents_found.children << id if parents_found
  end
end
generator.build_particle(:name)

generator.build_particle(:active)

generator.build_particle(:attach) do |parents|
  parents.each do |parent|
    grab(parent).atome[:attached] = [atome[:id]]
  end
end

generator.build_particle(:attached) do |targets|
  targets.each do |target|
    grab(target).attach([atome[:id]])
  end
end

generator.build_particle(:clones) do |clones_found|
  clones_found.each_with_index  do |clone_found, index|
    clone_id="#{particles[:id]}_clone_#{index}"
    original_id=atome[:id]
    clone_found[:id] = clone_id
    clone_found = particles.merge(clone_found)
    cloned_atome=Atome.new({ shape: clone_found })
    cloned_atome.monitor({ atomes: [original_id], particles: [:width, :attached,:height ]}) do |_atome, particle, value|
      cloned_atome.send(particle,value)
    end
  end
end
