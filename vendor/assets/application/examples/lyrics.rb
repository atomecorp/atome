#  frozen_string_literal: true

total_length = 3000

def closest_values(hash, target, count = 1)
  return ['no lyrics'] if hash.empty?
  sorted_keys = hash.keys.sort
  # find closest key
  closest_index = sorted_keys.index(sorted_keys.min_by { |key| (key - target).abs })
  # ensure index is valid
  return ['no lyrics'] if closest_index.nil?
  # get the `count` value after the closest key
  sorted_keys[closest_index, count].map { |key| hash[key] }.compact
end
def format_lyrics(lyrics_array, target)
  if target.data != lyrics_array[0]  &&  grab(:counter).content == :play # we only update if there's a change
    target.data(lyrics_array[0])
    lyrics_array.each_with_index do |lyric, index|
      unless index == 0
        child = target.text({data:  lyric , component: { size: 33 }})
        child.edit(false)
        child.width(399)
        child.color(:gray)
        child.left(0)
        child.position(:absolute)
        child.top(33 * index)
      end
    end
  end


end

start = box({ width: 33, height: 19, color: :red })
start.text(data: :start, component: { size: 9 }, top: -12, left: 3)

reset = box({ width: 33, height: 19, color: :green, left: 39 })
reset.text(data: 'start reset', component: { size: 9 }, top: -6, left: 3)

stop = box({ width: 33, height: 19, color: :blue, left: 125 })
stop.text(data: :stop, component: { size: 9 }, top: -12, left: 3)

pause = box({ width: 33, height: 19, color: :orange, left: 160 })
pause.text(data: :pause, component: { size: 9 }, top: -12, left: 3, color: :black)

insert = box({ width: 33, height: 19, top: 39, color: :yellowgreen })
insert.text(data: :insert, component: { size: 9 }, top: -12, left: 3, color: :black)

edit = box({ width: 33, height: 19, top: 39, color: :yellow, left: 39 })
edit.text(data: 'edit', component: { size: 9 }, top: -12, left: 3, color: :black)

counter = text({ data: :counter, content: :play,left: 60, top: 90, position: :absolute, id: :counter })
base_text = 'my lyrics'
lyrics_support=box({id: :lyrics_support, width: 180, height: 180,top: 120, left: 35,color: {red: 0.2, green: 0.2, blue: 0.4, id: :base_support_color}})
lyrics = lyrics_support.text({ top: 3, left: 3,width: 600,  data: [{ data: base_text }], id: :lyric_viewer, edit: true, component: { size: 33 }, position: :absolute, content: { 0 => base_text }, context: :insert })
counter.timer({ position: 88 })


def update_lyrics(value, target, timer_found)
  timer_found.data(value)
  timer_found.timer[:position] = value
  timer_found.timer[:start] = value
  current_lyrics = closest_values(target.content, value, 3)
  format_lyrics(current_lyrics, target)
end

slider({ id: :toto, range: { color: :yellow }, min: 0, max: total_length, width: 333, value: 12, height: 25, left: 99, top: 350, color: :orange, cursor: { color: :orange, width: 25, height: 25 } }) do |value|
  update_lyrics(value, lyrics, counter)
end

def closest_key_before(hash, target)
  filtered_keys = hash.keys.select { |key| key <= target }
  filtered_keys.max
end

def alter_lyric_event(lyrics, counter)
  if lyrics.context == :insert
    current_position = counter.timer[:position]
    lyrics.content[current_position] = lyrics.data
    lyrics.blink(:red)
  elsif lyrics.context == :edit
    current_position = counter.timer[:position]
    lyrics_content =  lyrics.content
    lyrics_content_key= closest_key_before(lyrics_content, current_position)
     lyrics_content[lyrics_content_key]=lyrics.data
    lyrics.blink(:yellowgreen)
  end
end
lyrics.touch(:down) do
  grab(:lyrics_support).color({ red: 1, id: :red_col })
   grab(:counter).content(:edit) # prevent the lyrics viewer to be updated when plying
  puts :down
end

lyrics.keyboard(:down) do |native_event|
  event = Native(native_event)
  if event[:keyCode].to_s == '13'
    grab(:lyrics_support).remove(:red_col)
    grab(:counter).content(:play) # allow the lyrics viewer to be updated when plying
    event.preventDefault()
    alter_lyric_event(lyrics, counter)

  end
end

edit.touch(true) do
  lyrics.context(:edit)
  edit.blink(:red)
end

start.touch(true) do
  counter.timer({ end: total_length }) do |value|
    update_lyrics(value, lyrics, counter)
  end
end

reset.touch(true) do
  counter.timer({ end: total_length, start: 0 }) do |value|
    update_lyrics(value, lyrics, counter)
  end
end

stop.touch(true) do
  counter.timer({ stop: true })
end
pause.touch(true) do
  counter.timer({ pause: true })
end

# song canvas
def parse_song_lyrics(song)
  song_lines = song.split("\n")
  formated_text = []
  collected_id=[]
  song_lines.each_with_index do |line_found, index|

    new_id =  "a#{index}".to_sym
    collected_id << new_id
    formated_text << { data: line_found, id: new_id, top: 16 * index, left: 6, position: :absolute, width: 399 }
  end
  grab(:support).text({ data: formated_text, left: 6, top: 3, edit: true,component: { size: 33 } })
  collected_id.each do |line_id|
    grab(line_id).touch(true) do
      lyrics=grab(:lyric_viewer)
      counter=grab(:counter)
      lyrics.data(grab(line_id).data)
      alter_lyric_event(lyrics, counter)
    end
  end
end

support = box({ overflow: :auto, top: 3, left: 390, width: 399, height: 600, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 }, id: :support })

support.shadow({
                 id: :s3,
                 left: 3, top: 3, blur: 9,
                 invert: true,
                 red: 0, green: 0, blue: 0, alpha: 0.7
               })
open_filer = text({data: :import, top: 6, left: 333, color: :yellowgreen })
open_filer.import(true) do |val|
  parse_song_lyrics(val)
end
importer do |val|
  parse_song_lyrics(val[:content])
end

# tests
lyrics.content({ 0 => "hello", 594 => "world", 838 => "of", 1295 => "hope" })
