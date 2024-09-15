# frozen_string_literal: true

new({molecule: :system}) do |params|
  alert Atome::host
  alert Universe.engine
end

puts "connect a midi device and run atome in native mode then look in the console"

system({message: "open 'test autoload.bwproject'"})
