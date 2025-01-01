# frozen_string_literal: true

a = box
a.code(:hello) do
  circle({ left: 333, color: :orange })
end
wait 1 do
  a.run(:hello)
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "code",
    "run"
  ],
  "code": {
    "aim": "The `code` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `code`."
  },
  "run": {
    "aim": "The `run` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `run`."
  }
}
end
