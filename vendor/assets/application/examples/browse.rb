# frozen_string_literal: true

A.browse('/') do |data|
  text "folder content  :\n #{data}"
end

# if Atome.host == 'tauri'
#   # JS.eval("readFile('atome','Cargo.toml')")
#   JS.eval("browseFile('atome','/')")
# else
#   puts 'nothing here'
#   # JS.eval("terminal('A.terminal_callback','pwd')")
# end