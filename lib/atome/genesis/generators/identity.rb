# frozen_string_literal: true

new({ particle: :attach })
new({ sanitizer: :attach }) do |parents_ids|

  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)

  parents_ids.each do |parents_id|
    parents_found = grab(parents_id)
    # TODO : factorise the code below
    type_found = atome[:type]
    # TODO : factorise the code above
    parents_found.atome[:attached] = [] unless parents_found.atome[:attached]
    parents_found.atome[:attached] << atome[:id]
    unless parents_found.atome["#{type_found}s"]
      parents_found.atome["#{type_found}s"] = [parents_found.atome["#{type_found}s"]].compact!
    end
    parents_found.atome["#{type_found}s"] << atome[:id]
  end
  puts "MSG from identity  => #{id} passed!"
  parents_ids
end

new({ particle: :attached })
new({ sanitizer: :attached }) do |children_ids|
  @atome[:attached] = [@atome[:attached]] unless attached.instance_of?(Array)
  # we ensure children_ids is an array
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  # we concat with previous attached atomes @atome[:attached] else old attached atomes will be lost
  @atome[:attached].concat(children_ids).uniq!

  children_ids.each do |child_id|
    child_found = grab(child_id)
    parents_found = @atome[:id]
    type_found=child_found.type
    atome["#{type_found}s"] = [atome["#{type_found}s"]].compact! unless child_found.atome["#{type_found}s"]
    atome["#{type_found}s"] << child_id if atome["#{type_found}s"]
    # TODO : factorise the code above
    child_found.atome[:attach] = [parents_found]
  end
  # we return all @atome[:attached] else old attached atomes will be lost
  @atome[:attached]
end
# new({ post: :attached }) do |params|
#   puts "======++> #{params}"
# end
new({ particle: :detached, store: false })
new({ sanitizer: :detached }) do |values|
  if values.instance_of? Array
    values.each do |value|
      detach_atome(value)
    end
  else
    detach_atome(values)
    # we sanitize the values so it always return an array to the renderer
    values = [values]
  end
  # alert "==> #{@atome}"
  values
end

new({ particle: :real })
new({ particle: :type })
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
