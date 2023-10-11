# frozen_string_literal: true


new({ particle: :real })
new({ particle: :type })
new({ particle: :id })
new({ sanitizer: :id }) do |params|
  # first we sanitize the the id below
  params = params.to_sym
  if @atome[:id].to_sym != params
    Universe.update_atome_id(params, self, @atome[:id])
  else
    Universe.add_to_atomes(params, self)
  end
  params
end
new({ particle: :name })
new({ particle: :active })
new({ particle: :entangled, type: :array })
new({ particle: :clones }) do |clones_found|
  clones_found.each_with_index do |clone_found, index|
    particles_entangled = clone_found[:entangled] ||= []
    clone_id = "#{particles[:id]}_clone_#{index}"
    original_id = atome[:id]
    clone_found[:id] = clone_id
    clone_found = particles.merge(clone_found)
    cloned_atome = Atome.new(clone_found)
    cloned_atome.monitor({ atomes: [original_id], particles: particles_entangled }) do |_atome, particle, value|
      cloned_atome.send(particle, value)
    end
  end
end
new({ particle: :markup })
