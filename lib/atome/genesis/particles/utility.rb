# frozen_string_literal: true
def delete_recursive(atome_id, force = false)
  return if grab(atome_id).tag && (grab(atome_id).tag[:persistent] || grab(atome_id).tag[:system]) unless force
  touch(false)
  parent_id_found = grab(atome_id).attach
  parent_found = grab(parent_id_found)
  new_array = parent_found.fasten.dup
  new_array.delete(atome_id)
  parent_found.instance_variable_set('@fasten', new_array)
  grab(atome_id).fasten.each do |atome_id_found|
    delete_recursive(atome_id_found, force)
  end
  grab(atome_id).render(:delete, { :recursive => true })
  grab(atome_id).touch(false)
  Universe.delete(grab(atome_id).aid)
end

new({ particle: :renderers, category: :utility, type: :string })
new({ particle: :code, category: :utility, type: :string, store: false }) do |params, code|
  @code[params] = code
end
new({ particle: :run, category: :utility, type: :boolean }) do |params, code|
  instance_exec(&params) if params.is_a?(Proc)
  code_found = @code[params]
  instance_exec(params, &code_found) if code_found.is_a?(Proc)
end
new({ particle: :target, category: :utility, type: :string }) do |params|
  params.each do |atome_f, value_f|
    if value_f.instance_of?(Hash)
      value_f.each do |part_f, part_val|
        grab(atome_f).send(part_f, part_val)
      end
    else
      grab(atome_f).send(value_f)
    end
  end
end
new({ particle: :delete, category: :utility, type: :boolean, render: false }) do |params|
  # if params == true
  #   touch(false)
  #   # We use the tag persistent to exclude color of system object and other default colors
  #   unless @tag && (@tag[:persistent] || @tag[:system])
  #     # if we are on a matrix we delete cells found & group found
  #     cells.delete(true)
  #     group.delete(true)
  #     # now we detach the atome from it's parent
  #     # now we init rendering
  #     render(:delete, params)
  #     # the machine delete the current atome from the universe
  #     id_found = @id.to_sym
  #     if @attach
  #       parent_found = grab(@attach)
  #       parent_found.fasten.delete(id_found)
  #     end
  #     @affect&.each do |affected_atome|
  #       affected_found = grab(affected_atome)
  #       affected_found.apply.delete(id_found)
  #       affected_found.refresh
  #     end
  #     grab(attach).unfasten([id])
  #     # wait 0.1 do
  #       Universe.delete(@aid)
  #     # end
  #   end
  # elsif params == false
  #
  #
  #   cells.delete(true)
  #
  #   # touch(false)
  #   # render(:delete, params)
  #   render(:delete, params)
  #   Universe.delete(@aid)
  # elsif params.instance_of? Hash
  #   # if we are on a matrix we delete cells found & group found
  #   cells.delete(true)
  #   group.delete(true)
  #   touch(false)
  #   if params[:recursive] == true
  #     grab(attach).unfasten([id])
  #     unless grab(@id).tag && (grab(@id).tag[:persistent] || grab(@id).tag[:system])
  #       fasten.each do |atttached_atomes|
  #         delete_recursive(atttached_atomes)
  #       end
  #       # touch(false)
  #       # render(:delete, params)
  #       # html.delete(@id)
  #       Universe.delete(@aid)
  #     end
  #   elsif params[:force]
  #     fasten.each do |atttached_atomes|
  #       delete_recursive(atttached_atomes, true)
  #     end
  #     touch(false)
  #     render(:delete, params)
  #     Universe.delete(@aid)
  #
  #   else
  #     # the machine try to find the sub particle id and remove it eg a.delete(monitor: :my_monitor) remove the monitor
  #     # with id my_monitor
  #     params.each do |param, value|
  #       atome[param][value] = nil
  #     end
  #   end
  #
  # elsif Universe.atome_list.include?(params)
  #   # we check if the params passed is an atome to treat it in a different way
  #   puts "write code here : #{apply} , #{fasten}"
  # else
  #   send(params, 0) unless params == :id
  # end

  if params == true
    touch(false)
    # We use the tag persistent to exclude color of system object and other default colors
    unless @tag && (@tag[:persistent] || @tag[:system])
      # if we are on a matrix we delete cells found & group found
      cells.delete(true)
      group.delete(true)
      # now we detach the atome from its parent
      # now we init rendering
      render(:delete, params)
      # the machine delete the current atome from the universe
      id_found = @id.to_sym
      if @attach
        parent_found = grab(@attach)
        parent_found.fasten.delete(id_found)
      end
      @affect&.each do |affected_atome|
        affected_found = grab(affected_atome)
        affected_found.apply.delete(id_found)
        affected_found.refresh
      end
      grab(attach).unfasten([id])
      delete_with_callback
    end
  elsif params == false
    cells.delete(true)
    render(:delete, params)
    delete_with_callback
  elsif params.instance_of? Hash
    cells.delete(true)
    group.delete(true)
    touch(false)
    if params[:recursive] == true
      grab(attach).unfasten([id])
      unless grab(@id).tag && (grab(@id).tag[:persistent] || grab(@id).tag[:system])
        fasten.each do |atttached_atomes|
          delete_recursive(atttached_atomes)
        end
        delete_with_callback do
          # puts "Atome #{@id}  recursive delete"
        end
      end
      ############# here
       render(:delete, params)
    elsif params[:force]
      fasten.each do |atttached_atomes|
        delete_recursive(atttached_atomes, true)
      end
      touch(false)
      render(:delete, params)
      delete_with_callback do
        #  puts "Atome #{@id} force deleted"
      end
    else
      params.each do |param, value|
        atome[param][value] = nil
      end
    end
  elsif Universe.atome_list.include?(params)
    puts "write code here : #{apply} , #{fasten}"
  else
    send(params, 0) unless params == :id
  end

end
new({ particle: :clear, category: :utility, type: :boolean })

def delete_children_recursively(parent_id)
  parent = grab(parent_id)
  return unless parent&.fasten

  children_to_delete = []
  parent.fasten.each do |child_id|
    children_to_delete << child_id
  end

  children_to_delete.each do |child_id|
    child = grab(child_id)
    next unless child

    next if child.tag && child.tag[:system]

    delete_children_recursively(child_id)

    child.delete(true)
  end
end

new({ post: :clear }) do
  delete_children_recursively(id)
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
new({ particle: :write, category: :utility, type: :hash })
new({ particle: :content, category: :utility, type: :string }) # used to store raw data
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
  fasten_atomes = []
  fasten_found = fasten.dup
  fasten_found.each do |child_id_found|
    child_found = grab(child_id_found)
    if child_found
      new_child = child_found.duplicate({})
      fasten_atomes << new_child.id
    end
  end
  params[:fasten] = fasten_atomes
  infos_found = infos.dup
  keys_to_delete = %i[history callback duplicate copy paste touch_code html fasten aid]
  keys_to_delete.each { |key| infos_found.delete(key) }
  new_atome_id = "#{@id}_copy_#{copy_number}".to_sym
  infos_found[:id] = new_atome_id
  infos_found = infos_found.merge(params)
  new_atome = Atome.new(infos_found)
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
new({ particle: :css, category: :utility, type: :string })
new({ read: :css }) do
  CssProxy.new(js, nil, self)
end
new({ particle: :holder, category: :utility, type: :atome })
# this particle is mainly used in conjunction with alternate particle as a 'lambda' to alternate  methods
new({ particle: :executor, category: :utility, type: :hash }) do |params|
  params.each do |method, opt|
    send(method, opt)
  end
  params
end
new({ particle: :tick, category: :utility, store: false, type: :hash }) do |val|
  @tick[val] ||= 0
  @tick[val] = @tick[val] += 1
  @tick[val]
end
new({ particle: :storage, category: :utility, type: :hash })
new({ particle: :state, category: :utility, type: :symbol })
new({ particle: :record, category: :utility, type: :hash })
new({ particle: :preview, category: :utility, type: :hash })
new({ particle: :meteo, category: :utility, type: :string })
new({ particle: :timer, category: :utility, type: :hash }) do |params, bloc|
  @timer_callback = bloc
  # params[:start] = (timer[:position] || 0) unless params[:start]
  unless params[:start]
    if timer && timer[:position]
      params[:start] = timer[:position]
    else
      params[:start] = 0
    end
  end
  params[:end] = (params[:position] || 0) unless params[:end]
  if params[:stop]
    js_timer('kill', nil, id)
    params[:position] = 0
    params
  elsif params[:pause]
    end_val = timer[:position]
    js_timer('kill', nil, id)
    params[:position] = end_val
    params[:start] = end_val
    params
  else
    js_timer('kill', nil, id)
    js_timer(params[:start], params[:end], id)
    params
  end

end
