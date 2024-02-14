# # frozen_string_literal: true
#
# A.message({ action: :insert, data: { table: :security, particle: :password, data: 'my_pass'} }) do |datas|
#   puts "0 data received:  #{datas}"
# end
#
# A.message({ action: :insert, data: { table: :identity, particle: :name, data: 'jeezs' } }) do |data_received_from_server|
#   puts "1 my first insert #{data_received_from_server}"
# end
#
# A.message({ action: :insert, data: { table: :identity, particle: :name, data: 'jeezs2' } })
#
# A.message({ action: :query, data: { table: :identity } }) do |data_received_from_server|
#   puts "2 another insert  : #{data_received_from_server}"
# end
#
# A.message({ action: :query, data: { table: :identity } }) do |data_received|
#   puts "3 received : #{data_received}"
# end
#
# A.message({ action: :insert, data: { table: :identity, particle: :name, data: 'jeezs3' } }) do |result|
#   puts "4 insert done : #{result}"
# end
#
# A.message({ action: :insert, data: { table: :identity, particle: :name, data: 'jeezs4' } }) do |result|
#   puts "5 last message received: #{result}"
# end
#
# A.message({ action: :insert, data: { table: :security, particle: :name, data: 'john doe' } }) do |data_received_from_server|
#   puts "6 test 1 : #{data_received_from_server}"
# end
#
# A.message({ action: :insert, data: { table: :identity, particle: :tit, data: 'dummy' } }) do |data_received_from_server|
#   puts "7 test 2 :  #{data_received_from_server}"
# end
#
# A.message({ action: :insert, data: { table: :unknown, particle: :name, data: 'dummy2' } }) do |data_received_from_server|
#   puts "test 3 :  #{data_received_from_server}"
# end