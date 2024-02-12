# # frozen_string_literal: true
#
A.message({ action: :insert, data: { table: :security, particle: :password, data: 'my_pass'} })

A.message({ action: :insert, data: { table: :identity, particle: :name, data: 'jeezs' } }) do |data_received_from_server|
  puts "my first insert #{data_received_from_server}"
end

A.message({ action: :query, data: { table: :identity } }) do |data_received_from_server|
  puts "another insert  : #{data_received_from_server}"
end

A.message({ action: :query, data: { table: :identity } }) do |data_received|
  puts "received : #{data_received}"
end

A.message({ action: :insert, data: { table: :identity, particle: :name, data: 'jeezs' } }) do |result|
  puts "insert done : #{result}"
end

A.message({ action: :insert, data: { table: :identity, particle: :name, data: 'jeezs' } }) do |result|
  puts "last message received: #{result}"
end
