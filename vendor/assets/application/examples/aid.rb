# frozen_string_literal: true


# aid is used to provide an unique and persistent id for any atome
b=box({ left: 12, id: :the_first_box })

puts " atome aid is : #{b.aid}"
wait 1 do
  hook(b.aid).color(:red)
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "aid"
  ],
  "aid": {
    "aim": "The `aid` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `aid`."
  }
}
end
