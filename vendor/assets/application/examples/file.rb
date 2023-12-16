#  frozen_string_literal: true

# ############## Wasm version #############
#
#
# def create_file_browser
#   # Créer un élément div
#   div_element = JS.global[:document].createElement("div")
#   div_element[:style][:width] = "33px"
#   div_element[:style][:height] = "33px"
#   div_element[:style][:backgroundColor] = "rgba(255,0,0,0.3)"
#   div_element[:style][:position] = "absolute"
#   div_element[:style][:top] = "0px"
#   div_element[:style][:left] = "0px"
#   div_element[:id] = "monDiv"
#
#   # Créer un élément input pour la sélection de fichiers
#   input_element = JS.global[:document].createElement("input")
#   input_element[:type] = "file"
#   input_element[:style][:position] = "absolute"
#   input_element[:style][:display] = "none"
#   input_element[:style][:width] = "0px"
#   input_element[:style][:height] = "0px"
#
#   # Gérer la sélection de fichiers
#   input_element.addEventListener("change") do |native_event|
#     event = Native(native_event)
#     file = event[:target][:files][0]
#     if file
#       puts "file requested: #{file[:name]}"
#       # Lire le contenu du fichier
#       file_reader = JS.global[:FileReader].new
#       file_reader.addEventListener("load") do |load_event|
#         file_content = load_event[:target][:result]
#         puts "Content of the file: #{file_content}"
#       end
#       file_reader.readAsText(file)
#     end
#   end
#
#   # Gérer l'événement mousedown sur l'élément div
#   div_element.addEventListener("mousedown") do |event|
#     input_element.click
#   end
#
#   # Ajouter les éléments à la vue
#   view_div = JS.global[:document].querySelector("#view")
#   view_div.appendChild(input_element)
#   view_div.appendChild(div_element)
# end
#
# # Appeler la méthode pour créer le navigateur de fichiers
# create_file_browser
#
#
################ Opal version ###################
class Atome
  class << self

    def opal_file_handler(parent, callback, content)

      puts parent
      puts callback
      puts content

    end
    end

end
call_back_method='my_meth'
parent='view'
input = %x{ document.createElement('input') }
%x{ #{input}.type = 'file'; }

%x{
  #{input}.addEventListener('change', function(event) {
    var file = event.target.files[0];
    var reader = new FileReader();

    reader.onloadstart = function() {
      console.log("Load start");
    };

    reader.onprogress = function(e) {
      console.log("Loading: " + (e.loaded / e.total * 100) + '%');
    };

    reader.onload = function(e) {
      var content = e.target.result;
Opal.Atome.$opal_file_handler('#{parent}','#{call_back_method}',content )

      //console.log("File content:", content);
    };

    reader.onloadend = function() {
      console.log("Load end");
    };

    reader.onerror = function() {
      console.error("Error reading file");
    };

    reader.readAsText(file);
  });
}

view_div = %x{ document.getElementById('view') }
%x{ #{view_div}.appendChild(#{input}); }






