module SpeechProperty
  def media_speech(params )
    # say_html (params)
    speech_dsp(params)
  end

  def content_speech(params )
    render_prop = {
      french: "Le contenue est   #{params}",
      english: "The content is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end
end