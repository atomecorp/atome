# # frozen_string_literal: true
b=box

b.touch(:down) do
   A.message({ action: :authentication, data: { table: :user, particles: { email: 'tre@tre.tre', password: 'poipoi' } } }) do |response|
    alert "=> #{response}"
  end
end

#
#
# # # 1 login attempt

wait 1 do
  A.message({ action: :authentication, data: { table: :user, particles: { email: 'tre@tre.tre', password:  'poipoi' } } }) do |response|
    alert "=> #{response}"
  end
  wait 1 do
    A.message({ action: :authentication, data: { table: :user, particles: { email: 'tre@tre.tre', password:  'poipoi' } } }) do |response|
      alert "=> #{response}"
    end
  end
end
#
# 2 account creation attempt
# wait 1 do
#   A.message({ action: :account_creation, data: { email: 'tre@tre.tre', password: 'poipoi', user_id: 'Nico' }  }) do |response|
#     puts response
#   end
#
# end

# string=hello
#
# puts JS.global.sha256(string.to_s)

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "global",
    "message",
    "to_s",
    "touch",
    "tre"
  ],
  "global": {
    "aim": "The `global` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `global`."
  },
  "message": {
    "aim": "The `message` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `message`."
  },
  "to_s": {
    "aim": "The `to_s` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_s`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "tre": {
    "aim": "The `tre` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `tre`."
  }
}
end
