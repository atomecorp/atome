#  frozen_string_literal: true
#
# # audio tag
a = audio({ path: 'medias/audios/clap.wav', id: :audioElement })
b=box({id: :playButton})
b.text(:audio_tag)
a.left(333)
b.touch(:down) do
  a.play(true)
end


#
#
### Web Audio
# Initialisation des variables globales
@audio_context = JS.eval('return new AudioContext()')
@audio_element = JS.global[:document].getElementById('audioElement')
@track = @audio_context.createMediaElementSource(@audio_element)

# Ajout d'un nœud de gain (volume)
@gain_node = @audio_context.createGain()
@gain_node[:gain][:value] = 0.5  # Réduit le volume à 50%
#
# # Connexion de la chaîne
@track.connect(@gain_node)  # Connecte la source au nœud de gain
@gain_node.connect(@audio_context[:destination])  # Connecte le nœud de gain à la sortie

def play_audio
  # Réactive l'AudioContext s'il est suspendu
  @audio_context[:resume].to_s if @audio_context[:state].to_s == 'suspended'
  # Joue l'audio
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
init_code = "window.snare = new Wad({source : 'medias/audios/clap.wav'});"
JS.eval(init_code)

# Code JavaScript pour jouer le son et l'arrêter après 300 ms, dans un bloc indépendant
play_code = <<~STRDEL
  window.snare.play();
  setTimeout(function() {
    window.snare.stop();
  }, 300);
STRDEL

# Exécution du bloc indépendant pour jouer et arrêter le son
# JS.eval(play_code)
# snare=JS.eval("return new Wad({source : 'medias/audios/clap.wav'})")
# js_code=<<STRDEL
#      snare = #{snare};
#   snare =new Wad({source : 'medias/audios/clap.wav'})
#   snare.play();
#   setTimeout(() => {
#   snare.stop();
#   }, "300");
# STRDEL
bb.touch(:down) do
  JS.eval(play_code)
end

