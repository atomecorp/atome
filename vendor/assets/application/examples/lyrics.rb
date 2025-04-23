# frozen_string_literal: true

# Classe principale pour gérer l'affichage et l'enregistrement des paroles
class Lyricist < Atome
  attr_accessor :lyrics, :record, :replace_mode, :length, :counter

  def initialize
    @lyrics = {}
    @tempo = 120
    @record = false
    @replace_mode = false
    @default_length = 300
    @length = @default_length
    @original_number_of_lines = 4
    @number_of_lines = @original_number_of_lines
    @actual_position= 0
    build_ui
  end

  def style
    {
      line_width: 1600
    }
  end

  # Construction de l'interface utilisateur
  def build_ui
    build_control_buttons
    build_record_button
    build_lyrics_viewer
    build_song_support
    build_editor_controls
    build_timeline_slider
  end

  # Méthodes pour la gestion des paroles
  def closest_values(hash, target, count = 1)
    return [] if hash.empty?
    sorted_keys = hash.keys.sort
    closest_index = sorted_keys.index(sorted_keys.min_by { |key| (key - target).abs })
    return [] if closest_index.nil?
    sorted_keys[closest_index, count].map { |key| hash[key] }.compact
  end

  def closest_key_before(hash, target)
    filtered_keys = hash.keys.select { |key| key <= target }
    filtered_keys.max
  end

  def format_lyrics(lyrics_array, target)
    if target.data != lyrics_array[0] && grab(:counter).content == :play
      target.data(lyrics_array[0])
      lyrics_array.each_with_index do |lyric, index|
        unless index == 0
          child = target.text({ data: lyric, component: { size: 33 } })
          child.edit(false)
          child.width(style[:line_width])
          child.color(:gray)
          child.left(0)
          child.position(:absolute)
          child.top(33 * index)
        end
      end
    end
  end

  def update_lyrics(value, target, timer_found)
    timer_found.data(value)
    timer_found.timer[:position] = value
    timer_found.timer[:start] = value
    @actual_position = value
    # puts @actual_position
    current_lyrics = closest_values(target.content, value, @number_of_lines)
    format_lyrics(current_lyrics, target)
  end

  def alter_lyric_event(lyrics)
    lyrics = grab(:lyric_viewer)
    counter = grab(:counter)
    current_position = counter.timer[:position]
    lyrics.content[current_position] = lyrics.data
    lyrics.blink(:red)
  end

  # Méthodes pour la création des composants UI

  private

  def refresh_viewer(at=0)
    grab(:timeline_slider).delete({ force: true })
    build_timeline_slider
    grab(:timeline_slider).value(at)
  end

  def clear_all
    lyric_viewer = grab(:lyric_viewer)
    lyric_viewer.content = {}
    @length = @default_length
    lyric_viewer.clear(true)
    lyric_viewer.data('')
    grab(:timeline_slider).delete({ force: true })
    build_timeline_slider
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
      prev_postion= @actual_position
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
        # grab(:timeline_slider).delete({ force: true })

      end
      # refresh_viewer

      refresh_viewer(prev_postion)
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

    lyrics.touch(:down) do
      grab(:lyrics_support).color({ red: 1, id: :red_col })
      grab(:counter).content(:edit) # Empêche la mise à jour du viewer de paroles pendant la lecture
    end

    lyrics.keyboard(:down) do |native_event|
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
    editor = grab(:view).box({ id: :editor, width: 33, height: 33, top: :auto, bottom: 9, left: 63, color: :yellowgreen })
    editor.text(:hide)
    clear = grab(:view).box({ id: :clear, width: 33, height: 33, top: :auto, bottom: 9, left: 99, color: :orangered })
    clear.text(:clear)
    clear.touch(true) do
      grab(:support).clear(true)
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

  # Analyse et affichage des paroles de chanson
  def parse_song_lyrics(song)
    song_lines = song.split("\n")

    song_lines.each_with_index do |line_found, index|
      new_id = "a_lyrics_line_#{index}".to_sym
      puts "new_id: #{new_id}, #{index} =>> #{line_found}"

      line_support = grab(:support).box({
                                          id: new_id,
                                          width: 399,
                                          height: 30,
                                          top: index * 33,
                                          left: 3,
                                          color: { red: 1, green: 0.3, blue: 0.3 },
                                          smooth: 9
                                        })

      line_support.text({
                          data: line_found,
                          id: "#{new_id}_text",
                          top: 1,
                          left: 1,
                          position: :absolute,
                          width: 399
                        })

      line_support.touch(true) do
        lyrics = grab(:lyric_viewer)
        counter = grab(:counter)
        lyrics.data(line_found)
        alert ("quoiqoiqoqio")
        alter_lyric_event(lyrics, counter)
      end
    end
  end
end

# Création de l'instance et lancement de l'application
Lyricist.new

