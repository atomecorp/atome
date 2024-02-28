# frozen_string_literal: true

new({ particle: :renderers, category: :utility, type: :string })
new({ particle: :code, category: :utility, type: :string })
new({ particle: :run, category: :utility, type: :boolean }) do |params|
  code_found = @code
  instance_exec(params, &code_found) if code_found.is_a?(Proc)
end
# new({ particle: :broadcast })

def delete_recursive(atome_id)
  return if grab(atome_id).tag && (grab(atome_id).tag[:persistent] || grab(atome_id).tag[:system])

  parent_id_found = grab(atome_id).attach
  parent_found = grab(parent_id_found)
  new_array = parent_found.attached.dup
  new_array.delete(atome_id)
  parent_found.instance_variable_set('@attached', new_array)
  grab(atome_id).attached.each do |atome_id_found|
    delete_recursive(atome_id_found)
  end
  grab(atome_id).render(:delete, { :recursive => true })
  grab(atome_id).touch(:remove)
  Universe.delete(atome_id)
end

new({ particle: :delete, category: :utility, type: :boolean, render: false }) do |params|
  if params == true
    # We use the tag persistent to exclude color of system object and other default colors
    unless @tag && (@tag[:persistent] || @tag[:system])
      # now we detach the atome from it's parent
      # now we init rendering
      render(:delete, params)
      # the machine delete the current atome from the universe
      id_found = @id.to_sym
      parent_found = grab(@attach)
      parent_found.attached.delete(id_found)
      Universe.delete(@id)
    end
  elsif params.instance_of? Hash

    if params[:recursive]
      unless grab(@id).tag && (grab(@id).tag[:persistent] || grab(@id).tag[:system])
        attached.each do |atttached_atomes|
          delete_recursive(atttached_atomes)
        end
        touch(:remove)
        render(:delete, params)
        Universe.delete(@id)
      end
    else
      # the machine try to find the sub particle id and remove it eg a.delete(monitor: :my_monitor) remove the monitor
      # with id my_monitor
      params.each do |param, value|
        atome[param][value] = nil
      end
    end

  elsif Universe.atome_list.include?(params)
    # we check if the params passed is an atome to treat it in a different way
    puts "write code here : #{apply} , #{attached}"
  else
    # alert grab(params).delete(true)
    send(params, 0) unless params == :id
  end
end
new({ particle: :clear, category: :utility, type: :boolean })

new({ post: :clear }) do
  attached_found = []
  attached.each do |attached_id_found|
    attached_found << attached_id_found
  end
  attached_found.each do |child_id_found|
    child_found = grab(child_id_found)
    # we exclude system  objects
    child_found&.delete(true) unless child_found.tag && child_found.tag[:system]
  end
end
new({ particle: :path, category: :utility, type: :string })
new({ particle: :schedule, category: :utility, type: :string }) do |date, proc|
  date = date.to_s
  delimiters = [',', ' ', ':', '-']
  format_date = date.split(Regexp.union(delimiters))
  Universe.renderer_list.each do |renderer|
    send("#{renderer}_schedule", format_date, &proc)
  end
end
# new({ particle: :read, category: :utility, type: :string }) do |file, proc|
#   Universe.renderer_list.each do |renderer|
#     send("#{renderer}_reader", file, &proc)
#   end
# end
new({ particle: :cursor, category: :utility, type: :string })

new({ particle: :preset, category: :utility, type: :string }) do |params|

  if params.instance_of? Hash
    Essentials.new_default_params(params)
    params_to_send = params
  else
    params_to_send = Essentials.default_params[params].dup
    # we remove preset to avoid infinite loop
    params_to_send.delete(:preset)
    params_to_send.delete(:type)
    params_to_send.each do |particle_found, value|
      send(particle_found, value)
    end
    params_to_send = { params => params_to_send }
  end
  params_to_send
end
new({ particle: :relations, category: :utility, type: :hash })
new({ particle: :tag, render: false, category: :utility, type: :hash })
new({ particle: :web, category: :utility, type: :string })
# new({ particle: :metrics, type: :hash })
# do not change the line below initialise is a special method
new({ initialize: :unit, value: {} })
new({ particle: :unit, store: false, type: :string, category: :utility }) do |params|
  params.each do |k, v|
    @unit[k] = v
    # now we refresh the particle
    send(k, send(k))
  end
  @unit
end
new({ particle: :login, category: :utility, type: :string }) do |params|
  set_current_user(id) if params
end
new({ particle: :hypertext, category: :utility, type: :string })
new({ particle: :hyperedit, category: :utility, type: :string })
new({ particle: :terminal, category: :utility, type: :string })
new({ particle: :read, category: :utility, type: :string })
new({ particle: :browse, category: :utility, type: :string })
new({ particle: :copies, category: :utility, type: :string })
new({ particle: :temporary, category: :utility, type: :int })
new({ particle: :atomes, category: :utility, type: :string })

new({ particle: :match, category: :utility, type: :string }) do |params, _bloc|
  params
end

new({ sanitizer: :match }) do |params, _bloc|
  params[:condition] = { min: { width: 0 } } unless params[:condition]
  params
end

new({ particle: :invert, category: :utility, type: :boolean })
new({ particle: :option, category: :utility, type: :string })

new({ particle: :duplicate, category: :utility, type: :string, store: false }) do |params|
  copy_number = if @duplicate
                  @duplicate.length
                else
                  0
                end
  new_atome_id = "#{@id}_copy_#{copy_number}"
  new_atome = Atome.new({ type: @type, renderers: @renderers, id: new_atome_id })

  attached_atomes = []
  attached_found = attached.dup
  particles_found = instance_variables.dup

  keys_to_delete = [:@history, :@callback, :@duplicate, :@copy, :@paste, :@touch_code, :@html, :@attached, :@id]
  keys_to_delete.each { |key| particles_found.delete(key) }
  params[:id] = new_atome_id

  particles_found.each do |particle_found|
    particle_name = particle_found.to_s.sub('@', '')

    particle_content = self.send(particle_name)
    # FIXME: find a better to attach object when false is found
    particle_content = :view if particle_content == false
    new_atome.set(particle_name => particle_content)
    # new_atome.instance_variable_set('@touch_code',touch_code)
  end

  attached_found.each do |child_id_found|
    child_found = grab(child_id_found)
    if child_found
      new_child = child_found.duplicate({})
      attached_atomes << new_child.id
    end
  end
  params[:attached] = attached_atomes
  # FIXME: below  dunno why we have to add this manually
  new_atome.height(@height)
  new_atome.width(@width)
  if params.instance_of? Hash
    params.each do |k, v|
      new_atome.send(k, v)
    end
  end

  @duplicate ||= {}
  @duplicate[new_atome_id] = new_atome

  new_atome
end

new({ after: :duplicate }) do |params|
  @duplicate[@duplicate.keys[@duplicate.keys.length - 1]]
end

new({ particle: :copy, category: :utility, type: :string }) do |items_id|
  items_id = [items_id] unless items_id.instance_of? Array
  grab(:copy).collect << items_id
end

new({ particle: :paste, category: :utility, type: :string }) do |params|

  all_copies = grab(:copy).collect
  if params == true
    copies_found = all_copies.last
  elsif params.instance_of? Integer
    copies_found = all_copies[params.to_i]
  elsif params.instance_of? Array
    copies_found = [all_copies[params[0]][params[1]]]
  end
  new_atomes = []
  applies_found = []
  copies_found.each do |copy_found|
    new_atome = grab(copy_found).duplicate({ attach: @id })
    new_atomes << new_atome.id
    # FIXME: below start to patch because apply is not apply , so we store it and apply it again
    applies_found << new_atome.apply
  end

  # FIXME: end here the patch  because apply is not apply , so we store it and apply it again
  new_atomes.each_with_index do |id_found, index|
    grab(id_found).apply(applies_found[index])
  end
  new_atomes
end

new({ read: :paste }) do |p|
  @copy
end

new({ particle: :backup, category: :utility, type: :string })

new({ particle: :import, category: :utility, type: :string })

new({ particle: :compute, category: :utility, type: :string }) do |params|
  params = { particle: params } unless params.instance_of?(Hash)
  params[:unit] ||= :pixel
  params[:reference] ||= :view
  params
end

new({ particle: :get, category: :utility, type: :string }) do |params|
  cell = params[:cell]
  row_nb = cell[0]
  column_nb = cell[1]
  data[row_nb][data[row_nb].keys[column_nb]] # we get the content of the cell
end

new ({ particle: :css, category: :utility, type: :string })

new({ read: :css }) do
  CssProxy.new(js, nil, self)
end