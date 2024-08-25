# frozen_string_literal: true
p=box({id: :the_roller, width: 900, height: 333, color: :orange})

  JS.eval("aRoll('proll','the_roller', #{p.width}, #{p.height})")

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
wait 2 do
  JS.eval("document.getElementById('proll').play(pianorollCallback);")
end

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