# frozen_string_literal: true

user_password = {global: :all_star, read: { atome: :all_star }, write: { atome: :all_star } }

human({ id: :jeezs, login: true, password: user_password, data: { birthday: '10/05/2016' },selection: [], tag: { system: true } , attach: :user_view })

c = circle({ color: :red, left: 333 })
c.touch(true) do
  # c.message({data: 'cd ..;cd server;ls; pwd', action: :terminal }) do |result|
  #   puts "shell command return: #{result}"
  # end
  # c.message({data: {source: 'capture.rb',operation: :read  }, action: :file}) do |result|
  #
  #   puts "file read encoded_content: #{result[:data].gsub('\x23', '#')}"
  # end
  # c.message({ action: :file,data: {source: 'user_created_file.rb', operation: :write, value: :hello }})do |result|
  #   puts "file creation result : #{result}"
  # end

  A.message({ action: :record , data: {type: :wav, duration: 5.02, name: :my_rec, path:  './'}}) do |result|
    puts "result : #{result}"
  end
end

