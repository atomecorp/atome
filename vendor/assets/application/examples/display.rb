#  frozen_string_literal: true


# matrix
new({ particle: :display }) do |params|
  unless params.instance_of? Hash
    params = { mode: params, target: :atomes }
  end
  target_found = params[:target]
  particles_to_alter=params[:original]
  particles_to_alter.each do |particle_found, value|
    send(particle_found, value)
  end

  mode = params[:mode]
  case mode

  when :none
  when :custom

  when :list
      default_width=333
      default_height=30
      margin=3
      container=''
      attach.each do |parent|
        container=grab(parent).box({width: default_width, height: default_height*3, overflow: :auto, color: :white, depth: 0})
      end
      particles.each_with_index  do |(particle_found,value), index|
        line=container.box({width: default_width, height: default_height, left: 0, top:((default_height+margin)*index)})
        line.text({ data: "#{particle_found} : ", top: -default_height / 2, left: 2 })
        input_value=line.text({ data: value, top: -default_height / 2 , left: 5, edit: true})
        input_value.keyboard(:down) do |native_event|
          event = Native(native_event)
          if event[:keyCode].to_i == 13
            event.preventDefault()
            input_value.color(:red)
          end
        end
        input_value.keyboard(:up) do |native_event|
          data_found= input_value.data
          # alert   "grab(#{id}).send(#{particle_found},#{data_found})"
         send(particle_found,data_found)
        end
      end
  when :table

  end
end
new({particle: :visible})
new({renderer: :html,method: :visible}) do |params|
  if params== false
    params= :none
  elsif params== true
    params= :block
  end
  html.display(params)
end
b = box({color: :red})
# original properties allow to modify particles of the current atome
# items properties allow to modify particles of cloned or newly generated atomes
wait 2 do
  b.display({mode: :list , original: {visible: true, left: 0, top: 0}})
end
# wait 2 do
#   b.visible(false)
# end
# b.display({ mode: :table, target: :particles, structure: {row: 2, column: 8, width: 333, height: 444} , items: {width: :auto,height: 66, rotate: 12 }})

# wait 2 do
#   b.display(:none)
# end
b.touch(true) do
  alert.b.inspect
end

# TODO : find how to restore natural display after removing display mode


