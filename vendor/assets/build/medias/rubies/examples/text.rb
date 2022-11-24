# frozen_string_literal: true

my_text = Atome.new(
  text: { renderers: [:browser], id: :text1, type: :text, parents: [:view], children: [], visual: { size: 33 },
          data: 'My first text!', left: 300, top: 33, width: 199, height: 33,
          color: { renderers: [:browser], id: :c31, type: :color, parents: [:text1], children: [],
                   red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }
  }
)

wait 1.2 do
  my_text.data(:kool)
end

text({ id: :the_text, left: 0 })

text2 = Atome.new(
  text: { renderers: [:browser], id: :text2, type: :text, parents: [:view], children: [], visual: { size: 33 },
          data: 'My second text!', left: 300, top: 33, width: 199, height: 33 }
) do |p|
  puts "ok Atome.new(text) id is : #{id}"
end
wait 1.2 do
  text2.text.data(:ok)
end

b = box({ left: 66, top: 66 })
my_text = b.text({ data: 'drag the bloc behind me', width: 333, left: 55 })
wait 2 do
  my_text.color(:red)
end

