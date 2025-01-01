# frozen_string_literal: true


# works only in native for now
A.read('Cargo.toml') do |data|
  text "file content  :\n #{data}"
end

# if Atome.host == 'tauri'
#   JS.eval("readFile('atome','Cargo.toml')")
# else
#   puts 'nothing here'
# end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "eval",
    "host",
    "read",
    "toml"
  ],
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "host": {
    "aim": "The `host` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `host`."
  },
  "read": {
    "aim": "The `read` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `read`."
  },
  "toml": {
    "aim": "The `toml` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `toml`."
  }
}
end
