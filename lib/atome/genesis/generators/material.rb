# frozen_string_literal: true

new({ particle: :red }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :green }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :blue }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :alpha }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :diffusion }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :visual })
new({ particle: :overflow })
new({ particle: :edit })
new({ particle: :style })
new({ pre: :style }) do |styles_send, _user_proc|
  styles_send.each do |particle_send, value|
    send(particle_send, value)
  end
end
new({ particle: :hide })

new({ particle: :remove }) do |particle_to_remove|
  case particle_to_remove
  when :color
    send(particle_to_remove, :black)
  when :shadow
    # TODO : code to write
    puts 'code to write'
  else
    particle_to_remove_decision(particle_to_remove)
  end
end
new({ particle: :classes }) do |value|
  Universe.classes[value] ||= []
  Universe.classes[value] |= [id]
end
new({ particle: :remove_classes }) do |value|
  # Universe.classes.delete(value)
  Universe.classes[value].delete(id)
end
new ({particle: :opacity})


# vector shape
new({particle: :definition})

new({ browser: :definition, type: :string }) do |value, _user_proc|
  # alert "value is #{value}"
  target=id
  `

var divElement =  document.querySelector('#'+#{target});;

// select the first svg tag inside the div
var svgElement = divElement.querySelector('svg');

// delete the first svg tag inside the div if it exist
if (svgElement) {
  divElement.removeChild(svgElement);
}


  let svg_content='<svg style="width: 1em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg">'+#{value}+'</svg>'
       let svgContainer = document.getElementById(#{target});
        let parser = new DOMParser();
        let svgDoc = parser.parseFromString(svg_content, "image/svg+xml");
        let importedSVG = svgDoc.getElementsByTagName("svg")[0];
        importedSVG.style.width =  "100%";
        importedSVG.style.height =  "100%";
        let elements = importedSVG.getElementsByTagName("path");

        svgContainer.appendChild(importedSVG);

`

end
