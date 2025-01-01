# frozen_string_literal: true

if Universe.internet
  # v = video({ path: "medias/videos/avengers.mp4", id: :my_video })
  v = video({ path: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" })
else
  v = video(:video_missing)
end
v.left(200)
v.touch(true) do
  alert v.play
end

t=text({id: :my_text, data: "play video"})

t.touch(true) do
  v.data=0
  v.play(26) do |event|
    t.data("event is : #{event}")
    if event[:frame] ==  900 && v.data <3
      puts v.data
      v.data(v.data+1)
      v.play(26)
    end
  end
end

c=circle({left: 123})

c.touch(true) do
  v.play(:pause)
end

cc=circle({left: 0, width: 55, height: 55})

left=0
cc.drag(:locked) do |event|
  dx = event[:dx]
  left += dx.to_f
  min_left = 0
  max_left = 600
  left = [min_left, left].max
  left = [left, max_left].min
  v.html.currentTime(left/10)
  cc.left(left)
end


puts "add lock x and y when drag"
puts "restrict ro :view doesnt work"
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "data",
    "drag",
    "googleapis",
    "html",
    "internet",
    "left",
    "mp4",
    "play",
    "to_f",
    "touch"
  ],
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "drag": {
    "aim": "The `drag` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `drag`."
  },
  "googleapis": {
    "aim": "The `googleapis` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `googleapis`."
  },
  "html": {
    "aim": "The `html` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `html`."
  },
  "internet": {
    "aim": "The `internet` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `internet`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "mp4": {
    "aim": "The `mp4` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `mp4`."
  },
  "play": {
    "aim": "The `play` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `play`."
  },
  "to_f": {
    "aim": "The `to_f` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_f`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  }
}
end
