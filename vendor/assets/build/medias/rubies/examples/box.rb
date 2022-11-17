# frozen_string_literal: true

a = box({ id: :my_box, left: 333 }) do |p|
  puts "the param pass to the box is: #{p}"
  wait 2 do
    left(120)
  end
end

b = Atome.new(
  { shape: { render: [:html], id: :view_test, type: :shape, parent: [:view],
             left: 0, width: 90, top: 0, height: 90, overflow: :auto,
             color: { render: [:html], id: :view_test_color, type: :color, parent: [:view_test],
                      red: 1, green: 0.15, blue: 0.15, alpha: 1 } } }
) do |p|
  puts "the param pass to the atome is: #{p}"

end

bloc_a = a.bloc.value
bloc_b = b.bloc.value
a.instance_exec(:hello, &bloc_a) if bloc_a.is_a?(Proc)
b.instance_exec(:hi, &bloc_b) if bloc_b.is_a?(Proc)
