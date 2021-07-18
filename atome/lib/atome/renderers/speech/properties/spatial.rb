module SpeechProperty
  def x_speech(params )
    render_prop = {
      french: "sa position horizontale est   #{params}",
      english: "It's horizontal position is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end
  def y_speech(params )
    render_prop = {
      french: "La position vertical est   #{params}",
      english: "It's vertical position is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end
  def z_speech(params )
    render_prop = {
      french: "La position sur l'axe de profondeur est   #{params}",
      english: "It's depth position is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end
end