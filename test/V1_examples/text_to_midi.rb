# text to midi example

# require "opal-parser"
t = text("ok")

cc = circle({ width: 33, height: 33, y: 69, x: 69, color: :yellow, atome_id: :the_cc })

ATOME.repeat 5, 0 do |evt|
  t.content(evt.abs)
  reader("./medias/rubies/text_read.rb") do |datas_get|
    datas = eval(datas_get)
    temperature = datas[:temperature]
    wind = datas[:wind]
    humidity = datas[:humidity]
    t.content("temperature : #{temperature}, wind : #{wind}, humidity : #{humidity}")
    # cc.transmit({midi: {play: {note: "C3", channel: 15, velocity: 10}}})
    ATOME.wait 2 do
      t.content(:stop)
      # cc.transmit({midi: {stop: {note: "C3", channel: 15, velocity: 100}}})
    end
  end
end