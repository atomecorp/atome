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
