# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:type)
generator.build_particle(:parents)
generator.build_particle(:children)
generator.build_particle(:id)

generator.build_option(:pre_save_parents) do |parents_id_found|
  parents_id_found.each do |parents_id|
    parents_found = grab(parents_id)
    parents_found.children << id if parents_found
  end
end
