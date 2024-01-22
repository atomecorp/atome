# frozen_string_literal: true

div_rouge = JS.global[:document].call(:createElement, "div")

div_rouge[:style][:backgroundColor] = "red"
div_rouge[:style][:width] = "100px"
div_rouge[:style][:height] = "100px"
div_rouge.setAttribute('id', "my_div")

div_view = JS.global[:document].getElementById('view')

div_view.appendChild(div_rouge)

span_bleu = JS.global[:document].call(:createElement, "span")

span_bleu[:style][:backgroundColor] = "blue"
span_bleu[:innerHTML] = "blue"
span_bleu[:style][:width] = "10px"
span_bleu[:style][:height] = "80px"

div_rouge.appendChild(span_bleu)

def atomize(selector, base_element = JS.global[:document][:body])
  return base_element if selector.empty?

  if selector.has_key?(:id)
    return base_element.querySelector("##{selector[:id]}")
  elsif selector.has_key?(:parent)
    parent = base_element.querySelector("##{selector[:parent]}")
    return nil if parent.nil?
    return parent.querySelectorAll("*")
  end
end

#   # Exemple d'utilisation
#   div_result = atomize(id: 'my_div') # Recherche par ID
#   alert "ID de div trouvé : #{div_result[:id]}" if div_result
#
# span_result = atomize(parent: :view)
# if span_result
#   span_result.to_a.each do |child|
#     alert "Enfant trouvé : #{child[:tagName]}"
#   end
#   span_result = atomize(parent: :view)
#   if span_result
#     enfants = span_result.to_a.map do |child|
#       "Balise: #{child[:tagName]}, ID: #{child[:id] || 'non défini'}"
#     end
#     alert "Enfants trouvés : #{enfants.join(', ')}"
#   end
# end

############ atomizer

def atomizer(params)
  unless params.instance_of? Hash
    params = { target: params }
  end
  id = params[:id]
  if id
    id_wanted = { id: id }
  else
    id_wanted = {}
  end
  basis = { alien: params[:target],renderers: [:html],  type: :atomized }.merge(id_wanted)
  a = Atome.new(basis)
  return a
  # convert any foreign object (think HTML) to a pseudo atome objet , that embed foreign objet
end

div_result = atomize(id: 'my_div') # Recherche par ID
atomized_el= atomizer({ target: div_result, id: :my_html_obj })
atomized_el.rotate(55)
atomized_el.color(:blue)
# atomized_el.display(:block)
atomized_el.position(:absolute)
atomized_el.left(255)
atomized_el.top(255)

#
#
#
#
# atomizer(:my_test_box_1_2)

# strategy get an html object , get its id or create one if none
# get its property convert this to atome particle
# create an atome apply the particles
