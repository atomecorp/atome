# frozen_string_literal: true


data_f = %w[initiate suspect prospect abandoned finished archived]

d_d_l = box({ id: :the_ddl, width: 160 })
d_d_l.touch(:down) do
  grab(:view).drop_down({ data: data_f, }) do |params|
    d_d_l.clear(true)
    d_d_l.text(params)
  end
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "clear",
    "text",
    "touch"
  ],
  "clear": {
    "aim": "The `clear` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `clear`."
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
