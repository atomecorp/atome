#  frozen_string_literal: true

# matrix
new({ particle: :display, render: false }) do |params|
  unless params[:items]
    params[:items] = { width: 200, height: 33 }
  end
  container_width = params[:width] ||= 555
  container_height = params[:width] ||= 555
  item_width = params[:items][:width] ||= 400
  item_height = params[:items][:height] ||= 50
  item_margin = params[:margin] ||= 3
  mode = params[:mode]

  case mode
  when :none
  when :custom
  when :list
    if params[:data].instance_of? Array
    elsif params[:data] == :particles
      list_id = "#{id}_list"
      unless grab(list_id)
        particles_to_alter = params[:original]
        particles_to_alter.each do |particle_found, value|
          send(particle_found, value)
        end
        container = ''
        attach.each do |parent|
          container = grab(parent).box({ id: list_id, width: container_width, height: container_height, overflow: :auto, color: :black, depth: 0 })
        end
        sorted_particles = particles.sort.to_h
        sorted_particles.each_with_index do |(particle_found, value), index|
            line = container.box({ id: "#{list_id}_#{index}", width: item_width, height: item_height, left: 0, top: ((item_height + item_margin) * index) })
            line.text({ data: "#{particle_found} : ", top: -item_height / 2, left: 2 })
            if value.instance_of?(String) || value.instance_of?(Symbol) || value.instance_of?(Integer)
              # alert particle_value
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
      particles_to_alter = params[:original]
      particles_to_alter.each do |particle_found, value|
        send(particle_found, value)
      end
      container = ''
      attach.each do |parent|
        container = grab(parent).box({ id: grid_id, width: container_width, height: container_height, overflow: :auto, color: :white, depth: 0 })
      end
      params[:data].each_with_index do |item, index|
        item= container.box({id: "#{grid_id}_#{index}", top: 0,  position: :relative, left: nil, right: nil})
        item.touch(true) do
          container.delete(true)
          visible(true)
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
      container.resize(true) do |event|
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
# original properties allow to modify particles of the current atome
# items properties allow to modify particles of cloned or newly generated atomes
# wait 2 do
#   alert "Before : #{b.inspect}"
#   b.display({mode: :list , original: {visible: true, left: 0, top: 0}})
#   alert "after : #{b.inspect}"
# end
# wait 2 do
#   b.visible(false)
# end
# b.display({ mode: :table, target: :particles, structure: {row: 2, column: 8, width: 333, height: 444} , items: {width: :auto,height: 66, rotate: 12 }})

# wait 2 do
#   b.display(:none)
# end
b.touch(true) do
  b.display({ mode: :list, data: :particles, width: 333, items: { width: 200, height: 33 }, height: 33, margin: 5, original: { visible: true, left: 0, top: 0 } })
end

c = circle({ left: 333 })

fake_array=[]
i=0
while i < 32 do
  fake_array << i
  i+=1
end
c.touch(true) do
  c.display({ mode: :grid, data: fake_array, original: { visible: false } })
end

# TODO : find how to restore natural display after removing display mode
alert "color on text "
