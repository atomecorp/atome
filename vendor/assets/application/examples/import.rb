# frozen_string_literal: true

support = box({ top: 250, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 }, id: :support })

support.shadow({
                 id: :s3,
                 left: 3, top: 3, blur: 9,
                 invert: true,
                 red: 0, green: 0, blue: 0, alpha: 0.7
               })



box({ id: :the_boxy })

def importer_test(content)
  filename=content[:filename]
  text ("title: \n\n#{content[:filename]}")
  text ("\n\ncontent: \n\n#{content[:content]}")
  puts "add code here, content:  #{content}"
  case File.extname(filename).downcase
  when ".mp3", ".wav", ".ogg", ".aac", ".flac", ".m4a"
    puts "===> audio case"
  when ".txt"
    puts "===> text case"
  when ".lrx"
    puts "===> lrx case"


  when ".lrs"
    puts "===> lrs case"
  else
    puts "===> else case"
  end
end

#imort can have exeption look below how it works:
#   def importer(target = :all, &proc)
#     if target == :all
#       importer_all(&proc)
#     else
#       exception_import(target, &proc)
#     end
#   end
support.import(true) do |content|
  importer_test(content)
end


importer() do |val|
  puts "case drop anyware #{val}"
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
