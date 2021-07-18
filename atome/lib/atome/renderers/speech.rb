# render methods
module RenderSpeech
  include SpeechHelpers
  include SpeechProcessor
  include SpeechProperty
  include JSUtils

  def get_language
    if self.language
      self.language
    else
      grab(:view).language
    end
  end
end