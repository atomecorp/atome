#  frozen_string_literal: true

# matrix
new({ particle: :display, render: false }) do |params|
  # alert type
  unless params[:items]
    params[:items] = { width: 200, height: 33 }
  end
  container_width = params[:width] ||= width
  container_height = params[:heigth] ||= height
  container_top = params[:top] ||= top
  container_left = params[:left] ||= left

  item_width = params[:items][:width] ||= 400
  item_height = params[:items][:height] ||= 50
  item_margin = params[:margin] ||= 3

  mode = params[:mode]

  ################# i've locked the code below using unset
  # mode=:unset
  ################# i've locked the code below unsing unset

  case mode
  when :none
  when :custom
  when :list
    if params[:data].instance_of? Array
    elsif params[:data] == :particles
      list_id = "#{id}_list"
      unless grab(list_id)
        # particles_to_alter = params[:original]
        # particles_to_alter.each do |particle_found, value|
        #   send(particle_found, value)
        # end
        container = ''
        attach.each do |parent|
          container = grab(parent).box({ id: list_id,left: container_left,top: container_top, width: container_width, height: container_height, overflow: :auto, color: :black, depth: 0 })
          container.on(:resize) do |event|
            puts event[:dx]
          end
          container.resize({ min: {width: 100, height: 100} , max:{width: 300, height: 700}}) do |event|
            puts event
          end

        end
        sorted_particles = particles.sort.to_h
        sorted_particles.each_with_index do |(particle_found, value), index|
            line = container.box({ id: "#{list_id}_#{index}", width: item_width, height: item_height, left: 0, top: ((item_height + item_margin) * index) })
            line.text({ data: "#{particle_found} : ", top: -item_height / 2, left: 2 })
            if value.instance_of?(String) || value.instance_of?(Symbol) || value.instance_of?(Integer)
              input_value = line.text({ data: value, top: -item_height / 2, left: 5, edit: true })
              input_value.keyboard(:down) do |native_event|
                event = Native(native_event)
                if event[:keyCode].to_i == 13
                  event.preventDefault()
                  input_value.color(:red)
                end
              end
              input_value.keyboard(:up) do |native_event|
                data_found = input_value.data
                send(particle_found, data_found)
              end
            else
              puts "value is :#{value.class} => #{value}"
            end
        end
        closer = container.circle({id: "#{list_id}_closer", width: 33, height: 33, top: 3, right: 3, color: :red, position: :sticky })
        closer.touch(true) do
          container.delete(true)
        end
      end
    else
    end
  when :grid
    grid_id = "#{id}_grid"
    unless grab(grid_id)
      container = ''
      attach.each do |parent|
        container = grab(parent).box({ id: grid_id, width: container_width, height: container_height, overflow: :auto, color: :white, depth: 0 })
      end
      params[:data].each_with_index do |item, index|
        item= container.box({id: "#{grid_id}_#{index}", top: 0,  position: :relative, left: nil, right: nil})
        item.touch(true) do
          alert "container : #{container.id}"
          container.delete(true)
          # visible(true)
        end
      end
      # container.html.style('gridTemplateColumns', '1fr 1fr 1fr 1fr 1fr 1fr')
      container.html.style('gridTemplateColumns', 'repeat(4, 1fr)')
      container.html.style('gridTemplateRows', 'auto')
      container.html.style('gridGap', '10px')
      container.html.style('display', 'grid')
      container.on(:resize) do |event|
        puts event[:dx]
      end
      container.resize({ min: {width: 10, height: 10} , max:{width: 300, height: 700}}) do |event|
        puts event
      end
    end
  end
end
new({ particle: :visible })
new({ renderer: :html, method: :visible }) do |params|
  if params == false
    params = :none
  elsif params == true
    params = :block
  end
  html.visible(params)
end
new({particle: :position}) do
end
new({ method: :position, type: :integer, renderer: :html }) do |params|
  html.style(:position, params)
end

b = box({ color: :red })

b.touch(true) do
  # b.display({ mode: :list, data: :particles, width: 333, items: { width: 200, height: 33 }, height: 33, margin: 5 })
  b.display({ mode: :list, data: :particles, items: { width: 200, height: 33 }, height: 33, margin: 5 })
end
############## Builder #############
c = circle({ left: 333 })
fake_array=[]
i=0
while i < 32 do
  fake_array << i
  i+=1
end
c.touch(true) do
  c.display({ mode: :grid, data: fake_array})
end
############## Generator #############
gen = generator({ id: :genesis, build: {top: 66, copies: 1} })
gen.build({ id: :bundler, copies: 32,  tag: {group: :to_grid},color: :red, width: 33, height: 44,  left: 123, smooth: 9, blur: 3, attach: [:view] })
grab(:bundler_1).color(:blue)

color({ id: :the_orange, red: 1, green: 0.4 })

atome_to_grid =  tagged({group: :to_grid })
the_group = group({ collected: atome_to_grid })

the_group.touch(true) do |i|
  color(:green)
end
# wait 0.3 do
  the_group.left(633)
wait 1 do
  # the_group.display({ mode: :grid, data: fake_array})
end
# alert the_group.inspect
  # wait 0.5 do
  #   the_group.rotate(23)
  #   wait 0.5 do
  #     the_group.apply([:the_orange])
  #     the_group.blur(6)
  #   end
  # end
# end
