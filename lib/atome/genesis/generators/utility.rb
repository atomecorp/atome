# frozen_string_literal: true

new({ particle: :renderers })
new({ particle: :code })
new({ particle: :run }) do |params|
  code_found = @code
  instance_exec(params, &code_found) if code_found.is_a?(Proc)
end
new({ particle: :broadcast })

def delete_recursive(atome_id)
  return if grab(atome_id).tag && (grab(atome_id).tag[:persistent] || grab(atome_id).tag[:system])
  parents_found = grab(atome_id).attach
  parents_found.each do |parent_id_found|
    parent_found = grab(parent_id_found)
    new_array = parent_found.attached.dup
    new_array.delete(atome_id)
    parent_found.instance_variable_set('@attached', new_array)
  end
  grab(atome_id).attached.each do |atome_id_found|
    delete_recursive(atome_id_found)
  end
  grab(atome_id).render(:delete, { :recursive => true })
  grab(atome_id).touch(:remove)
  Universe.delete(atome_id)
end

new({ particle: :delete, render: false }) do |params|
  if params == true
    # We use the tag persistent to exclude color of system object and other default colors
    unless @tag && (@tag[:persistent] || @tag[:system])
      # now we detach the atome from it's parent
      # now we init rendering
      render(:delete, params)
      # the machine delete the current atome from the universe
      id_found = @id.to_sym
      # parents_found = @attach
      # Universe.delete(id_found)
      # alert "parents_found : #{parents_found}, #{parents_found.class}"
      # parents_found.each do |parent_id_found|
      #   parent_found = grab(parent_id_found)
      #   parent_found.attached.delete(id_found)
      # end

      parent_found = grab(@attach)
      parent_found.attached.delete(id_found)

    end
    # elsif params == :physical
    #   # this will delete any child with a visual type cf : images, shapes, videos, ...
    #   physical.each do |atome_id_found|
    #     # atome_id_found.delete(true)
    #     grab(atome_id_found).delete(true)
    #   end
    # elsif params[:id]
    # the machine try to an atome by it's ID and delete it
    # We check for recursive, if found we delete attached atomes too
    # if params[:recursive] == true
    #   physical_found = grab(params[:id]).physical
    #   physical_found.each do |atome_id_found|
    #     grab(atome_id_found).delete(true)
    #   end
    # end
    # grab(params[:id]).delete(true)
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

  else

    # we check if the params passed is an atome to treat it in a different way
    if Universe.atome_list.include?(params)
      alert "write code here : #{apply} , #{attached}"
      # @apply.each do |color_to_remove|
      # wait 0.1 do
      #   remove(color_to_remove)
      # end
    else
      send(params, 0) unless params == :id
    end
  end
end
new({ particle: :clear })
new({ post: :clear }) do
  attached_found = []
  attached.each do |attached_id_found|
    attached_found << attached_id_found
  end
  attached_found.each do |child_id_found|
    child_found = grab(child_id_found)
    # we exclude system  objects
    unless child_found.tag && child_found.tag[:system]
      child_found&.delete(true)
    end
  end
end
new({ particle: :path })
new({ particle: :schedule }) do |date, proc|
  date = date.to_s
  delimiters = [',', ' ', ':', '-']
  format_date = date.split(Regexp.union(delimiters))
  Universe.renderer_list.each do |renderer|
    send("#{renderer}_schedule", format_date, &proc)
  end
end
new({ particle: :read }) do |file, proc|
  Universe.renderer_list.each do |renderer|
    send("#{renderer}_reader", file, &proc)
  end
end
new({ particle: :cursor })

new({ particle: :preset }) do |params|

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
new({ particle: :relations, type: :hash })
new({ particle: :tag, render: false, type: :hash })
new({ particle: :web })
new({ particle: :unit, type: :hash })
new({ initialize: :unit, value: {} })
new({ particle: :login }) do |params|
  set_current_user(id) if params
end
new({ particle: :hypertext })
new({ particle: :hyperedit })
new({ particle: :terminal })
new({ particle: :read })
new({ particle: :browse })
new({ particle: :copies })
new({ particle: :temporary })
new({ particle: :atomes })

new({ particle: :match }) do |params, _bloc|
  params
end

new({ sanitizer: :match }) do |params, _bloc|
  params[:condition] = { min: { width: 0 } } unless params[:condition]
  params
end

new({ particle: :invert })
new({ particle: :option })






