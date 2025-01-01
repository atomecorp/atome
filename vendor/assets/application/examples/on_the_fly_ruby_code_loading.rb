#  frozen_string_literal: true



b=box({color: :red})
b.touch(true) do
  JS.eval('loadFeature()') # found in atome.js file
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "eval",
    "js",
    "touch"
  ],
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "js": {
    "aim": "The `js` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `js`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
