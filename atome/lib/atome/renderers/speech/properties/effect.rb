module SpeechProperty
  def smooth_speech(params )
    render_prop = {
      french: "l'adoucissement  est de   #{params}",
      english: "Smoothing is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end
end