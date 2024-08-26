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
  a_label = but.text({ data: label, component: { size: 9 }, center: true, position: :absolute })

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
  def roller_play(idf)
    idf = "#{idf}_roller"
    JS.eval("document.getElementById('#{idf}').play(pianorollCallback);")
  end

  def roller_stop(idf)
    idf = "#{idf}_roller"
    JS.eval("document.getElementById('#{idf}').stop(pianorollCallback);")
  end

  def roller_tempo(idf, tempo)
    idf = "#{idf}_roller"
    JS.eval("setTempo('#{idf}', #{tempo})")
  end
end

roller({ id: :roller })

button({ label: :play, id: :player, top: :auto, bottom: 0 }) do
  if @on
    roller_play('roller')
  else
    roller_stop('roller')
  end
end


 slider({ orientation: :vertical, range: { color: :white }, value: 55, width: 18, height: 199, attach: :intuition,
              left: 900, top: 3, color: :red, cursor: { color: { alpha: 1, red: 0.12, green: 0.12, blue: 0.12 },
                                                        width: 9, height: 6, smooth: 3 } }) do |value|
  A.roller_tempo('roller', value*3)
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