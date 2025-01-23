#  frozen_string_literal: true


# caling a js methode
js_func(:js_test, :super)

# using class
my_class_instance=js_class(:my_test_class)
my_class_instance.myTestFunction("Hello from Ruby!")
# to call a ruby methode from js use :
#       atomeJsToRuby('box'); or  atomeJsToRuby("my_meth('my_params')")
#

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "myTestFunction"
  ],
  "myTestFunction": {
    "aim": "The `myTestFunction` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `myTestFunction`."
  }
}
end
