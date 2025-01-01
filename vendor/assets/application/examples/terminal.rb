# frozen_string_literal: true
A.terminal('pwd') do |data|
  text "terminal response  :\n #{data}"
end

# alert A.inspect
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "inspect",
    "terminal"
  ],
  "inspect": {
    "aim": "The `inspect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `inspect`."
  },
  "terminal": {
    "aim": "The `terminal` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `terminal`."
  }
}
end
