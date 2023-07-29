# frozen_string_literal: true

# new({ particle: :attach }) do |params|
#   puts "1 - Attach: parents:#{self.id}, children: #{params}"
#   params
# end
#
# new({ sanitizer: :attach }) do |parents_ids|
#   parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
#   parents_ids.each do |parents_id|
#     parent_found = grab(parents_id)
#     # TODO : factorise the code below
#     type_found = atome[:type]
#     # TODO : factorise the code above
#     parent_found.atome[:attached] = [] unless parent_found.atome[:attached]
#     parent_found.atome[:attached] << atome[:id]
#     unless parent_found.atome["#{type_found}s"]
#       parent_found.atome["#{type_found}s"] = [parent_found.atome["#{type_found}s"]].compact!
#     end
#     parent_found.atome["#{type_found}s"] << atome[:id]
#     if parent_found.atome[:type] == :group
#       group_atome_analysis(parent_found)
#       parents_ids = []
#     end
#   end
#
#   parents_ids
# end
#
# new({ particle: :attached }) do |params|
#   puts "2 - Attached: parents:#{self.id}, children: #{params}"
#   params
# end
#
# new({ sanitizer: :attached }) do |children_ids|
#   @atome[:attached] = [@atome[:attached]] unless attached.instance_of?(Array)
#   # we ensure children_ids is an array
#   children_ids = [children_ids] unless children_ids.instance_of?(Array)
#   # we concat with previous attached atomes @atome[:attached] else old attached atomes will be lost
#   @atome[:attached].concat(children_ids).uniq!
#
#   children_ids.each do |child_id|
#     child_found = grab(child_id)
#     parent_found = @atome[:id]
#     type_found = child_found.type
#     atome["#{type_found}s"] = [atome["#{type_found}s"]].compact! unless child_found.atome["#{type_found}s"]
#     atome["#{type_found}s"] << child_id if atome["#{type_found}s"]
#     # TODO : factorise the code above
#
#     # tryout below
#     # To allow correct handling of attachment according to it's tyoe
#     # puts"#{child_found}.attach([#{parent_found}])"
#     # child_found.attach([parent_found])
#     # alert "passed"
#     child_found.atome[:attach] = [parent_found]
#   end
#   # we return all @atome[:attached] else old attached atomes will be lost
#   @atome[:attached]
# end

def attachment_sanitiser(element)
  element = [element] unless element.instance_of?(Array)
  # @atome[:attach]= [] unless @atome[:attach]
  # @atome[:attached]= [] unless @atome[:attached]
  element
end


def attachment_common(children_ids,parents_ids, &user_proc)
  @atome[:attach].concat(parents_ids).uniq!
  @atome[:attached].concat(children_ids).uniq!

  parents_ids.each do |parent_id|
    # parent=grab(parent_id)
    children_ids.each do |child_id|
      puts "=====> child to add #{@atome[:attached]}"
      child=grab(child_id)
      child.render(:attach, parent_id, &user_proc) if child
    end

  end

end

# new attachment method

new({ particle: :attach, render: false }) do |parents_ids, &user_proc|
  # we ensure it's an array
  parents_ids = attachment_sanitiser(parents_ids)
  attachment_common([id],parents_ids, &user_proc)

end

new({ particle: :attached, render: false }) do |children_ids, &user_proc| # fastened
  # we ensure it's an array
  children_ids = attachment_sanitiser(children_ids)
  attachment_common(children_ids,[id], &user_proc)

end

# end
new({ particle: :detached, store: false }) # unfastened
new({ sanitizer: :detached }) do |values| # unfastened
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
