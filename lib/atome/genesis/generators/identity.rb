# frozen_string_literal: true

new({ particle: :real })
new({ particle: :type })
new({ particle: :id })
new({ sanitizer: :id }) do |params|
  # first we sanitize the the id below
  params = params.to_sym
  if @id.to_sym != params
    Universe.update_atome_id(params, self, @id)
  else
    Universe.add_to_atomes(params, self)
  end
  params
end
new({ particle: :name })
new({ particle: :active })
# new({ particle: :entangled, type: :array })
# new({ particle: :clones }) do |clones_found|
#   clones_found.each_with_index do |clone_found, index|
#     particles_entangled = clone_found[:entangled] ||= []
#     clone_id = "#{particles[:id]}_clone_#{index}"
#     original_id = atome[:id]
#     clone_found[:id] = clone_id
#     clone_found = particles.merge(clone_found)
#     clone_found.delete(:html_object)
#     cloned_atome = Atome.new(clone_found)
#     monitor({ atomes: [original_id], particles: particles_entangled }) do |_atome, particle, value|
#       cloned_atome.send(particle, value)
#     end
#   end
# end
new({ particle: :markup })
new({particle: :bundle})
new({ particle: :data })

new({particle: :category, store: false}) do |category_names|
  category_names=[category_names] unless category_names.instance_of? Array
  category_names.each do |category_name| 
    @category << category_name
  end
end
# The selection particle is used by current user to store selected atomes
new(particle: :selection)
