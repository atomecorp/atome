module SpeechProperty
  def width_speech(params )
    render_prop = {
      french: "La largeur est   #{params}",
      english: "Width is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end
  def height_speech(params )
    render_prop = {
      french: "La hauteur est   #{params}",
      english: "height is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end

  def size_speech(params )
    render_prop = {
      french: "La taille est   #{params}",
      english: "the size is  #{params}",
    }
    say ({ content: render_prop[get_language], voice: get_language})
  end
end

