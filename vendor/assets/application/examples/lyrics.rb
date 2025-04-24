# frozen_string_literal: true
require './examples/lyrics_helper'
require './examples/lyrics_builder'
# Classe principale pour gérer l'affichage et l'enregistrement des paroles
class Lyricist < Atome
  attr_accessor :lyrics, :record, :replace_mode, :length, :counter

  def initialize(content = nil)
    @lyrics = {}
    @tempo = 120
    @record = false
    @replace_mode = false
    @default_length = 300
    @length = @default_length
    @original_number_of_lines = 4
    @number_of_lines = @original_number_of_lines
    @actual_position = 0
    build_ui
    if content
      new_song(content)
    end
  end

  def style
    {
      line_width: 1600
    }
  end

  def new_song(content)

    grab(:lyric_viewer).content(content)
    last_key, last_value = content.to_a.last
    @default_length = last_key
    @length = @default_length
    refresh_viewer(0)
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

  def full_refresh_viewer(at = 0)

    grab(:timeline_slider).delete({ force: true })
    build_timeline_slider
    grab(:timeline_slider).value(0)

    ####
    grab(:timeline_slider).delete({ force: true })
    build_timeline_slider
    grab(:timeline_slider).value(@length)


    grab(:timeline_slider).delete({ force: true })
    build_timeline_slider
    grab(:timeline_slider).value(at)
  end

  def refresh_viewer(at = 0)
    #todo: optimise and find a better way to refresh the viewer
    # removing the tow lines below is not a good way to do it, and efficient
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
        alter_lyric_event(lyrics, counter)
      end
    end
  end
end

# Création de l'instance et lancement de l'application
lyr = Lyricist.new

lyr.new_song({ 0 => "hello", 594 => "world", 838 => "of", 1295 => "hope" })

