# frozen_string_literal: true

new({ particle: :renderers })
new({ particle: :code })
new({ particle: :run }) do |params|
  code_found = @atome[:code]
  instance_exec(params, &code_found) if code_found.is_a?(Proc)
end
new({ particle: :broadcast })
new({ particle: :data })
# new({particle: :additional })
new({ particle: :delete, render: false }) do |params, &user_proc|
  if params == true
    # We use the tag persistent to exclude color of system object and other default colors
    unless tag && tag[:persistent]
      # now we detach the atome from it's parent
      # now we init rendering
      render(:delete, params, &user_proc)
      # the machine delete the current atome from the universe
      id_found = @atome[:id].to_sym
      parents_found = @atome[:attach]
      Universe.delete(id_found)
      parents_found.each do |parent_id_found|
        parent_found = grab(parent_id_found)
        parent_found.attached.delete(id_found)
      end

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
    # the machine try to find the sub particle id and remove it eg a.delete(monitor: :my_monitor) remove the monitor
    # with id my_monitor
    params.each do |param, value|
      atome[param][value] = nil
    end
  else


    # we check if the params passed is an atome to treat it in a different way
    if Universe.atome_list.include?(params)
      @atome["#{params}s"].each do |item_to_del|

        delete({ id: item_to_del })
      end
    else
      send(params, 0) unless params == :id
    end
  end
end
new({ particle: :clear })
new({ post: :clear }) do

  attached_found = []
  @atome[:attached].each do |attached_id_found|
    attached_found << attached_id_found
  end
  attached_found.each do |child_id_found|

    child_found = grab(child_id_found)

    child_found.delete(true) if child_found

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
new({ particle: :preset })
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







