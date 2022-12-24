# frozen_string_literal: true

generator = Genesis.generator

generator.build_atome(:audio) do |p|
  puts p

end

generator.build_render(:browser_audio) do |_value, _user_proc|
  @browser_type = :div
  id_found = @atome[:id]
  DOM do
    audio({ id: id_found, autoplay: false, loop: false, muted: false }).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]


  # `
  # var helloWorld = new Wad({
  #     source: './medias/audios/Binrpilot.mp3',
  #
  #     // add a key for each sprite
  #     sprite: {
  #         hello : [0, .4], // the start and end time, in seconds
  #         world : [.4,1]
  #     }
  # });
  # `



end

generator.build_sanitizer(:audio) do |params|
  parent_found = found_parents_and_renderers[:parent]
  render_found = found_parents_and_renderers[:renderers]
  default_params = { renderers: render_found, id: "audio_#{Universe.atomes.length}", type: :audio,
                     parents: parent_found }
  default_params.merge!(params)
end

module BrowserHelper
  def self.browser_path_audio(value, browser_object, _atome)
    browser_object[:src] = value
  end


end

box({ id: :mybox })

my_audio = audio({ path: 'medias/audios/Binrpilot.mp3', id: :audio3 }) do |params|
  puts "3 - audio callback here #{params}, id is : #{id}"
end

# my_audio.clips[{begin: 4, end: 6}]
alert Universe.atome_list


# `
# function BufferLoader(context, urlList, callback) {
#   this.context = context;
#   this.urlList = urlList;
#   this.onload = callback;
#   this.bufferList = new Array();
#   this.loadCount = 0;
# }
#
# BufferLoader.prototype.loadBuffer = function(url, index) {
#   // Load buffer asynchronously
#   var request = new XMLHttpRequest();
#   request.open("GET", url, true);
#   request.responseType = "arraybuffer";
#
#   var loader = this;
#
#   request.onload = function() {
#     // Asynchronously decode the audio file data in request.response
#     loader.context.decodeAudioData(
#       request.response,
#       function(buffer) {
#         if (!buffer) {
#           alert('error decoding file data: ' + url);
#           return;
#         }
#         loader.bufferList[index] = buffer;
#         if (++loader.loadCount == loader.urlList.length)
#           loader.onload(loader.bufferList);
#       },
#       function(error) {
#         console.error('decodeAudioData error', error);
#       }
#     );
#   }
#
#   request.onerror = function() {
#     alert('BufferLoader: XHR error');
#   }
#
#   request.send();
# }
#
# BufferLoader.prototype.load = function() {
#   for (var i = 0; i < this.urlList.length; ++i)
#   this.loadBuffer(this.urlList[i], i);
# }
#
#
# window.onload = init;
# var context;
# var bufferLoader;
#
# function init() {
#     context = new AudioContext();
#
#     bufferLoader = new BufferLoader(
#     context,
#     [
#         'medias/audios/snare.wav',
#         'medias/audios/cowbell.wav',
#     ],
#     finishedLoading
#     );
#
#     bufferLoader.load();
# }
#
# function finishedLoading(bufferList) {
#     // Create two sources and play them both together.
#     var source1 = context.createBufferSource();
#     var source2 = context.createBufferSource();
#     source1.buffer = bufferList[0];
#     source2.buffer = bufferList[1];
#
#     source1.connect(context.destination);
#     source2.connect(context.destination);
#     source1.noteOn(0);
#     source2.noteOn(0);
# }
# `
#
#
#########################################
# `
# const el = document.getElementById("mybox")
# function modifyText(){
#  var audio = new Audio('medias/audios/snare.wav');
# audio.play(2);
# }
# el.addEventListener("mousedown", modifyText, false);
# `
# b=box({left: 160})
# b2=box({left: 333})
# b.touch(:down) do
#   `
# var audio = new Audio('medias/audios/Binrpilot.mp3');
# audio.currentTime=12
# audio.play(2);
# console.log('ok')
# `
# end
#########################################

# b2.touch(:down) do
# #   `
# #   let bell= new Audio('medias/audios/snare.wav');
# #
# # `
# end
# generator = Genesis.generator

# b.touch(:double) do
#   # alert :kool
#   #
#   `
#    let bell = new Audio('medias/audios/snare.wav');
# bell.play();
#   `
#
#   b.color(:red)
#
# #   `
# #   var audio = new Audio('medias/audios/snare.wav');
# # //audio.play();
# # //let bell = new Wad({sin : audio});
# # let bell = audio
# # //bell.play();
# # //bell.stop();
# #
# # //////
# #
# # var helloWorld = new Wad({
# #    // source: 'medias/audios/snare.wav',
# #  var audio = new Audio('medias/audios/snare.wav'),
# #    source: 'medias/audios/snare.wav',
# #     // add a key for each sprite
# #     sprite: {
# #         hello : [0, .4], // the start and end time, in seconds
# #         world : [.4,1]
# #     }
# # });
# #
# # // for each key on the sprite object in the constructor above, the wad that is created will have a key of the same name, with a play() method.
# # helloWorld.hello.play();
# # helloWorld.world.play();
# #
# # // you can still play the entire clip normally, if you want.
# # helloWorld.play();
# #
# # // if you hear clicks or pops from starting and stopping playback in the middle of the clip, you can try adding some attack and release to the envelope.
# # helloWorld.hello.play({env:{attack: .1, release:.02}})
# # `
# end
# b=box
# b.touch(:down) do
#   `
# Wad.audioContext
# `
# end

# `
# //let saw = new Wad({source : 'sawtooth'});
# let saw = new Wad({
#     source        : 'sawtooth',
#     panning       : [0, 1, 10],
#     panningModel  : 'HRTF',
#     rolloffFactor : 3 // other properties of the panner node can be specified in the constructor, or on play()
# })
# saw.play();
#`