#  frozen_string_literal: true

# audio tag
a = audio({ path: 'medias/audios/clap.wav', id: :basic_audio })
b=box({id: :playButton})
b.text(:audio_tag)
a.left(333)
b.touch(:down) do
  a.play(true)
end



### Web Audio
 audio({ path: 'medias/audios/clap.wav', id: :audioElement })
@audio_context = JS.eval('return new AudioContext()')
@audio_element = JS.global[:document].getElementById('audioElement')
@track = @audio_context.createMediaElementSource(@audio_element)

@gain_node = @audio_context.createGain()
@gain_node[:gain][:value] = 0.5

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
init_code = "window.snare = new Wad({source : 'medias/audios/clap.wav'});"
JS.eval(init_code)

play_code = <<~STRDEL
  window.snare.play();
  setTimeout(function() {
    window.snare.stop();
  }, 300);
STRDEL


bb.touch(:down) do
  JS.eval(play_code)
end

