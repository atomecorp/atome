# frozen_string_literal: true

b = box
c = circle
t = text('touch me')

b.copy([c.id, b.id, t.id])
b.copy(b.id)

wait 1 do
  c.paste([0, 2])
  wait 1 do
    t.paste(0)
  end

end

t.touch(true) do
  copies = t.paste(0)
  copies.each do |atome_paste|
    wait 1 do
      grab(atome_paste).color(:red)
    end
  end
end

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "copy",
    "each",
    "id",
    "paste",
    "touch"
  ],
  "copy": {
    "aim": "The `copy` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `copy`."
  },
  "each": {
    "aim": "The `each` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `each`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "paste": {
    "aim": "The `paste` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `paste`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
