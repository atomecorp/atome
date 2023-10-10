#  frozen_string_literal: true

puts "current user: #{Universe.current_user}"
human({ id: :jeezs, login: true })

puts "current user: #{Universe.current_user}"
wait 2 do
  human({ id: :toto, login: true })
  puts "current user: #{Universe.current_user}"
end