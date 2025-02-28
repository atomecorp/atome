# frozen_string_literal: true


def server_mode
  Atome::host.start_with?("puma-roda")
end
def test

end
# if server_mode
#
#   # we init the db file eDen
#   # A.sync({ action: :init_db, data: { database: :eDen } }) do |data|
#   #   Universe.database_ready = data[:data][:message] == 'database_ready'
#   # end
#   # now we add table to  the DB
#   A.sync({ action: :create_db_table, data: { table: :creator, type: :string } }) do |_db_state|
#   end
#   #
#   A.sync({ action: :create_db_column, data: { table: :creator, column: :login, type: :string, unique: true } }) do |_db_state|
#   end
#   # # wait 36 do
#   #   A.message({ action: :insert, data: { table: :creator, particle: :login, data: 'jeezs'} }) do |datas|
#   #     puts "0 data received:  #{datas}"
#   #   end
#
#     A.message({ action: :insert, data: { table: :creator,  particles: {left: 777, top: 555} } }) do |data_received_from_server|
#       puts "1 my first insert #{data_received_from_server}"
#     end
#   # end
# end
#puma-roda

b=box({id: :poil, aid: :poilu})
b.touch(true) do |event|
  if event == 356
    alert 'hash_filtered'
  else
    c= circle
    part= c.particles
    hash_filtered = part.reject { |key, _| ["history", "html", "headless"].include?(key) }
    alert  hash_filtered
  end
end



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
# def api_infos
#   {
#   "example": "Purpose of the example",
#   "methods_found": [
#     "message"
#   ],
#   "message": {
#     "aim": "The `message` method's purpose is determined by its specific functionality.",
#     "usage": "Refer to Atome documentation for detailed usage of `message`."
#   }
# }
# end
