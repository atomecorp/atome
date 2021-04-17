# select example

start = text({ content: "click me to start selecting", x: 30, y: 69, atome_id: :the_text_0 })
stop = text({ content: "click me twice to stop selecting", x: 30, y: 96, atome_id: :the_text_1 })

box(x: 300, y: 300, drag: true, atome_id: :the_box)

text({ content: :hello, y: 300, x: 400, drag: true, atome_id: :the_text_1 })

box({ y: 300, x: 500, color: :red, atome_id: :the_circle, smooth: 9, width: 39, height: 39 })

circle({ center: true, atome_id: :the_circle_2, color: :black, width: 39, height: 39 })
treated_item=[]
start.touch do
  start.content("selection activated").color(:red)
  stop.content("click me twice to stop selecting").color(:black)
  grab(:view).select(true) do
    selection.each do |atome_found|
      treated_item << atome_found
    end
    selection.color([:yellowgreen, :green]).drag(true).shadow({ color: :black, thickness: 0, x: 0, y: 0, blur: 6 })
  end
end

stop.touch(option: :up) do
  stop.content("selection desactivated").color(:red)
  start.content("click me to start selecting").color(:black)
  treated_item.each do |item_found|
    item_found.color(:red).drag(:destroy)
  end
  grab(:view).select(:destroy)
end