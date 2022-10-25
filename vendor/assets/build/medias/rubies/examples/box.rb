box({ id: :my_box, left: 333 }) do |p|
  # callback is in the Genesis.atome_creator_option(:text_pre_save_proc)
  puts "ok box id is : #{id}"
  wait 2 do
    self.left(0)
  end
end

Atome.new(
  { shape: { render: [:html], id: :view_test, type: :shape, parent: [:view],
             left: 0, width: 90, top: 0, height: 90, overflow: :auto,
             color: { render: [:html], id: :view_test_color, type: :color,
                      red: 1, green: 0.15, blue: 0.15, alpha: 1 } } }
) do |p|
  puts "ok Atome.new(box) id is : #{id}"
end
