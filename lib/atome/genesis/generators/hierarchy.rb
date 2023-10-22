# frozen_string_literal: true

def attachment_common(children_ids, parents_ids, &user_proc)
  # FIXME : it seems we sometime iterate when for nothing
  parents_ids.each do |parent_id|
    # FIXME : find a more optimised way to prevent atome to attach to itself
    parent_found = grab(parent_id)
    parent_found.atome[:attached].concat(children_ids).uniq!
    children_ids.each do |child_id|
      child_found = grab(child_id)
      child_found&.render(:attach, parent_id, &user_proc)
    end
  end
end

new({ particle: :attach, render: false }) do |parents_ids, &user_proc|
  # puts "parents_ids is : #{ id} #{parents_ids}"

  unless parents_ids == []
    parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
    children_ids = [id]
    attachment_common(children_ids, parents_ids, &user_proc)
    parents_ids
  end

end

new({ particle: :attached, render: false }) do |children_ids, &user_proc|
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_ids = [id]
  attachment_common(children_ids, parents_ids, &user_proc)

  children_ids

end
new({ particle: :apply, render: false }) do |parents_ids, &user_proc|
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  children_ids = [id]
  parents_ids.each do |parent_id|

    parent_found = grab(parent_id)
    parent_affect = parent_found.instance_variable_get('@affect')
    unless parent_affect.instance_of? Array
      parent_found.instance_variable_set('@affect', [])
    end
    children_ids.each do |child_id|
      parent_found.instance_variable_get('@affect') << child_id
      child_found = grab(child_id)

      child_found&.render(:apply, parent_found, &user_proc)
    end
  end
  parents_ids
end


new({ particle: :apply, render: false , specific: :shadow }) do |parents_ids, &user_proc|

  # alert :super
  # parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  # children_ids = [id]
  # parents_ids.each do |parent_id|
  #
  #   parent_found = grab(parent_id)
  #   parent_affect = parent_found.instance_variable_get('@affect')
  #   unless parent_affect.instance_of? Array
  #     parent_found.instance_variable_set('@affect', [])
  #   end
  #   children_ids.each do |child_id|
  #     parent_found.instance_variable_get('@affect') << child_id
  #     child_found = grab(child_id)
  #
  #     child_found&.render(:apply, parent_found, &user_proc)
  #   end
  # end
  # parents_ids
end

new({ particle: :affect, render: false }) do |children_ids, &user_proc|
  children_ids.each do |child_id|
    child_found = grab(child_id)
    child_found&.render(:apply, self, &user_proc)
  end
  children_ids
end


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

