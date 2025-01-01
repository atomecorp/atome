# frozen_string_literal: true

new(molecule: :roller) do |params = {}|
  roller_id = params[:id] ||= identity_generator
  roller = box({ id: roller_id, width: 900, height: 333, color: :orange })
  JS.eval("aRoll('#{roller_id}_roller','#{roller_id}', #{roller.width}, #{roller.height})")
  roller
end
new({ molecule: :button }) do |params, bloc|
  but = box({ smooth: 6, shadow: { alpha: 0.3 }, width: 25, height: 25, color: :red })
  but.shadow({ alpha: 0.6, left: -3, top: -3, blur: 3, invert: true })
  label = params.delete(:label) || 'button'
  idf_f = params.delete(:id) || identity_generator
  but.text({id: idf_f, data: label, component: { size: 9 }, center: true, position: :absolute })

  but.instance_variable_set('@on', true)
  but.set(params)

  def code_logic(but, bloc)
    but.instance_exec(&bloc) if bloc.is_a?(Proc)
    if but.instance_variable_get('@on') == true
      but.instance_variable_set('@on', false)
    else
      but.instance_variable_set('@on', true)
    end
  end

  but.touch(true) do
    code_logic(but, bloc)
  end
  but
end

def roll_playback_verif(val)
  puts val
end

class Atome
  def roller_play(idf, callback, &bloc)
    idf = "#{idf}_roller"
    puts "create a 'ruby_method' on the fly and make RBevalL('ruby_method(ev)')"
    JS.eval <<~JS
      globalThis.#{callback} = function(ev) {
         console.log(ev);
          console.log('------');
      };
    JS
    JS.eval("document.getElementById('#{idf}').play(#{callback});")
  end

  def roller_stop(idf)
    idf = "#{idf}_roller"
    JS.eval("document.getElementById('#{idf}').stop();")
  end

  def roller_tempo(idf, tempo)
    idf = "#{idf}_roller"
    JS.eval("setTempo('#{idf}', #{tempo})")
  end
end

roller({ id: :roller, callback: :roll_playback_verif })

button({ label: :play, id: :player, top: :auto, bottom: 0 }) do
  if @on
    roller_play('roller', 'pianorollCallback') do |note|
      puts 'super'
    end
  else
    roller_stop('roller')
  end
end

slider({ orientation: :vertical, range: { color: :white }, value: 55, width: 18, height: 199, attach: :intuition,
         left: 900, top: 3, color: :red, cursor: { color: { alpha: 1, red: 0.12, green: 0.12, blue: 0.12 },
                                                   width: 9, height: 6, smooth: 3 } }) do |value|
  A.roller_tempo('roller', value * 3)
end

#  case "xrange":
#         document.getElementById("proll").xrange=k.value*timebase;
#         break;
#     case "xoffset":
#         document.getElementById("proll").xoffset=k.value*timebase;
#         break;
#     case "yrange":
#         document.getElementById("proll").yrange=k.value;
#         break;
#     case "yoffset":
#         document.getElementById("proll").yoffset=k.value;
#         break;
#     }

# <button onclick="setTempo('proll')">set tempo</button>
# <button onclick="play()">Play</button>
# <button onclick="stop()">Stop</button>
# <button onclick="changeEditMode('proll','dragmono')">Drag Mono</button>
# <button onclick="changeEditMode('proll','dragpoly')">Drag Poly</button>
# <button onclick="AddNote('proll')">Add Note</button>
# <button onclick="setMarkStart('proll')">set start marker</button>
# <button onclick="setMarkEnd('proll')">set end marker</button>
# <button onclick="playHead('proll')">Move play head</button>
# <button onclick="menu('proll')">menu</button>
# <button onclick="editing('proll')">edit/select</button>
# <button onclick="group('proll')">group</button>
# <button onclick="notes('proll')">notes list</button>
# <button onclick="selectAll('proll')">select all</button>
# <button onclick="deSelectAll('proll')">de-select all</button>
# <button onclick="deleteSelectedNotes('proll')">delete selection</button>
# <button onclick="marker('proll')">marker</button>
# <button onclick="removeMarker('proll')">remove marker</button>
# <button onclick="removeAllMarkers('proll')">remove all markers</button>

# JS.eval <<~JS
#           var actx, osc, gain;
#
#         function init_audio() {
#             timebase = 16;
#             actx = new AudioContext();
#             osc = actx.createOscillator();
#             gain = actx.createGain();
#             gain.gain.value = 0;
#             osc.type = "sawtooth";
#             osc.start();
#             osc.connect(gain).connect(actx.destination);
#         }
#
#
#         function Callback(ev) {
#             const currentTime = actx.currentTime;
#             const startTime = currentTime + (ev.t - performance.now() / 1000);
#             const endTime = currentTime + (ev.g - performance.now() / 1000);
#             osc.detune.setValueAtTime((ev.n - 69) * 100, startTime);
#             gain.gain.setTargetAtTime(0.5, startTime, 0.005);
#             gain.gain.setTargetAtTime(0, endTime, 0.1);
#         }
#
#         function play() {
#             gain.connect(actx.destination);
#             actx.resume().then(() => {
#                 console.log('Audio context resumed');
#             });
#             document.getElementById("proll").play(Callback);
#         }
#
#         function stop() {
#             gain.disconnect();
#             actx.suspend().then(() => {
#                 console.log('Audio context suspended');
#             });
#             document.getElementById('proll').stop()
#         }
# JS

#    <script>
#         var actx, osc, gain;
#
#         function init_audio() {
#             timebase = 16;
#             actx = new AudioContext();
#             osc = actx.createOscillator();
#             gain = actx.createGain();
#             gain.gain.value = 0;
#             osc.type = "sawtooth";
#             osc.start();
#             osc.connect(gain).connect(actx.destination);
#         }
#
#
#         function Callback(ev) {
#             const currentTime = actx.currentTime;
#             const startTime = currentTime + (ev.t - performance.now() / 1000);
#             const endTime = currentTime + (ev.g - performance.now() / 1000);
#             osc.detune.setValueAtTime((ev.n - 69) * 100, startTime);
#             gain.gain.setTargetAtTime(0.5, startTime, 0.005);
#             gain.gain.setTargetAtTime(0, endTime, 0.1);
#         }
#
#         function play() {
#             gain.connect(actx.destination);
#             actx.resume().then(() => {
#                 console.log('Audio context resumed');
#             });
#             document.getElementById("proll").play(Callback);
#         }
#
#         function stop() {
#             gain.disconnect();
#             actx.suspend().then(() => {
#                 console.log('Audio context suspended');
#             });
#             document.getElementById('proll').stop()
#         }
#     </script>
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "005",
    "1",
    "12",
    "3",
    "5",
    "6",
    "connect",
    "createGain",
    "createOscillator",
    "currentTime",
    "delete",
    "destination",
    "detune",
    "disconnect",
    "eval",
    "g",
    "gain",
    "getElementById",
    "height",
    "instance_exec",
    "instance_variable_get",
    "instance_variable_set",
    "is_a",
    "log",
    "n",
    "now",
    "resume",
    "roller_tempo",
    "set",
    "shadow",
    "start",
    "suspend",
    "t",
    "text",
    "touch",
    "type",
    "value",
    "width"
  ],
  "005": {
    "aim": "The `005` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `005`."
  },
  "1": {
    "aim": "The `1` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `1`."
  },
  "12": {
    "aim": "The `12` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `12`."
  },
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "5": {
    "aim": "The `5` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `5`."
  },
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
  "createOscillator": {
    "aim": "The `createOscillator` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `createOscillator`."
  },
  "currentTime": {
    "aim": "The `currentTime` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `currentTime`."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "destination": {
    "aim": "The `destination` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `destination`."
  },
  "detune": {
    "aim": "The `detune` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `detune`."
  },
  "disconnect": {
    "aim": "The `disconnect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `disconnect`."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "g": {
    "aim": "The `g` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `g`."
  },
  "gain": {
    "aim": "The `gain` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `gain`."
  },
  "getElementById": {
    "aim": "The `getElementById` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getElementById`."
  },
  "height": {
    "aim": "The `height` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `height`."
  },
  "instance_exec": {
    "aim": "The `instance_exec` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `instance_exec`."
  },
  "instance_variable_get": {
    "aim": "The `instance_variable_get` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `instance_variable_get`."
  },
  "instance_variable_set": {
    "aim": "The `instance_variable_set` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `instance_variable_set`."
  },
  "is_a": {
    "aim": "The `is_a` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `is_a`."
  },
  "log": {
    "aim": "The `log` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `log`."
  },
  "n": {
    "aim": "The `n` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `n`."
  },
  "now": {
    "aim": "The `now` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `now`."
  },
  "resume": {
    "aim": "The `resume` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `resume`."
  },
  "roller_tempo": {
    "aim": "The `roller_tempo` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `roller_tempo`."
  },
  "set": {
    "aim": "The `set` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `set`."
  },
  "shadow": {
    "aim": "The `shadow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shadow`."
  },
  "start": {
    "aim": "The `start` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `start`."
  },
  "suspend": {
    "aim": "The `suspend` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `suspend`."
  },
  "t": {
    "aim": "The `t` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `t`."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "type": {
    "aim": "The `type` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `type`."
  },
  "value": {
    "aim": "The `value` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `value`."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
