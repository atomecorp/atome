# frozen_string_literal: true

# new(application: {name: :compose })
# new(application:  :compose ) do |params|
#   alert params
# end
s=application({ name: :home })

# alert s.class
# alert "a.class : #{a.class}"
s.page(:hello)
# grab(:toto).color(:cyan)
#
# def layout
#   compose_back=box
#
#   compose_back.color({ alpha: 0 })
#   media_reader=compose_back.box({left: 99, width: 250, height: 250, top: 99})
#   viewer_1=compose_back.box({left: 360, width: 250, height: 250, top: 99})
#   viewer_2=compose_back.box({left: 690, width: 250, height: 250, top: 99})
#   timeline=compose_back.box({left: 99, width: 250, height: 250, top: 399})
#   login=compose_back.text(:log)
#   login.touch(true) do
#     compose_back.delete(true)
#     # grab(:view).clear(true)
#     form
#   end
#
# end
#
# def form
#   form1=box
#   form1.text(:login)
#
#   form1.touch(true) do
#     form1.delete(true)
#     layout
#   end
#
# end
# form

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "box",
    "class",
    "color",
    "delete",
    "page",
    "text",
    "touch"
  ],
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "class": {
    "aim": "The `class` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `class`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "page": {
    "aim": "The `page` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `page`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
