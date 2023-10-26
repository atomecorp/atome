# frozen_string_literal: true

new({ particle: :renderers })
new({ particle: :code })
new({ particle: :run }) do |params|
  code_found = @code
  instance_exec(params, &code_found) if code_found.is_a?(Proc)
end
new({ particle: :broadcast })
new({ particle: :data })
# new({particle: :additional })
new({ particle: :delete, render: false }) do |params, &user_proc|
  if params == true
    # We use the tag persistent to exclude color of system object and other default colors
    unless @tag && @tag[:persistent]
      # now we detach the atome from it's parent
      # now we init rendering
      render(:delete, params, &user_proc)
      # the machine delete the current atome from the universe
      id_found = @id.to_sym
      parents_found = @attach
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
      alert "write code here : #{params}"
      # @!atome["#{params}s"].each do |item_to_del|
      #
      #   delete({ id: item_to_del })
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

    child_found&.delete(true)

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
new({ particle: :temporary })
new({ particle: :atomes })
new ({ particle: :build, store: false }) do |params|
  # we get the id or generate it for the new builder
  if params[:id]
    byild_id = params[:id]
  else
    byild_id = "auto_builded_#{Universe.atomes.length}"
    params[:id] = byild_id
  end
  # now we create a hash if it doesnt already exist
  # if it exist we feed the hash
  if build
    build[byild_id] = params
  else
    #
    build_hash = { byild_id => params }
    store({ 'build': build_hash })
  end

  # now we'll created the wanted atomes
  # here are the default params
  default_styles = { type: :shape, renderers: [:html], width: 66, height: 66, color: :gray, left: 12, top: 12, copies: 0, attach: [:view] }
  params = default_styles.merge(params)
  color_found = color(params[:color])
  left_pos = params[:left]
  top_pos = params[:top]
  atomes({}) unless atomes

  params[:id] = identity_generator(params[:type]) unless params[:id]
  atomes[params[:id]] = []
  params[:copies].downto(0) do |index|
    item_number = params[:copies] - index
    bundle_id = if params[:id]
                  "#{params[:id]}_#{item_number}"
                else
                  "#{params[:id]}_#{item_number}"
                end
    copied_items_params = params.dup
    copied_items_params[:id] = bundle_id
    a = Atome.new(copied_items_params)
    a.attach(copied_items_params[:attach])
    a.apply([color_found.id])
    a.left(((a.width + left_pos) * item_number) + left_pos)
    a.top(((a.height + top_pos) * item_number) + top_pos)
    atomes[params[:id]] << bundle_id
  end
end

new({ particle: :match }) do |params,_bloc|
  params
end

new({ sanitizer: :match }) do |params, _bloc|
  params[:condition] = { min: { width: 0 } } unless params[:condition]
  params
end

new({ particle: :invert })
new({ particle: :option })






