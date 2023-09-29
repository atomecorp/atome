# frozen_string_literal: true
# Drop
b=box({id: :droper})
b.drop(true) do |drop_ob_id|
  puts "id received : #{drop_ob_id[:id]}"
  drop_obj=grab(drop_ob_id[:id])
  if drop_obj.type == :image
    grab(:view).image({ path: drop_obj.path , drag: true,  width: 120, left: 222, top: 222})
  end

end

image({path: "./medias/images/green_planet.png", left: 333, top: 33, drag: true})

#
b.over(:enter) do |event|
  b.color(:red)
end

b.over(:leave) do |event|
  b.color(:blue)
end


c=circle({ color: :orange, top: 333, id: :the_c_2 })
c.drag(true)