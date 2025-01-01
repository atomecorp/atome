# frozen_string_literal: true

b=box({right: 45, left: :auto})
b.css[:style][:border] = '2px solid yellow'
puts  b.css[:style][:border]
puts b.css
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "css"
  ],
  "css": {
    "aim": "The `css` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `css`."
  }
}
end
