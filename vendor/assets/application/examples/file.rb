#  frozen_string_literal: true
class Atome
  class << self
    def file_handler(parent, content, bloc)
      grab(parent).instance_exec(content, &bloc)
    end
  end
end

############## Wasm version #############

def create_file_browser(parent, &bloc)
  div_element = JS.global[:document].createElement("div")
  div_element[:style][:width] = "33px"
  div_element[:style][:height] = "33px"
  div_element[:style][:backgroundColor] = "rgba(255,0,0,0.3)"
  div_element[:style][:position] = "absolute"
  div_element[:style][:top] = "0px"
  div_element[:style][:left] = "0px"
  div_element[:id] = "monDiv"

  input_element = JS.global[:document].createElement("input")
  input_element[:type] = "file"
  input_element[:style][:position] = "absolute"
  input_element[:style][:display] = "none"
  input_element[:style][:width] = "0px"
  input_element[:style][:height] = "0px"

  input_element.addEventListener("change") do |native_event|
    event = Native(native_event)
    file = event[:target][:files][0]
    if file
      puts "file requested: #{file[:name]}"
      file_reader = JS.global[:FileReader].new
      file_reader.addEventListener("load") do |load_event|
        file_content = load_event[:target][:result]
        # puts "Content of the file: #{file_content}"
        Atome.file_handler(parent,file_content, bloc)
      end
      file_reader.readAsText(file)
    end
  end

  div_element.addEventListener("mousedown") do |event|
    input_element.click
  end

  # Ajouter les éléments à la vue
  view_div = JS.global[:document].querySelector("##{parent}")
  view_div.appendChild(input_element)
  view_div.appendChild(div_element)
end

create_file_browser(:view) do |file_content|
  puts "wasm ===>#{file_content}"
end


################ Opal version ###################



# def file_for_opal(parent, &bloc)
#
#   # call_back_method = 'file_callback'
#   parent='view'
#   input = %x{ document.createElement('input') }
#   %x{ #{input}.type = 'file'; }
#
#   %x{
#   #{input}.addEventListener('change', function(event) {
#     var file = event.target.files[0];
#     var reader = new FileReader();
#
#     reader.onloadstart = function() {
#       console.log("Load start");
#     };
#
#     reader.onprogress = function(e) {
#       console.log("Loading: " + (e.loaded / e.total * 100) + '%');
#     };
#
#     reader.onload = function(e) {
#       var content = e.target.result;
# Opal.Atome.$file_handler('#{parent}',content, #{bloc} )
#
#       //console.log("File content:", content);
#     };
#
#     reader.onloadend = function() {
#       console.log("Load end");
#     };
#
#     reader.onerror = function() {
#       console.error("Error reading file");
#     };
#
#     reader.readAsText(file);
#   });
# }
#
#   view_div = %x{ document.getElementById('view') }
#   %x{ #{view_div}.appendChild(#{input}); }
#
# end
#
#
# file_for_opal(:view) do |file_content|
#    puts "opal ===>#{file_content}"
# end



