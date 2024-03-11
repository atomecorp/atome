# frozen_string_literal: true

color({ id: :creation_layer_col, alpha: 1 })

b = box({ top: :auto, bottom: 0, id: :box_tool })

b.touch(:down) do
  creation_layer = box({ top: 0, left: 0, id: :creation_layer, width: '100%', height: '100%', apply: :creation_layer_col })
  creation_layer.touch(:down) do |event|
    left_found = event[:pageX].to_i
    top_found = event[:pageY].to_i
    box({ left: left_found, top: top_found ,id: "tutu_#{Universe.atomes.length}", color: :red})
    creation_layer.delete(true)
    creation_layer.touch({ remove: :down })
    puts Universe.atomes.length
    puts "=> #{Universe.user_atomes}"
  end
end

