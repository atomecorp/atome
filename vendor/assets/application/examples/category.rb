# frozen_string_literal: true

# assign a class to atom object in the webview

t=text('touch the box')
b=box({ left: 12, id: :the_first_box })
b.category(:matrix)
b.touch(true) do
  b.remove({ category: :matrix})
  t.data= " category is : #{b.category}"
  wait 1 do
    b.category(:new_one)
    t.data= " category is : #{b.category}"
  end
end
t.data= " category is : #{b.category} "

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "category",
    "data",
    "remove",
    "touch"
  ],
  "category": {
    "aim": "The `category` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `category`."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "remove": {
    "aim": "The `remove` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `remove`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
