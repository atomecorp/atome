#  frozen_string_literal: true

# see import for drag and drop import
b = box({ drag: true })
b.import(true) do  |content|
  puts "add code here, content:  #{content}"
end










def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "import"
  ],
  "import": {
    "aim": "The `import` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `import`."
  }
}
end
