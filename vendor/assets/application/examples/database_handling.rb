# frozen_string_literal: true

A.message({ action: :insert, data: { table: :security, particle: :email, data: 'jeezs@jeezs.net' } })
A.message({ action: :insert, data: { table: :security, particle: :name, data: 'jeezs' } }) do |data_received_from_server|
  puts "mon action 1 #{data_received_from_server}"
end
A.message({ action: :query, data: { table: :identity } }) do |data_received_from_server|
  puts "mon action 2 : #{data_received_from_server}"
end
A.message({ action: :query, data: { table: :identity } }) do |data_received|
  puts "received : #{data_received}"
end

A.message({ action: :insert, data: { table: :security, particle: :name, data: 'jeezs' } }) do |ll|
  puts "=> #{ll}"
end

A.message({ action: :insert, data: { table: :security, particle: :name, data: 'jeezs' } }) do |ll|
  puts 'last message received'
end
