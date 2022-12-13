# frozen_string_literal: true

a = box({ id: :my_box, left: 333 }) do |p|
  puts "the param pass to the box is: #{p}"
  wait 2 do
    left(120)
  end
end

b = Atome.new(
  { shape: { renderers: [:browser], id: :view_test, type: :shape, parents: [:view],children: [],
             left: 0, width: 90, top: 0, height: 90, overflow: :auto,
             color: { renderers: [:browser], id: :view_test_color, type: :color, parents: [:view_test],
                      red: 1, green: 0.15, blue: 0.15, alpha: 1 } } }
) do |p|
  puts "the param pass to the atome is: #{p}"

end
a.run(:hello)
b.run(:hi)
