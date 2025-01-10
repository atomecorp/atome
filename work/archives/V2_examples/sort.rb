# frozen_string_literal: true

a = box({ width: 180, height: 333, id: :the_grid, overflow: :scroll })
i = 0
while i < 16
  b = Atome.new(
    shape: { renderers: [:browser],id: "the_shape#{i}", type: :shape, attach: [:the_grid], fasten: [],
             width: 50, height: 50,
             color: { renderers: [:browser], id: :c31, type: :color, attach: ["the_shape#{i}"], fasten: [],
                      red: 1, green: 0.15, blue: 0.15, alpha: 0.6 } }
  )
  b.text({ data: "item#{i + 1}", visual: { size: 12 } })
  i += 1
end

a.sort(true) do |el|
  puts "just sorted  : #{el}"
end
