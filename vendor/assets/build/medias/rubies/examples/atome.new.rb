a=Atome.new(
  shape: { render: [:html], id: :crasher, type: :shape, parent: [:view], left: 99, right: 99, width: 99, height: 99,
           color: { render: [:html], id: :c315, type: :color,
                    red: 1, green: 0.15, blue: 0.15, alpha: 0.6 } }
)

# attention to modify an atome using Atome.new you must apply your method to the first atome
# here the first atome is shape,  so if you want to make it draggable drag type:

a.shape.drag(true) do |x, y|
  puts "drag position: #{x}"
end