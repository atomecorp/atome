# frozen_string_literal: true

support = box({ top: 250, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 }, id: :support })

support.shadow({
                 id: :s3,
                 left: 3, top: 3, blur: 9,
                 invert: true,
                 red: 0, green: 0, blue: 0, alpha: 0.7
               })



box({ id: :the_boxy })



support.import(true) do |content|
  puts "add code here, content:  #{content}"
end


importer do |val|
  puts "case 21 #{val}"
end

# importer(:all) do |val|
#   alert "case 21 #{val}"
# end

importer('the_boxy') do |val|
  puts "yes !!! exception found : #{val}"
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "3",
    "7",
    "import",
    "shadow"
  ],
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "7": {
    "aim": "The `7` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `7`."
  },
  "import": {
    "aim": "The `import` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `import`."
  },
  "shadow": {
    "aim": "The `shadow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shadow`."
  }
}
end
