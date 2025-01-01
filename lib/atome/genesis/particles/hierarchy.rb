# frozen_string_literal: true
def detach_child(child)
  return unless child.attach

  parent = grab(child.attach)
  parent.fasten.delete(@id)

end

def attachment_common(child_id, parents_id, direction, &user_proc)

  parent_found = grab(parents_id)
  if direction == :attach
    if parent_found
      parent_found.fasten ||= []
      parent_found.fasten.push(@id) unless parent_found.fasten.include?(@id)
      detach_child(self)
      render(:attach, parents_id, &user_proc)
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

new({ particle: :fasten, category: :hierarchy, type: :string, render: false }) do |children_ids, &user_proc|
  children_ids = [children_ids] unless children_ids.instance_of?(Array)
  parents_id = @id
  children_ids.each do |children_id|
    attachment_common(children_id, parents_id, :fasten, &user_proc)
  end
  children_ids
end

new({ sanitizer: :fasten,category: :hierarchy, type: :string }) do |children_ids|
  children_ids
end

new({ particle: :unfasten,category: :hierarchy, type: :string  }) do |params|
  params = fasten if params == :all
  dup_params = params.dup
  dup_params.each do |param|
    if fasten.include?(param)
      fasten.delete(param)
      atome_to_unfasten = grab(param)
      atome_to_unfasten_left = atome_to_unfasten.left
      atome_to_unfasten_top = atome_to_unfasten.top
      parent_top = top
      parent_left = left
      atome_to_unfasten.attach(:view)
      atome_to_unfasten.left(atome_to_unfasten_left + parent_left)
      atome_to_unfasten.top(atome_to_unfasten_top + parent_top)
    end
  end
end

new({ particle: :detach,category: :hierarchy, type: :string  }) do |params|
  grab(params).unfasten([id])
end

new({ particle: :apply, category: :hierarchy, type: :string, render: false, store: false }) do |parents_ids, &user_proc|
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
      affect_element.delete(child_id)
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
    # FIXME : found why it crash when removing the condition below
    unless child_found.id == :black_matter
      child_found.remove({ all: :paint })
    end
    child_found.apply([id], &user_proc)
  end

  children_ids
end

new({ particle: :collect, category: :hierarchy, type: :string })
