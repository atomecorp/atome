# frozen_string_literal: true


# browse only works with  application version of atome or using server mode , it allow the browse local file on your computer or remote file on server, if operating in server mode

# here is an example :
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