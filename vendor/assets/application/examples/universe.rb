# frozen_string_literal: true

puts "atomes : #{Universe.atomes}"
puts "user_atomes : #{Universe.user_atomes}"
puts "particle_list : #{Universe.particle_list}"
puts "users : #{Universe.users}"
puts "current_machine : #{Universe.current_machine}"
puts "internet connected : #{Universe.internet}"
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "atomes",
    "current_machine",
    "internet",
    "particle_list",
    "user_atomes",
    "users"
  ],
  "atomes": {
    "aim": "The `atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `atomes`."
  },
  "current_machine": {
    "aim": "The `current_machine` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `current_machine`."
  },
  "internet": {
    "aim": "The `internet` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `internet`."
  },
  "particle_list": {
    "aim": "The `particle_list` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `particle_list`."
  },
  "user_atomes": {
    "aim": "The `user_atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `user_atomes`."
  },
  "users": {
    "aim": "The `users` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `users`."
  }
}
end
