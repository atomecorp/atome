text({ id: :my_text, color: :lightgray }) do |p|
  puts "ok text id is : #{id}"
end

text = Atome.new(
  text: { render: [:html], id: :text1, type: :text, parent: [:view], visual: { size: 33 }, data: "My text!", left: 300, top: 33, width: 199, height: 33, }
) do |p|
  puts "ok Atome.new(text) id is : #{id}"
end
wait 1.2 do
  text.text.data(:kool)
end

b = box({ drag: true, left: 66, top: 66 })
my_text = b.text({ data: "drag the bloc behind me" })
wait 2 do
  my_text.left(99)
  my_text.color(:red)
end