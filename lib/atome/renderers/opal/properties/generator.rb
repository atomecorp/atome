# frozen_string_literal: true

# opal render methods here
module OpalRenderer
  def render_html(params, &proc)
    puts "----puts render render #{params}"
  end

  def id_html(params, &proc)
    puts "----puts render id_html #{params}"
  end

  def left_html(params, &proc)
    puts "----puts render left_html #{params}"
  end

  def right_html(params, &proc)
    puts "----puts render right_html #{params}"
  end

  def top_html(params, &proc)
    puts "----puts render top_html #{params}"
  end

  def bottom_html(params, &proc)
    puts "----puts render bottom_html #{params}"
  end

  def red_html(params, &proc)
    puts "----puts render red_html #{params}"
  end
  def green_html(params, &proc)
    puts "----puts render green_html #{params}"
  end
  def blue_html(params, &proc)
    puts "----puts render blue_html #{params}"
  end
  def alpha_html(params, &proc)
    puts "----puts render alpha_html #{params}"
  end

  def drm_html(params, &proc)
    puts "----puts render drm_html #{params}"
  end

  def parent_html(params, &proc)
    puts "----puts render parent_html #{params}"
  end

  def width_html(params, &proc)
    puts "----puts render width_html #{params}"
  end
  def height_html(params, &proc)
    puts "----puts render height_html #{params}"
  end
  def type_html(params, &proc)

    # puts ":::::: the params is #{params} , proc is #{proc}"
    send("#{params}_html",&proc)
#
#     `function addElement (width) {
#   // crée un nouvel élément div
#   var newDiv = document.createElement("div");
#   // et lui donne un peu de contenu
#   var newContent = document.createTextNode('Hi there and greetings!');
#   // ajoute le nœud texte au nouveau div créé
#   newDiv.appendChild(newContent);
#   newDiv.id='div1';
#
#   // ajoute le nouvel élément créé et son contenu dans le DOM
#   var currentDiv = document.getElementById('div1');
#   document.body.insertBefore(newDiv, currentDiv);
# }
#
# addElement();
#
#
#  var selectedRow = document.querySelector('div#div1');
#  selectedRow.style.color = 'black';
#   selectedRow.style.backgroundColor = 'orange';`

#     js_code=<<STRDELIM
# `function addElement (width) {
#   // crée un nouvel élément div
#   var newDiv = document.createElement("div");
#   // et lui donne un peu de contenu
#   var newContent = document.createTextNode('Hi there and greetings!');
#   // ajoute le nœud texte au nouveau div créé
#   newDiv.appendChild(newContent);
#   newDiv.id='div1';
#
#   // ajoute le nouvel élément créé et son contenu dans le DOM
#   var currentDiv = document.getElementById('div1');
#   document.body.insertBefore(newDiv, currentDiv);
# }
#
# addElement();
#
#
#  var selectedRow = document.querySelector('div#div1');
#  selectedRow.style.color = 'black';
#   selectedRow.style.backgroundColor = 'orange';`
# STRDELIM
#     puts js_code
  end


  def shape_html( &proc)
    # @html_object= `document.createElement('div')`
    puts "::::::: setting specific options for shape atome"
  end

  def color_html( &proc)
    puts "::::::: setting specific options for color atome"
  end

end
