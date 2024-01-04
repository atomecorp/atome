# frozen_string_literal: true

user_password = {global: :all_star, read: { atome: :all_star }, write: { atome: :all_star } }

human({ id: :jeezs, login: true, password: user_password, data: { birthday: '10/05/2016' },selection: [], tag: { system: true } , attach: :user_view })



b = box({ color: :red, id: :my_box })
b.connection('localhost:9292') do |params|
  alert " the connection is : #{params}"
end
b.touch(true) do
  b.connection('localhost:9292') do |params|
    alert " the connection is : #{params}"
  end
end

c = box({ color: :yellow, left: 333 })

c.touch(true) do
  b.message({message: 'cd ..;cd server;ls; pwd', action: :terminal })
  b.message({message: 'capture.rb', action: :file, option: :read })
  b.message({message: 'tototo.rb', action: :file, option: :write, value: :hello })
  # b.message({message: 'cd ..;cd server;ls; pwd'})
  # c = box({ color: :red, left: 333 })
end