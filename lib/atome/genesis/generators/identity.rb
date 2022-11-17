# frozen_string_literal: true

generator = Genesis.generator

generator.build_particle(:type)
generator.build_particle(:parent)
generator.build_particle(:children)
generator.build_particle(:id)

generator.build_optional_methods(:pre_save_parent) do |parents_id_found|
  parents_id_found.each do |parent_id_found|
    parent_found = grab(parent_id_found)
    parent_found.children << id if parent_found
  end
end
