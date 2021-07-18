module SpeechProperty
  def render_speech(value)
    # say("create something maybe need to send type here : ")
    # language_found= if self.language
    #                    self.language
    #                  else
    #                    grab(:view).language
    #                  end
    type_of_creation = if preset
                         preset
                       else
                         type
                       end
    render_prop = {
      french: "une #{type_of_creation} vient d'être créée",
      english: "a #{type_of_creation} just been created",
      chinese: "a #{type_of_creation} just been created"
    }

    if value
      say ({ content: render_prop[get_language], voice: get_language})
    end

  end
end