# frozen_string_literal: true

A.read('Cargo.toml') do |data|
  text "file content  :\n #{data}"
end
wait 1 do # to be sure the server is ready
  A.read('../application/examples/blur.rb') do |data|
    text "file content  :\n #{data}"
  end
end
