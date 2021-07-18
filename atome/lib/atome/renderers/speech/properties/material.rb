module SpeechProperty
  def color_speech(params )
    render_prop = {
      french: "sa couleur est  #{params}",
      english: "it's color is  #{params}",
      chinese:  "it's color is  #{params}"
    }
      say ({ content: render_prop[get_language], voice: get_language})
  end

  def overflow_speech(params )
    render_prop = {
      french: "L'overflow est   #{params}",
      english: "Overflow is  #{params}",
      chinese:  "Overflow is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end
end