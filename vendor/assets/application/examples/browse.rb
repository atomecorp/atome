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
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "browse",
    "eval",
    "host",
    "terminal_callback",
    "toml"
  ],
  "browse": {
    "aim": "The `browse` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `browse`."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "host": {
    "aim": "The `host` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `host`."
  },
  "terminal_callback": {
    "aim": "The `terminal_callback` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `terminal_callback`."
  },
  "toml": {
    "aim": "The `toml` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `toml`."
  }
}
end
