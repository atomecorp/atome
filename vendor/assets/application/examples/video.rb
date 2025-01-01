# frozen_string_literal: true

if Universe.internet
  v = video({ path: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" })
else
  v = video(:video_missing)
end

v.touch(true) do
  v.play(true)
  wait 3 do
    v.play(66)
  end
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "googleapis",
    "internet",
    "mp4",
    "play",
    "touch"
  ],
  "googleapis": {
    "aim": "The `googleapis` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `googleapis`."
  },
  "internet": {
    "aim": "The `internet` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `internet`."
  },
  "mp4": {
    "aim": "The `mp4` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `mp4`."
  },
  "play": {
    "aim": "The `play` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `play`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
