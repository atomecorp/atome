#  frozen_string_literal: true

# support=box({top: 250, left: 12, width: 300, height: 40, smooth: 9, color:{red: 0.3, green: 0.3, blue: 0.3}, id: :support })
#
# support.shadow({
#                  id: :s3,
#                  left: 3, top: 3, blur: 9,
#                  invert: true,
#                  red: 0, green: 0, blue: 0, alpha: 0.7
#                })
def create_file_browser
  div_element = JS.global[:document].createElement("div")

  # Définir les propriétés CSS de l'élément div
  div_element[:style][:width] = "33px"        # Taille: largeur de 100 pixels
  div_element[:style][:height] = "33px"       # Taille: hauteur de 100 pixels
  div_element[:style][:backgroundColor] = "rgba(255,0,0,0.3)"  # Couleur de fond rouge
  div_element[:style][:position] = "absolute"  # Positionnement absolu
  div_element[:style][:top] = "0px"           # Position par rapport au haut de l'écran
  div_element[:style][:left] = "0px"          # Position par rapport à la gauche de l'écran

  # Définir un ID pour l'élément div
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
      # support.controller({ action: :loadProject,  params: { path: file[:name]} })
    end
  end
  div_element.addEventListener("mousedown") do |event|
    # Déclenchez manuellement un clic sur l'input
    input_element.click
  end
  view_div = JS.global[:document].querySelector("#view")

  view_div.appendChild(input_element)
  view_div.appendChild(div_element)

end

create_file_browser
