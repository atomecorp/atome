# frozen_string_literal: true
#
b=box({id: :droper})
b.drop(true) do |event_content|
  puts "reveived : #{event_content}"
  if event_content[:type]==:image
    image({ path: event_content[:data] , drag: true,  width: 120})
  end


end

b.over(true) do
  puts 'so overlooked'
end
c=circle({ color: :orange, top: 333, id: :the_c_2 })
c.drag(true)