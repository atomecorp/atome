# frozen_string_literal: true

b = box

16.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45), top: 0, category: :matrix })
end


Universe.user_atomes.each do |atome_id|
  atome_found = grab(atome_id)
  if atome_found.type == :shape
    atome_found.color(:orange)
    atome_found.smooth(200)
    atome_found.top(200)
  end
end

random_found =Universe.user_atomes.sample(7)
random_found.each do |atome_id|
  atome_found = grab(atome_id)
  if atome_found.type == :shape
    atome_found.top(rand(600))
    atome_found.width(rand(120))
    atome_found.height(rand(120))
    atome_found.smooth(rand(120))
    atome_found.color(:red)
  end
end

random_found =Universe.user_atomes.sample(9)
random_found.each do |atome_id|
  atome_found = grab(atome_id)
  if atome_found.type == :shape
    atome_found.left(rand(700))
    atome_found.width(rand(120))
    atome_found.height(rand(120))
    atome_found.smooth(rand(120))
    atome_found.color(:blue)
  end
end
