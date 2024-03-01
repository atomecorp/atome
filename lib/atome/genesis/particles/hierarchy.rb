# frozen_string_literal: true
def detach_child(child)
  return unless child.attach

    parent = grab(child.attach)
    parent.attached.delete(@id)
  
end

# def detach_from_parent(parent_found, child_found)
#   child_found.attach(parent_found.id)
# end

def attachment_common(child_id, parents_id, direction, &user_proc)

  parent_found = grab(parents_id)
  if direction == :attach
    if parent_found
      parent_found.attached ||= []
      parent_found.attached.push(@id) unless parent_found.attached.include?(@id)
      detach_child(self)
      render(:attach, parents_id, &user_proc)
    else
      # we remove the current id  from parent
      # grab(attach).attached.delete(@id)
    end
  else
    child_found = grab(child_id)
    child_found.attach(parents_id)
    child_found.render(:attach, parents_id, &user_proc)
  end
end

new({ particle: :attach, category: :hierarchy, type: :string, render: false }) do |parents_id, &user_proc|
  attachment_common(@id, parents_id, :attach, &user_proc)
  parents_id
end

new({ particle: :attached, category: :hierarchy, type: :string, render: false }) do |children_ids, &user_proc|
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_id = @id
  children_ids.each do |children_id|
    attachment_common(children_id, parents_id, :attached, &user_proc)
  end
  children_ids
end

new({ sanitizer: :attached }) do |children_ids|
  children_ids
end

new({ particle: :apply, category: :hierarchy, type: :string, render: false, store: false }) do |parents_ids, &user_proc|
  # TODO: optimize the 2 lines below:
  # html.reset_background
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
      # affect_element.push(child_id)
      affect_element << child_id
      child_found = grab(child_id)
      child_found&.render(:apply, parent_found, &user_proc)
    end
  end
  @apply = parents_ids

  parents_ids
end

new({ particle: :affect, category: :hierarchy, type: :string, render: false }) do |children_ids, &user_proc|
  children_ids = [children_ids] unless children_ids.instance_of? Array
  children_ids.each do |child_id|
    child_found = grab(child_id)
    #FIXME : found why it crash when removing the condition below
    unless child_found.id == :black_matter
      child_found.remove({all: :paint})
    end
    child_found.apply([id], &user_proc)
  end

  children_ids
end

new({ particle: :detached, category: :hierarchy, type: :string, store: false }) # unfastened
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
new({ particle: :collect, category: :hierarchy, type: :string })
