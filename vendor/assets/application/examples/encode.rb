#  frozen_string_literal: true

my_pass = Black_matter.encode('hello')
puts my_pass
checker = Black_matter.check_password('hello,', my_pass)
puts checker
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "check_password",
    "encode"
  ],
  "check_password": {
    "aim": "The `check_password` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `check_password`."
  },
  "encode": {
    "aim": "The `encode` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `encode`."
  }
}
end
