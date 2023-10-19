# frozen_string_literal: true

A.read('Cargo.toml') do |data|
  text "file content  :\n #{data}"
end

# if Atome.host == 'tauri'
#   JS.eval("readFile('atome','Cargo.toml')")
# else
#   puts 'nothing here'
# end