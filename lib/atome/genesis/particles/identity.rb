# frozen_string_literal: true

new({ particle: :real, category: :identity, type: :string })
new({ particle: :type, category: :identity, type: :string })
new({ particle: :id, category: :identity, type: :string })
new({ sanitizer: :id }) do |params|
  # first we sanitize the the id below

  params = params.to_sym
  # we check id is already assign
  # the condition below is to prevent the creation of multiple unwanted colors with same property and no ID specified
  #   if @id.to_sym != params
  #     Universe.update_atome_id(params, self, @id)
  #   else
  #     Universe.add_to_atomes(params, self)
  #   end


  # Universe.atomes.each do |_aid,atome_f|
  #
  #   if atome_f.id == params
  #     puts  "===> no for #{params}"
  #   end
  #
  # end

  params
end
new({ particle: :name, category: :identity, type: :string })
new({ particle: :active, category: :identity, type: :boolean })
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
new({ particle: :markup, category: :identity, type: :string })
new({ particle: :bundle, category: :identity, type: :string })
new({ particle: :data, category: :identity, type: :string })

new({ particle: :category, category: :identity, type: :string, store: false }) do |category_names|
  category_names = [category_names] unless category_names.instance_of? Array
  category_names.each do |category_name|
    @category << category_name
  end
end
# The selection particle is used by current user to store selected atomes
new(particle: :selection, category: :identity, type: :string)

new({ read: :selection }) do |params_get|
  selector = grab(:selector)
  selector.collect = params_get
  selector
end

new(particle: :selected, category: :identity, type: :boolean) do |params|
  if params == true
    border({ thickness: 3, red: 1, green: 1, blue: 1, alpha: 1, pattern: :dotted })
    border({ thickness: 10,  pattern: :solid, color: :red})
    grab(Universe.current_user).selection << @id
  elsif params == false
    border({alpha: 0, thickness: 0})
    grab(Universe.current_user).selection.collect.delete(@id)
  else
    # TODO: for future use
  end
  params
end

new({ particle: :format, category: :identity, type: :string })
new({ particle: :alien, category: :identity, type: :string }) # special particel that old alien object

new({ particle: :email, category: :identity, type: :string })