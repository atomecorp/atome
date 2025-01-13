# frozen_string_literal: true

# Universe.language = :french

b = box({ drag: true })
A.help(:left) do
  english = [{ data: 'left particle ', color: :red, width: 333, left: 99, component: {size: 33} },
             { data: 'is used to position the atome on the x axis, click me to get an example',  width: 333 }
  ]
  french = "la particle left est utilisée  pour positionner l'atome sur l'axe x, click moi pour obtenir un exemple"

  t = text({ data:english, left: 199, top: 33})
  # t = text({ int8: { english: english, french: french },  width: 666, left: 123 })
  t.touch(true) do
    t.delete(true)
    example(:left)
  end
end
# text({data: [{data: 'hi! ', color: :green},{data: 'hello '},{data: 'beautifull ', color: :red},{data: 'world'}], color: :yellow})


  b.help(:left)

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "delete",
    "help",
    "touch"
  ],
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "help": {
    "aim": "The `help` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `help`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
