#  frozen_string_literal: true


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

  case mode
  when :none
  when :custom
  when :list
    if params[:data].instance_of? Array
    elsif params[:data] == :particles
      list_id = "#{id}_list"
      unless grab(list_id)
        container = ''
        attach.each do |parent|
          container = grab(parent).box({ id: list_id, left: container_left, top: container_top, width: container_width, height: container_height, overflow: :auto, color: :black, depth: 0 })
          container.on(:resize) do |event|
            puts event[:dx]
          end
          container.resize({ min: { width: 100, height: 100 }, max: { width: 300, height: 700 } }) do |event|
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
        closer = container.circle({ id: "#{list_id}_closer", width: 33, height: 33, top: 3, right: 3, color: :red, position: :sticky })
        closer.touch(true) do
          container.delete(true)
        end
      end
    else
    end
  when :grid
    grid_id = "#{id}_grid"
    unless grab(grid_id)
      container = grab(:view).box({ id: grid_id, width: container_width, height: container_height, overflow: :auto, color: :white, depth: 0 })
      ############## deletion
      container.touch(true) do
        puts "removing container recursively : #{container.id}"
        val_1= Universe.atomes.length
        puts "val_1 : #{val_1}"
        container.delete({ recursive: true })
        val_2= Universe.atomes.length
        puts "val_2 : #{val_2}"
        puts "val_1-val_2 : #{val_1-val_2}"
      end
      ############## deletion
      params[:data].each_with_index do |item, index|
        # unless grab("#{grid_id}_#{index}")
          item = container.box({ id: "#{grid_id}_#{index}", top: 0, position: :relative, left: nil, right: nil })
          # item.touch(true) do
          #   alert "removing container recursively : #{container.id}"
          #   val_1= Universe.atomes.length
          #   puts "val_1 : #{val_1}"
          #   container.delete({ recursive: true })
          #   val_2= Universe.atomes.length
          #   puts "val_2 : #{val_2}"
          #   puts "val_1-val_2 : #{val_1-val_2}"
          # end
        # end
      end
      # container.html.style('gridTemplateColumns', '1fr 1fr 1fr 1fr 1fr 1fr')
      container.html.style('gridTemplateColumns', 'repeat(4, 1fr)')
      container.html.style('gridTemplateRows', 'auto')
      container.html.style('gridGap', '10px')
      container.html.style('display', 'grid')
      container.on(:resize) do |event|
        puts event[:dx]
      end
      container.resize({ min: { width: 10, height: 10 }, max: { width: 300, height: 700 } }) do |event|
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
new({ particle: :position }) do
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
fake_array = []
i = 0
while i < 32 do
  fake_array << i
  i += 1
end
c.touch(true) do
  c.display({ mode: :grid, data: fake_array,width: 333, height: 333 })
end
############## Generator #############
gen = generator({ id: :genesis, build: { top: 66, copies: 1 } })
gen.build({ id: :bundler, copies: 32, tag: { group: :to_grid }, color: :red, width: 33, height: 44, left: 123, smooth: 9, blur: 3, attach: :view })
grab(:bundler_1).color(:blue)

color({ id: :the_orange, red: 1, green: 0.4 })

atome_to_grid = tagged({ group: :to_grid })
the_group = group({ collected: atome_to_grid })

the_group.touch(true) do |i|
  color(:green)
end
# wait 0.3 do
the_group.left(633)
wait 1 do
  grab(:view).display({ mode: :grid, data: fake_array })
end






def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "3",
    "4",
    "atomes",
    "box",
    "build",
    "circle",
    "class",
    "color",
    "data",
    "delete",
    "display",
    "each",
    "each_with_index",
    "html",
    "id",
    "instance_of",
    "keyboard",
    "left",
    "on",
    "preventDefault",
    "resize",
    "sort",
    "style",
    "text",
    "touch",
    "visible"
  ],
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "4": {
    "aim": "The `4` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `4`."
  },
  "atomes": {
    "aim": "The `atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `atomes`."
  },
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "build": {
    "aim": "The `build` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `build`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "class": {
    "aim": "The `class` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `class`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "display": {
    "aim": "The `display` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `display`."
  },
  "each": {
    "aim": "The `each` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `each`."
  },
  "each_with_index": {
    "aim": "The `each_with_index` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `each_with_index`."
  },
  "html": {
    "aim": "The `html` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `html`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "instance_of": {
    "aim": "The `instance_of` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `instance_of`."
  },
  "keyboard": {
    "aim": "The `keyboard` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `keyboard`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "on": {
    "aim": "The `on` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `on`."
  },
  "preventDefault": {
    "aim": "The `preventDefault` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `preventDefault`."
  },
  "resize": {
    "aim": "The `resize` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `resize`."
  },
  "sort": {
    "aim": "The `sort` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `sort`."
  },
  "style": {
    "aim": "The `style` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `style`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "visible": {
    "aim": "The `visible` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `visible`."
  }
}
end
