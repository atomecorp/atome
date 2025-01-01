# frozen_string_literal: true

user_password = {global: :all_star, read: { atome: :all_star }, write: { atome: :all_star } }

human({ id: :jeezs, login: true, password: user_password, data: { birthday: '10/05/2016' },selection: [], tag: { system: true } , attach: :user_view })

c = box({ color: :yellow, left: 333 })
c.touch(true) do
  c.message({data: 'cd ..;cd server;ls; pwd', action: :terminal }) do |result|
    puts "shell command return: #{result}"
  end
  c.message({data: {source: 'capture.rb',operation: :read  }, action: :file}) do |result|

    puts "file read encoded_content: #{result[:data].gsub('\x23', '#')}"
  end
  c.message({ action: :file,data: {source: 'user_created_file.rb', operation: :write, value: :hello }})do |result|
    puts "file creation result : #{result}"
  end

  A.message({ action: :terminal , data: 'cd ..;cd server;ls; pwd'}) do |result|
    puts "result : #{result}"
  end
  {} #must add an empty hash else events events method will interpret keys of the hash and send a missing method errors
end
#

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "message",
    "rb",
    "touch"
  ],
  "message": {
    "aim": "The `message` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `message`."
  },
  "rb": {
    "aim": "The `rb` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `rb`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
