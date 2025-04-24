
class Lyricist < Atome


  # Construction de l'interface utilisateur
  def build_ui
    build_control_buttons
    build_record_button
    build_lyrics_viewer
    build_song_support
    build_editor_controls
    build_timeline_slider
    build_navigation_buttons
    build_lyrics_editor_button
  end
  def build_control_buttons

    start = grab(:view).box({ width: 33, height: 19, color: :green })
    start.text(data: :start, component: { size: 9 }, top: -12, left: 3)
    start.touch(true) do
      counter = grab(:counter)

      prev_length = @length
      counter.timer({ end: 99999999999 }) do |value|
        lyrics = grab(:lyric_viewer)
        update_lyrics(value, lyrics, counter)
        if @record && value >= @length
          @length = value
        else
          if value >= @length
            counter.timer({ stop: true })
          end
        end
        if value < prev_length
          grab(:timeline_slider).value(value)
        end
      end
    end

    # Bouton Erase
    erase = grab(:view).box({ id: :erase, width: 33, height: 19, color: :black, left: 39 })
    erase.text(data: 'erase', component: { size: 9 }, top: -12, left: 3)
    erase.touch(true) do
      clear_all
    end

    # Bouton Stop
    stop = grab(:view).box({ width: 33, height: 19, color: :blue, left: 125, id: :stop })
    stop.text(data: :stop, component: { size: 9 }, top: -12, left: 3)
    stop.touch(true) do
      counter = grab(:counter)
      counter.timer({ stop: true })
      lyrics = grab(:lyric_viewer)
      update_lyrics(0, lyrics, counter)
      grab(:timeline_slider).delete({ force: true })
      build_timeline_slider

    end

    # Bouton Pause
    pause = grab(:view).box({ width: 33, height: 19, color: :orange, left: 160 })
    pause.text(data: :pause, component: { size: 9 }, top: -12, left: 3, color: :black)
    pause.touch(true) do
      grab(:counter).timer({ pause: true })
    end

  end

  def build_record_button
    record = grab(:view).box({ width: 33, height: 19, top: 39, id: :rec_box, left: 39 })
    record.text(data: 'rec.', component: { size: 9 }, top: -12, left: 3, color: :black)
    rec_color = grab(:view).color({ id: :rec_color, red: 1, alpha: 0.6 })
    record.apply(:rec_color) # Utiliser directement record au lieu de grab(:rec_box)

    record.touch(true) do
      prev_postion = @actual_position
      lyric_viewer = grab(:lyric_viewer)
      if @record == true
        @record = false
        lyric_viewer.edit(false)
        rec_color.alpha(0.6)
        @number_of_lines = @original_number_of_lines

        # timer_found.timer[:position] = 1
        # timer_found.timer[:start] = 1
      else
        @record = true
        rec_color.alpha(1)
        lyric_viewer.edit(true)
        @number_of_lines = 1
        counter = grab(:counter)
        # counter.timer({ stop: true })
        lyrics = grab(:lyric_viewer)
        update_lyrics(0, lyrics, counter)
        # update_lyrics(0, lyrics, counter)
        # grab(:timeline_slider).delete({ force: true })
      end
      full_refresh_viewer(prev_postion)
    end
  end

  def build_lyrics_viewer
    counter = grab(:view).text({ data: :counter, content: :play, left: 60, top: 90, position: :absolute, id: :counter })
    base_text = ''

    lyrics_support = grab(:view).box({
                                       id: :lyrics_support,
                                       width: 180,
                                       height: 180,
                                       top: 120,
                                       left: 35,
                                       color: { red: 0.2, green: 0.2, blue: 0.4, id: :base_support_color }
                                     })

    lyrics_support.text({
                          top: 3,
                          left: 3,
                          width: style[:line_width],
                          # data: [{ data: base_text }],
                          data: base_text,
                          id: :lyric_viewer,
                          edit: false,
                          component: { size: 33 },
                          position: :absolute,
                          content: { 0 => base_text },
                          context: :insert
                        })

    counter.timer({ position: 88 })

    # Événements sur le viewer de paroles
    setup_lyrics_events
  end

  def setup_lyrics_events
    lyrics = grab(:lyric_viewer)

    # lyrics.touch(:down) do
    #   grab(:lyrics_support).color({ red: 1, id: :red_col })
    #   grab(:counter).content(:edit) # Empêche la mise à jour du viewer de paroles pendant la lecture
    # end

    lyrics.keyboard(:down) do |native_event|
      grab(:lyrics_support).color({ red: 1, id: :red_col })
      event = Native(native_event)
      if event[:keyCode].to_s == '13' # Touche Entrée
        grab(:lyrics_support).remove(:red_col)
        grab(:counter).content(:play) # Permet la mise à jour du viewer de paroles pendant la lecture
        event.preventDefault
        alter_lyric_event(grab(:lyric_viewer).data)
      end
    end

  end

  def build_song_support
    support = grab(:view).box({
                                overflow: :auto,
                                top: 3,
                                left: :auto,
                                right: 9,
                                width: 399,
                                height: 600,
                                smooth: 9,
                                color: { red: 0.3, green: 0.3, blue: 0.3 },
                                id: :support
                              })

    support.shadow({
                     id: :s3,
                     left: 3, top: 3, blur: 9,
                     invert: true,
                     red: 0, green: 0, blue: 0, alpha: 0.7
                   })

    # Bouton d'importation
    open_filer = text({ data: :import, top: 63, left: 6, color: :yellowgreen })
    open_filer.import(true) do |val|
      parse_song_lyrics(val)
    end

    importer do |val|
      parse_song_lyrics(val[:content])
    end
  end

  def build_editor_controls
    prev_word = grab(:view).box({ left: 220, id: :prev, width: 39, height: 20 })
    prev_word.text({ data: :prev, position: :absolute })
    next_word = grab(:view).box({ left: 270, id: :next, width: 39, height: 20 })
    next_word.text({ data: :next, position: :absolute })

    prev_word.touch(true) do
      lyrics = grab(:lyric_viewer)
      counter = grab(:counter)
      current_position = counter.timer[:position]

      # Trouver la clé qui précède la position actuelle
      sorted_keys = lyrics.content.keys.sort
      prev_index = sorted_keys.rindex { |key| key < current_position }

      if prev_index
        prev_position = sorted_keys[prev_index]
        update_lyrics(prev_position, lyrics, counter)
        grab(:timeline_slider).value(prev_position)
      else
        # Si aucune position précédente n'est trouvée, aller au début (position 0)
        update_lyrics(0, lyrics, counter)
        grab(:timeline_slider).value(0)
      end
    end

    next_word.touch(true) do
      lyrics = grab(:lyric_viewer)
      counter = grab(:counter)
      current_position = counter.timer[:position]

      # Trouver la clé qui suit la position actuelle
      sorted_keys = lyrics.content.keys.sort
      next_index = sorted_keys.find_index { |key| key > current_position }

      if next_index
        next_position = sorted_keys[next_index]
        update_lyrics(next_position, lyrics, counter)
        grab(:timeline_slider).value(next_position)
      else
        # Si aucune position suivante n'est trouvée, aller à la fin
        last_position = sorted_keys.last
        update_lyrics(last_position, lyrics, counter)
        grab(:timeline_slider).value(last_position)
      end
    end
  end


  def build_navigation_buttons
    prev_word = grab(:view).box({ left: 220, id: :prev, width: 39, height: 20 })
    prev_word.text({ data: :prev, position: :absolute })
    next_word = grab(:view).box({ left: 270, id: :next, width: 39, height: 20 })
    next_word.text({ data: :next, position: :absolute })
    prev_word.touch(true) do
      alert (:lyric_viewer).content
      # cf : update_lyrics
    end
  end

  def build_timeline_slider

    grab(:view).slider({
                         id: :timeline_slider,
                         range: { color: :yellow },
                         min: 0,
                         max: @length,
                         width: 333,
                         value: 0,
                         height: 25,
                         left: 99,
                         tag: [],
                         top: 350,
                         color: :orange,
                         cursor: { color: :orange, width: 25, height: 25 }
                       }) do |value|
      lyrics = grab(:lyric_viewer)
      counter = grab(:counter)
      update_lyrics(value, lyrics, counter)
    end
  end
end