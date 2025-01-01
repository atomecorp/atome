#  frozen_string_literal: true


c=circle({width: 66, height: 66})
t1=c.text({id: :first, data: 0, left: 28})

first_repeater=repeat(1, repeat = 99) do |counter|
  t1.data(counter)
end


c.touch(true) do
  stop({ repeat: first_repeater })
  t1.data(:stopped)
end


cc=circle({width: 66, height: 66, left: 90 })
t2=cc.text({id: :second, data: 0, left: 28})

# # alert first_repeater
my_repeater=repeat(1, repeat = 9) do |counter|
  t2.data(counter)
end
#

#
cc.touch(true) do
  stop({ repeat: my_repeater })
  t2.data(:stopped)
end

# use Float::INFINITY to infinite repeat
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "data",
    "text",
    "touch"
  ],
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
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
