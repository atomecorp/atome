# frozen_string_literal: true

# dummies html objects :

#object 1
div_rouge = JS.global[:document].createElement( "div")

div_rouge[:style][:backgroundColor] = "red"
div_rouge[:style][:width] = "100px"
div_rouge[:style][:height] = "100px"
div_rouge.setAttribute('id', "my_div")
div_view = JS.global[:document].getElementById('view')
div_view.appendChild(div_rouge)


#object 2
span_bleu =  JS.global[:document].createElement( "span")
span_bleu[:style][:backgroundColor] = "blue"
span_bleu[:innerHTML] = "blue"
span_bleu[:style][:width] = "10px"
span_bleu[:style][:height] = "8px"
div_rouge.appendChild(span_bleu)


#object 2
span_white =  JS.global[:document].createElement( "h1")
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



def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "appendChild",
    "color",
    "display",
    "global",
    "join",
    "left",
    "locate",
    "position",
    "rotate",
    "setAttribute",
    "to_a",
    "top"
  ],
  "appendChild": {
    "aim": "The `appendChild` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `appendChild`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "display": {
    "aim": "The `display` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `display`."
  },
  "global": {
    "aim": "The `global` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `global`."
  },
  "join": {
    "aim": "The `join` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `join`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "locate": {
    "aim": "The `locate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `locate`."
  },
  "position": {
    "aim": "The `position` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `position`."
  },
  "rotate": {
    "aim": "The `rotate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `rotate`."
  },
  "setAttribute": {
    "aim": "The `setAttribute` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `setAttribute`."
  },
  "to_a": {
    "aim": "The `to_a` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_a`."
  },
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
  }
}
end
