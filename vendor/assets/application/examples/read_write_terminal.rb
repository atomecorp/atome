# frozen_string_literal: true


# works only in native for now
b=box
t=text({data: 'Cargo.toml', top: 99, edit: true})
b.touch(:tap) do

  A.write({name: '/Users/jean-ericgodard/my_file.txt', content: ' so cool' }) do |data|
    text "file content  :\n #{data}"
  end
  wait 3 do
    A.read('/Users/jean-ericgodard/my_file.txt') do |data|
      text "file content  :\n #{data}"
    end

    A.terminal('open /Users/jean-ericgodard/my_file.txt') do |data|
      text "terminal response  :\n #{data}"
    end
  end

end




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
