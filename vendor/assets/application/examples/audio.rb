#  frozen_string_literal: true

# audio tag
a = audio({ path: 'medias/audios/Ices_From_Hells.m4a', id: :basic_audio })
b=box({id: :playButton})
b.text(:audio_tag)
a.left(333)
b.touch(:down) do
  a.play(17) do |val|
    puts val
  end
end
c=box({top: 70})
c.touch(:down) do
  a.play(:stop) do |val|
    puts val
  end
end

class Atome
  def method_missing(name, *args, &block)
    alert " que faire avec #{name}, #{args}, #{block}"
  end
end

cc=box({top: 130})
cc.touch(:down) do
  a.volume(0.5)
end

ccc=box({top: 170})
ccc.touch(:down) do
  alert  a.length
end


### Web Audio
 audio({ path: 'medias/audios/clap.wav', id: :audioElement })
@audio_context = JS.eval('return new AudioContext()')
@audio_element = JS.global[:document].getElementById('audioElement')
@track = @audio_context.createMediaElementSource(@audio_element)

@gain_node = @audio_context.createGain()
@gain_node[:gain][:value] = 0.6

@track.connect(@gain_node)
@gain_node.connect(@audio_context[:destination])

def play_audio
  @audio_context[:resume].to_s if @audio_context[:state].to_s == 'suspended'
  @audio_element.play
end
b2=box({left: 166})
b2.text(:web_audio)
b2.touch(:down) do
  play_audio
end


# ######### wadjs

bb=box({left: 333})
bb.text(:wadjs)



# Initialize window.snare

init_code = "window.snare = new Wad({source : 'medias/audios/clap.wav'});"
JS.eval(init_code)

# Define the JavaScript playSnare function
js_code = <<~JAVASCRIPT
  window.playSnare = function() {
    window.snare.play();
    // setTimeout(function() {
    //  window.snare.stop();
    //}, 30);
  }
JAVASCRIPT

# Evaluate the JavaScript code once
JS.eval(js_code)

# Define the Ruby method to call the JavaScript function
def play_snare
  JS.eval('window.playSnare()')
end

# Attach the method to the touch event
bb.touch(:down) do
  play_snare
end
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "6",
    "connect",
    "createGain",
    "createMediaElementSource",
    "eval",
    "global",
    "left",
    "play",
    "playSnare",
    "snare",
    "text",
    "touch",
    "wav"
  ],
  "6": {
    "aim": "The `6` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `6`."
  },
  "connect": {
    "aim": "The `connect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `connect`."
  },
  "createGain": {
    "aim": "The `createGain` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `createGain`."
  },
  "createMediaElementSource": {
    "aim": "The `createMediaElementSource` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `createMediaElementSource`."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "global": {
    "aim": "The `global` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `global`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "play": {
    "aim": "The `play` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `play`."
  },
  "playSnare": {
    "aim": "The `playSnare` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `playSnare`."
  },
  "snare": {
    "aim": "The `snare` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `snare`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "wav": {
    "aim": "The `wav` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `wav`."
  }
}
end
