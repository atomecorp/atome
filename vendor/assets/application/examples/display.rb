# #  frozen_string_literal: true
#
# new({ particle: :display, render: false }) do |params|
#   # alert type
#   unless params[:items]
#     params[:items] = { width: 200, height: 33 }
#   end
#   container_width = params[:width] ||= width
#   container_height = params[:heigth] ||= height
#   container_top = params[:top] ||= top
#   container_left = params[:left] ||= left
#
#   item_width = params[:items][:width] ||= 400
#   item_height = params[:items][:height] ||= 50
#   item_margin = params[:margin] ||= 3
#
#   mode = params[:mode]
#
#   case mode
#   when :none
#   when :custom
#   when :list
#     if params[:data].instance_of? Array
#     elsif params[:data] == :particles
#       list_id = "#{id}_list"
#       unless grab(list_id)
#         container = ''
#         attach.each do |parent|
#           container = grab(parent).box({ id: list_id, left: container_left, top: container_top, width: container_width, height: container_height, overflow: :auto, color: :black, depth: 0 })
#           container.on(:resize) do |event|
#             puts event[:dx]
#           end
#           container.resize({ min: { width: 100, height: 100 }, max: { width: 300, height: 700 } }) do |event|
#             puts event
#           end
#
#         end
#         sorted_particles = particles.sort.to_h
#         sorted_particles.each_with_index do |(particle_found, value), index|
#           line = container.box({ id: "#{list_id}_#{index}", width: item_width, height: item_height, left: 0, top: ((item_height + item_margin) * index) })
#           line.text({ data: "#{particle_found} : ", top: -item_height / 2, left: 2 })
#           if value.instance_of?(String) || value.instance_of?(Symbol) || value.instance_of?(Integer)
#             input_value = line.text({ data: value, top: -item_height / 2, left: 5, edit: true })
#             input_value.keyboard(:down) do |native_event|
#               event = Native(native_event)
#               if event[:keyCode].to_i == 13
#                 event.preventDefault()
#                 input_value.color(:red)
#               end
#             end
#             input_value.keyboard(:up) do |native_event|
#               data_found = input_value.data
#               send(particle_found, data_found)
#             end
#           else
#             puts "value is :#{value.class} => #{value}"
#           end
#         end
#         closer = container.circle({ id: "#{list_id}_closer", width: 33, height: 33, top: 3, right: 3, color: :red, position: :sticky })
#         closer.touch(true) do
#           container.delete(true)
#         end
#       end
#     else
#     end
#   when :grid
#     grid_id = "#{id}_grid"
#     unless grab(grid_id)
#       container = grab(:view).box({ id: grid_id, width: container_width, height: container_height, overflow: :auto, color: :white, depth: 0 })
#       ############## deletion
#       container.touch(true) do
#         alert "removing container recursively : #{container.id}"
#         val_1= Universe.atomes.length
#         puts "val_1 : #{val_1}"
#         container.delete({ recursive: true })
#         val_2= Universe.atomes.length
#         puts "val_2 : #{val_2}"
#         puts "val_1-val_2 : #{val_1-val_2}"
#       end
#       ############## deletion
#       params[:data].each_with_index do |item, index|
#         # unless grab("#{grid_id}_#{index}")
#           item = container.box({ id: "#{grid_id}_#{index}", top: 0, position: :relative, left: nil, right: nil })
#           # item.touch(true) do
#           #   alert "removing container recursively : #{container.id}"
#           #   val_1= Universe.atomes.length
#           #   puts "val_1 : #{val_1}"
#           #   container.delete({ recursive: true })
#           #   val_2= Universe.atomes.length
#           #   puts "val_2 : #{val_2}"
#           #   puts "val_1-val_2 : #{val_1-val_2}"
#           # end
#         # end
#       end
#       # container.html.style('gridTemplateColumns', '1fr 1fr 1fr 1fr 1fr 1fr')
#       container.html.style('gridTemplateColumns', 'repeat(4, 1fr)')
#       container.html.style('gridTemplateRows', 'auto')
#       container.html.style('gridGap', '10px')
#       container.html.style('display', 'grid')
#       container.on(:resize) do |event|
#         puts event[:dx]
#       end
#       container.resize({ min: { width: 10, height: 10 }, max: { width: 300, height: 700 } }) do |event|
#         puts event
#       end
#     end
#   end
# end
# new({ particle: :visible })
# new({ renderer: :html, method: :visible }) do |params|
#   if params == false
#     params = :none
#   elsif params == true
#     params = :block
#   end
#   html.visible(params)
# end
# new({ particle: :position }) do
# end
# new({ method: :position, type: :integer, renderer: :html }) do |params|
#   html.style(:position, params)
# end
#
# b = box({ color: :red })
#
# b.touch(true) do
#   # b.display({ mode: :list, data: :particles, width: 333, items: { width: 200, height: 33 }, height: 33, margin: 5 })
#   b.display({ mode: :list, data: :particles, items: { width: 200, height: 33 }, height: 33, margin: 5 })
# end
# ############## Builder #############
# c = circle({ left: 333 })
# fake_array = []
# i = 0
# while i < 32 do
#   fake_array << i
#   i += 1
# end
# c.touch(true) do
#   c.display({ mode: :grid, data: fake_array,width: 333, height: 333 })
# end
# ############# Generator #############
# gen = generator({ id: :genesis, build: { top: 66, copies: 1 } })
# gen.build({ id: :bundler, copies: 32, tag: { group: :to_grid }, color: :red, width: 33, height: 44, left: 123, smooth: 9, blur: 3, attach: [:view] })
# grab(:bundler_1).color(:blue)
#
# color({ id: :the_orange, red: 1, green: 0.4 })
#
# atome_to_grid = tagged({ group: :to_grid })
# the_group = group({ collected: atome_to_grid })
#
# the_group.touch(true) do |i|
#   color(:green)
# end
# # wait 0.3 do
# the_group.left(633)
# wait 1 do
#   grab(:view).display({ mode: :grid, data: fake_array })
# end
# #
#
#
#
#


#############
new({ atome: :generator }) do |params|
  # we remove build and store it in a temporary particle  as it has to be added after atome creation
  build = params.delete(:build)
  params[:temporary] = { build: build }
end
new({ post: :generator }) do |params|
  build_plans = params[:temporary][:build]
  # alert  build_plans
  # grab(params[:id]).build(build_plans)
end

new ({ particle: :build, store: false }) do |params|
  # we get the id or generate it for the new builder
  if params[:id]
    byild_id = params[:id]
  else
    byild_id = "auto_build_#{Universe.atomes.length}"
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
  #
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
    # alert copied_items_params
    copy = Atome.new(copied_items_params)
    copy.attach(copied_items_params[:attach])
    copy.apply([color_found.id])
    copy.left(((copy.width + left_pos) * item_number) + left_pos)
    copy.top(((copy.height + top_pos) * item_number) + top_pos)
    atomes[params[:id]] << bundle_id
  end
end


def duplicate(ids)
  ids.each do |id_passed|

    atome_passed=grab(id_passed)
    # atome_passed.particles.delete(:left)
    # we remove attached
    particle_to_remove=[:id, :broadcast, :history,:callback, :html_object, :store_allow,:attached]
    particles_found=atome_passed.particles.dup
    particles_found.delete_if { |key, value| particle_to_remove.include?(key) }
    particles_found[:id]=identity_generator(particles_found[:type])
    collected_particles={}
    particles_found.each  do |particle_found, value_found|
      collected_particles[particle_found]=value_found
    end
    ordered_keys = [:renderers, :id, :type, :attach]
    ordered_particles = ordered_keys.map { |k| [k, collected_particles[k]] }.to_h

    other_part = collected_particles.reject { |k, _| ordered_keys.include?(k) }
    # merge the parts  to obtain an re-ordered hash
    ordered_particles = ordered_particles.merge(other_part)

    # alert ordered_particles
    nw_atome= Atome.new(ordered_particles)

    wait 2 do
      nw_atome.left(333)
    end
    # Atome.new({"renderers"=>["html"], "id"=>nil, "type"=>"shape", "attach"=>["view"], "tag"=>{}, "attached"=>["text_15"], "unit"=>{}, "collected"=>{}, "width"=>99, "height"=>99, "apply"=>["box_color"], "left"=>100, "top"=>100, "clones"=>[], "preset"=>{"box"=>{"width"=>99, "height"=>99, "apply"=>["box_color"], "left"=>100, "top"=>100, "clones"=>[]}}, "touch"=>{"tap"=>true}, "touch_code"=>{"touch"=>:jhjh}})
    # Atome.new({"renderers"=>["html"], "id"=>:jgjhg, "type"=>"shape", "attach"=>["view"], "tag"=>{}, "attached"=>["text_15"], "unit"=>{}, "collected"=>{}, "width"=>99, "height"=>99, "apply"=>["box_color"], "left"=>100, "top"=>100, "clones"=>[], "preset"=>{"box"=>{"width"=>99, "height"=>99, "apply"=>["box_color"], "left"=>100, "top"=>100, "clones"=>[]}}, "touch"=>{"tap"=>true}, "touch_code"=>{"touch"=>:jhjh}})
  end
end

b=box
c=b.circle
c.text(:hello)
b.touch(true) do
  puts @id
end
b.clones([{ left: 300, top: 300, color: :blue, entangled: [:width, :attached, :height] },
          { left: 600, top: 366, color: :green, entangled: [:left, :height] }])

# duplicate([b.id])


# Atome.new( { renderers: [:html], attach: [:view],id: :my_test_box, type: :shape, apply: [:shape_color],
#              left: 120, top: 0, width: 100, smooth: 15, height: 100, overflow: :visible, attached: [], center: true
#            })
# model={shape}

gen = generator({ id: :genesis, build: {top: 66, copies: 1} })
# gen.build({ id: :bundler, copies: 32, color: :red, width: 33, height: 44,  left: 123, smooth: 9, blur: 3, attach: [:view] })
# grab(:bundler_1).color(:blue)