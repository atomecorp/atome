# frozen_string_literal: true

def attachment_common(child_id, parents_ids,direction, &user_proc)
  # FIXME : it seems we sometime iterate when for nothing
  parents_ids.each do |parent_id|
    child_found = grab(child_id)
    parent_found = grab(parent_id)
    if  direction ==:attach
      parent_found.attached ||= []
    else
      child_found.attach ||= []
    end
    child_found&.render(:attach, parent_id, &user_proc)
  end
end

new({ particle: :attach, render: false }) do |parents_ids, &user_proc|
  unless parents_ids == []
    parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)

    attachment_common(@id, parents_ids,:attach, &user_proc)
    parents_ids
  end

end

new({ particle: :attached, render: false }) do |children_ids, &user_proc|
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_ids = [@id]

  children_ids.each do |children_id|
    # grab(children_id).attach << @id

    attachment_common(children_id, parents_ids,:attached, &user_proc)
  end
  children_ids
end

new({ sanitizer: :attached }) do |children_ids|
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  children_ids
end

new({ particle: :apply, render: false, store: false }) do |parents_ids, &user_proc|
  # puts "probleme ici ca choppe trop de children id: #{@id} : #{parents_ids}"

  # alert "#{id} : #{parents_ids}"
  # parents_ids.each do |i|
  #    puts "****** #{i} ******"
  #    apply << i unless apply.include?(i)
  #  end
  instance_variable_set('@apply', []) unless instance_variable_get('@apply')

  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  children_ids = [id]
  # alert parents_ids
  parents_ids.each do |parent_id|
    instance_variable_get('@apply') << parent_id
    parent_found = grab(parent_id)
    parent_affect = parent_found.instance_variable_get('@affect')
    parent_found.instance_variable_set('@affect', []) unless parent_affect.instance_of? Array
    children_ids.each do |child_id|
      parent_found.instance_variable_get('@affect') << child_id
      child_found = grab(child_id)
      child_found&.render(:apply, parent_found, &user_proc)
      # store({ apply: parent_id })
      # s!tore_value(:apply,parent_id )

    end
  end
  # instance_variable_set('@apply', [:poi, ])
  parents_ids
end

new({ particle: :affect, render: false }) do |children_ids, &user_proc|
  children_ids.each do |child_id|
    child_found = grab(child_id)
    child_found&.render(:apply, self, &user_proc)
    # alert "#{child_id} , #{id}"
    # child_found.instance_variable_get("@apply") << id
    child_found&.apply([id], &user_proc)
  end
  children_ids
end
# new({ particle: :affect, render: false, store:  false}) do |children_ids, &user_proc|
#   puts '----'
#   children_ids.each do |child_id|
#     puts "id : #{id} =>child_id : #{child_id}"
#     # grab(child_id).apply([id])
#     # child_found = grab(child_id)
#     # applied_array=instance_variable_get('@affect')
#     applied_array=instance_variable_set('@affect',[child_id])
#     puts "applied_array is : #{applied_array}"
#     #   # we had to the target the id of the atome applied
#     #   puts :problem_below
#     #   applied_array<< id unless applied_array.include?(id)
#     #   child_found&.render(:apply, self, &user_proc)
#     #   # child_found&.render(:apply, self, &user_proc)
#   end
#   children_ids
# end
# new({ particle: :affect, render: false }) do |children_ids, &user_proc|
#   children_ids.each do |child_id|
#     child_found = grab(child_id)
#     applied_array=child_found.instance_variable_get('@apply')
#     # we had to the target the id of the atome applied
#     puts :problem_below
#     applied_array<< id unless applied_array.include?(id)
#     child_found&.render(:apply, self, &user_proc)
#     # child_found&.render(:apply, self, &user_proc)
#   end
#   children_ids
# end

new({ particle: :detached, store: false }) # unfastened
new({ sanitizer: :detached }) do |values|
  # unfastened
  if values.instance_of? Array
    values.each do |value|
      detach_atome(value)
    end
  else
    detach_atome(values)
    # we sanitize the values so it always return an array to the renderer
    values = [values]
  end
  values
end
new({ particle: :collected })

