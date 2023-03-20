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
new({ particle: :delete }) do |params|
  if params == true
    # now we detach the atome from it's parent
    parents_found = @atome[:attach]
    parents_found.each do |parent_found|
      grab(parent_found).detached(@atome[:id])
    end

    # the machine delete the current atome from the universe
    Universe.delete(@atome[:id])
  elsif params == :materials
    # this will delete any child with a visual type cf : images, shapes, videos, ...
    materials.each do |atome_id_found|
      grab(atome_id_found).delete(true)
    end
  elsif params[:id]
    # the machine try to an atome by it's ID and delete it
    grab(params[:id]).delete(true)
  elsif params.instance_of? Hash
    # the machine try to find the sub particle id and remove it eg a.delete(monitor: :my_monitor) remove the monitor
    # with id my_monitor
    params.each do |param, value|
      atome[param][value] = nil
    end
  else
    # the machine try to reset the current particle(params), eg a.delete(:left) => left: 0
    send(params, 0)
  end
end
new({ particle: :clear })
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
new({ particle: :tag , render: false, type: :hash})
new({ particle: :batch, render: false })
new({ sanitizer: :batch }) do |params|
  Batch.new(params)
  # puts "index msg : we must treat the batch : #{params}"

end

