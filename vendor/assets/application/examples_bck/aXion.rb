#  frozen_string_literal: true



c=circle

c.touch(true) do


  # c.message({data: {prompt: "cherche un fichier qui se nomme  capture  et ouvre le avec  l'application par defaut" , user_key: 'user_key'},  action: :axion }) do |result|
  #   puts  "my command return: #{result}"
  # end

  # c.message({data: { prompt: "liste moi tous les fichiers et dossiers que tu trouve", user_key: 'user_key' },  action: :axion }) do |result|
  #   puts  "my command return: #{result}"
  # end

  A.message({data: {prompt: "il faudrait ecrire un texte de remerciement pour un service en rendu addressé a mr albert et mettre ce texte dans un fchier, et ouvre le " , user_key: 'user_key'},  action: :axion }) do |result|
    puts  "my command return: #{result}"
  end

  {} #must add an empty hash else events events method will interpret keys of the hash and send a missing method errors
end

def speech_to_text(silenceDuration,silenceThreshold, enableTranslation, targetLanguage, convert, open_ai_key, translationCallback, audio2textCallback)
  js_func(:speechToText, silenceDuration,silenceThreshold, enableTranslation, targetLanguage, convert, open_ai_key, translationCallback, audio2textCallback)
end
#speech to text:


def translation_method(val)
  text(val)
end
def to_text_method(val)
  # alert val
  A.message({data: {prompt: val , user_key: 'user_key'},  action: :axion }) do |result|
    puts  "my command return: #{result}"
  end
end
# atomeJsToRuby('box');
speech_to_text(3000, 5, true, 'en', true,'user_key' , 'translation_method','to_text_method' )

#