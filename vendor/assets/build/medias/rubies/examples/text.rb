text({ id: :my_text }) do |p|
  puts "ok text id is : #{id}"
end

text=Atome.new(
  text: { render: [:html], id: :text1, type: :text, parent: [:view], visual: { size: 33 }, data: "My text!", left: 300, top: 33, width: 199, height: 33, }
) do |p|
  puts "ok Atome.new(text) id is : #{id}"
end

text.text.data(:kool)

b=box({drag: true, left: 66, top: 66})
b.text({ data: "drag the bloc behind me" })