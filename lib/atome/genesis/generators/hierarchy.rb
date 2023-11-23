# frozen_string_literal: true

def attachment_common(child_id, parents_id, direction, &user_proc)
  # FIXME : it seems we sometime iterate when for nothing
  # parents_ids.each do |parent_id|
  #   parent_found = grab(parent_id)
  #   if direction == :attach
  #     parent_found.attached ||= []
  #     parent_found.attached.push(@id) unless parent_found.attached.include?(@id)
  #     render(:attach, parent_id, &user_proc)
  #   else
  #     child_found= grab(child_id)
  #     child_found.attach ||= []
  #     child_found.attach.push(parent_id) unless attach.include?(parent_id)
  #     child_found.render(:attach, parent_id, &user_proc)
  #   end
  # end
  # alert "self: #{@id} : parents_ids : #{parents_ids}, #{parents_ids.class}"
  parent_found = grab(parents_id)
  if direction == :attach
    # puts "case 2 ; #{parents_id} -  #{parents_id.class} remove condition below"
    # if parent_found
      parent_found.attached ||= []
      parent_found.attached.push(@id) unless parent_found.attached.include?(@id)
      render(:attach, parents_id, &user_proc)
    # end

  else
    child_found = grab(child_id)
    # child_found.attach ||= []
    # child_found.attach.push(parents_ids) unless attach.include?(parents_ids)

    child_found.render(:attach, parents_id, &user_proc)
  end
  # end

end

new({ particle: :attach, render: false }) do |parents_id, &user_proc|
  # unless parents_ids == []
  # parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  # puts "parents_ids : #{parents_ids}"
  #   if parents_id.instance_of?(Array)
  #     puts "self: #{@id} : parents_ids : #{parents_id}"
  #     else
  #   end
  # if parents_id.instance_of? Array
  #   parents_id= :my_box
  # end
  attachment_common(@id, parents_id, :attach, &user_proc)
  # puts "pass!! : #{parents_ids}"
  parents_id
  # end

end

new({ particle: :attached, render: false }) do |children_ids, &user_proc|
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  # alert "parents_ids : #{@id}"
  parents_id = @id
  children_ids.each do |children_id|
    # alert "here : #{children_id} ==>  #{parents_id}  : #{parents_id.class}"
    attachment_common(children_id, parents_id, :attached, &user_proc)
  end
  children_ids
end

new({ sanitizer: :attached }) do |children_ids|
  # alert "children_ids : #{children_ids}"
  # children_ids = [children_ids] unless children_ids.instance_of?(Array)
  children_ids
end

new({ particle: :apply, render: false, store: false }) do |parents_ids, &user_proc|
  puts "here => #{parents_ids}"
  # TODO: optimize the 2 lines below:
  @apply ||= []
  parents_ids = [parents_ids] unless parents_ids.instance_of?(Array)
  parents_ids.each do |parent_id|
    @apply.delete(parent_id)
    @apply << parent_id
  end
  parents_ids = @apply
  children_ids = [id]
  parents_ids.each do |parent_id|
    parent_found = grab(parent_id)
    parent_affect = parent_found.instance_variable_get('@affect')
    parent_found.instance_variable_set('@affect', []) unless parent_affect.instance_of? Array
    affect_element = parent_found.instance_variable_get('@affect')
    children_ids.each do |child_id|
      # affect_element << child_id unless affect_element.include?(child_id)
      affect_element.delete(child_id)
      affect_element.push(child_id)
      affect_element << child_id
      child_found = grab(child_id)
      child_found&.render(:apply, parent_found, &user_proc)
    end
  end
  @apply = parents_ids

  parents_ids
end

new({ particle: :affect, render: false }) do |children_ids, &user_proc|
  children_ids.each do |child_id|
    child_found = grab(child_id)
    child_found&.apply([id], &user_proc)
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

