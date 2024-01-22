# frozen_string_literal: true

# dummies html objects :

#object 1
div_rouge = JS.global[:document].call(:createElement, "div")

div_rouge[:style][:backgroundColor] = "red"
div_rouge[:style][:width] = "100px"
div_rouge[:style][:height] = "100px"
div_rouge.setAttribute('id', "my_div")
div_view = JS.global[:document].getElementById('view')
div_view.appendChild(div_rouge)


#object 2
span_bleu = JS.global[:document].call(:createElement, "span")
span_bleu[:style][:backgroundColor] = "blue"
span_bleu[:innerHTML] = "blue"
span_bleu[:style][:width] = "10px"
span_bleu[:style][:height] = "8px"
div_rouge.appendChild(span_bleu)


#object 2
span_white = JS.global[:document].call(:createElement, "h1")
span_white[:style][:color] = "white"
span_white[:innerHTML] = "Hello"
span_white[:style][:width] = "10px"
span_white[:style][:height] = "80px"
span_white[:style][:top] = "80px"
span_bleu.appendChild(span_white)


#   usage example
#   div_result =  HTML.locate(id: 'my_div') # Recherche par ID
#   alert "id found : #{div_result[:id]}" if div_result

# first_result =  HTML.locate(parent: :view)[1]
# result_found =  HTML.locate(html: first_result)
# alert result_found[0][:tagName]

# if span_result
#   span_result.to_a.each do |child|
#     alert "child found: #{child[:tagName]}"
#   end
#   enfants = span_result.to_a.map do |child|
#     "tag: #{child[:tagName]}, ID: #{child[:id] || 'non défini'}"
#   end
#   alert "children found : #{enfants.join(', ')}"
# end


wait 1 do
  div_result =  HTML.locate(parent: :view)[0]
  atomized_el= atomizer({ target: div_result, id: :my_html_obj })
  atomized_el.color(:pink)
  atomized_el.position(:absolute)
  atomized_el.left(66)
  atomized_el.top(99)
end


wait 2 do
  div_result = HTML.locate(id: 'my_div') # find by ID

  atomized_el= atomizer({ target: div_result, id: :my_second_html_obj })
  atomized_el.rotate(55)
  atomized_el.color(:purple)
  # atomized_el.display(:block)
  atomized_el.position(:absolute)
  atomized_el.left(255)
  atomized_el.top(255)
end


wait 3 do
  first_result =  HTML.locate(parent: :view)[1]
  result_found =  HTML.locate(html: first_result) # Attention  HTML.locate always return an array you have to chose
  new_atomized_el= atomizer({ target: result_found, id: :my_third_html_obj })
  new_atomized_el.display(:block)
  new_atomized_el.position(:absolute)
  new_atomized_el.rotate(12)
end


