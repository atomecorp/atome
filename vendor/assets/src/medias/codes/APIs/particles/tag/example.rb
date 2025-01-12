# frozen_string_literal: true

b=box
b.circle({left: 0, top: 0, tag: {group: :to_grid}})
b.box({left: 120, top: 120, tag: {group: :from_grid}})
b.circle({left: 240, top: 240,  tag: {group: :from_grid}})
b.box({left: 330, top: 330,tag: {group: :to_grid}})
b.box({left: 330, top: 600,tag: :no_tag})


wait 1 do
  tagged(:group).each do |atome_id|
    grab(atome_id).color(:green)
    wait 1 do
      tagged({group: :to_grid }).each do |atome_id|
        grab(atome_id).color(:blue)
      end
    end
  end
end




