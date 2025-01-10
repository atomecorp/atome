# frozen_string_literal: true
wait 2 do
  puts :start
  repeat 0.3, 10 do |evt|
    # alert :ok
    puts "hello:#{evt}:"
  end
  puts :inited
end


