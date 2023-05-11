# frozen_string_literal: true
repeat 0.3, 10 do |evt|
  alert :ok
  puts "hello:#{evt}:"
end

