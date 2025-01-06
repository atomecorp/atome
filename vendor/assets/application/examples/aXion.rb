#  frozen_string_literal: true


t=text({left: 80,data:  "il faudrait ecrire un texte de remerciement pour un service en rendu addressé a mr albert et mettre ce texte dans un fchier, et ouvre le fichier", edit: true })
c1=circle({color: :yellowgreen})
c1.text(:test)
c1.touch(true) do
  c1.color(:red)
  wait 0.1 do
    c1.color(:yellowgreen)
  end

  # c.message({data: {prompt: "cherche un fichier qui se nomme  capture  et ouvre le avec  l'application par defaut" , user_key: :my_key},  action: :axion }) do |result|
  #   puts  "my command return: #{result}"
  # end

  # c.message({data: { prompt: "liste moi tous les fichiers et dossiers que tu trouve", user_key: :my_key },  action: :axion }) do |result|
  #   puts  "my command return: #{result}"
  # end

  A.message({data: {prompt: t.data , user_key: :my_key},  action: :axion }) do |result|
    puts  "my command return: #{result}"
  end

  {} #must add an empty hash else events events method will interpret keys of the hash and send a missing method errors
end

def speech_to_text(silenceDuration,silenceThreshold, enableTranslation, targetLanguage, convert, open_ai_key, translationCallback, audio2textCallback, active)
  js_func(:speechToText, silenceDuration,silenceThreshold, enableTranslation, targetLanguage, convert, open_ai_key, translationCallback, audio2textCallback, active)
end


def translation_method(val)
  text(val)
end
def to_text_method(val)
  A.message({data: {prompt: val , user_key: :my_key},  action: :axion }) do |result|
    puts  "my command return: #{result}"
  end
end
c=circle({left: 190, top: 50})
c.text(:start)
c2=circle({left: 190, top: 120, color: :red})
c2.text(:stop)
c.touch(true) do
  speech_to_text(3000, 5, true, 'de', true,:my_key , 'translation_method','to_text_method', true )
end

c2.touch(true) do
  speech_to_text(3000, 5, true, 'en', true,:my_key , 'translation_method','to_text_method', false )
end


def api_infos
  {
    "example": "Purpose of the example",
    "methods_found": [
      "message",
      "touch"
    ],
    "message": {
      "aim": "The `message` method's purpose is determined by its specific functionality.",
      "usage": "Refer to Atome documentation for detailed usage of `message`."
    },
    "touch": {
      "aim": "Handles touch or click events to trigger specific actions.",
      "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
    }
  }
end
