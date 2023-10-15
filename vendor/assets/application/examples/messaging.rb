# frozen_string_literal: true
#
b = box({ color: :red })

b.touch(true) do
  b.connection('localhost:9292') do |params|
    alert " the connection is : #{params}"
  end
end

c = box({ color: :yellow, left: 333 })

c.touch(true) do
  b.message('hi there!!')
  # c = box({ color: :red, left: 333 })
end