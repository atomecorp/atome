# frozen_string_literal: true

new({molecule: :system}) do |params|
  alert Atome::host
  alert Universe.engine
end

puts "connect a midi device and run atome in native mode then look in the console"

system({message: "open 'test autoload.bwproject'"})

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "bwproject",
    "engine"
  ],
  "bwproject": {
    "aim": "The `bwproject` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `bwproject`."
  },
  "engine": {
    "aim": "The `engine` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `engine`."
  }
}
end
