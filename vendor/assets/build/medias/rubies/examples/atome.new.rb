Atome.new(
  shape: {type: :shape, render: [:html], id: :the_shape, parent: [:view], left: 99, right: 99, width: 399, height: 99,
          color: { render: [:html], id: :c315, type: :color, parent: [:the_shape],
                   red: 0.3, green: 1, blue: 0.6, alpha: 1} }
)


Atome.new(
  shape: { render: [:html], id: :the_shape2, type: :shape, parent: [:view], left: 99, right: 99, width: 99, height: 99,
           color: { render: [:html], id: :c31, type: :color,parent: [:the_shape2],
                    red: 1, green: 0.15, blue: 0.15, alpha: 0.6 } }
)