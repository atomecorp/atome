#  frozen_string_literal: true

total_length = 3000

def closest_values(hash, target, count = 1)
  return ['no lyrics'] if hash.empty?
  sorted_keys = hash.keys.sort
  # find closest key
  closest_index = sorted_keys.index(sorted_keys.min_by { |key| (key - target).abs })
  # ensure index is valid
  return ['no lyrics'] if closest_index.nil?
  # puts sorted_keys[closest_index, count].map { |key| hash[key] }.compact
  # get the `count` value after the closest key
  sorted_keys[closest_index, count].map { |key| hash[key] }.compact
end

def format_lyrics(lyrics_array, target)
  # t=text({ data: ['this is ', :super, { data: ' cool', color: :red, id: :new_one }]})
  # wait 1 do
  #   t.data(['this is ', :hyper, { data: 'geniously', color: :pink, id: :new_one }])
  # end
  # alert lyrics_array
  # target.data(lyrics_array)
  # target.data(lyrics_array.join("\n"))
  target.data(lyrics_array[0])
  # target.text
  lyrics_array.each_with_index do |lyric, index|
    unless index == 0

      child = target.text(lyric)
      child.edit(false)
      child.color(:gray)
      child.left(0)
      child.position(:absolute)
      child.top(19)
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

b4 = box({ left: 120, top: 70, color: :purple })

counter = text({ data: :counter, left: 60, top: 90, position: :absolute })
check = b4.text(data: :check, component: { size: 9 }, top: -12, left: 3)
base_text = 'my lyrics'
lyrics = text({ data: [{ data: base_text }], edit: true, component: { size: 16 }, top: 190, left: 35, position: :absolute, content: { 0 => base_text }, context: :insert })
counter.timer({ position: 88 })

def update_lyrics(value, target, timer_found)
  timer_found.data(value)
  timer_found.timer[:position] = value
  timer_found.timer[:start] = value
  current_lyrics = closest_values(target.content, value, 2)
  format_lyrics(current_lyrics, target)
end

slider({ id: :toto, range: { color: :yellow }, min: 0, max: total_length, width: 333, value: 12, height: 25, left: 99, top: 350, color: :orange, cursor: { color: :orange, width: 25, height: 25 } }) do |value|
  update_lyrics(value, lyrics, counter)
end

lyrics.keyboard(:down) do |native_event|
  event = Native(native_event)
  if event[:keyCode].to_s == '13'
    event.preventDefault()
    if lyrics.context == :insert
      current_position = counter.timer[:position]
      lyrics.content[current_position] = lyrics.data
      lyrics.blink(:red)
    elsif lyrics.context == :edit
      lyrics.blink(:yellowgreen)
    end
  end
end

edit.touch(true) do
  lyrics.context(:edit)
  edit.blink(:red)
end

b4.touch(true) do
  check.data(counter.timer[:position])
  puts lyrics.content
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

lyrics.content({ 0 => "hello", 594 => "world", 838 => "of", 1295 => "hope" })

