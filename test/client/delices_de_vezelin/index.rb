require_relative '../../experimental/web'

new(particle: :keyboard)

new({ sanitizer: :keyboard }) do |params, _user_bloc|
  @keyboard = { option: {} } unless @keyboard
  if params == true
    params = :ok
  elsif params == false
  end
  params
end

new(renderer: :html, method: :keyboard) do |params|
  # alert params
end

t = text :hello
t.left(99)

t.edit(true)
t.keyboard(true) do |event|
  puts event
end
# wait 3 do
#   t.edit(false)
# end
#
# wait 6 do
#   t.delete(true)
# end
b = box
b.keyboard(true) do
  # puts 'okok'
end

# wait 4 do
#
#   b.over(false)
#   end
