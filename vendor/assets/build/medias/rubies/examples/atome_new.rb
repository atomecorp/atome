# frozen_string_literal: true

Atome.new(
  shape: { type: :shape, renderers: [:browser], id: :the_shape, parents: [:view], children: [], clones: [],
           left: 99, right: 99, width: 399, height: 99,
           color: { renderers: [:browser], id: :c315, type: :color, parents: [:the_shape], children: [],
                    red: 0.3, green: 1, blue: 0.6, alpha: 1 } }
)

Atome.new(
  shape: { renderers: [:browser], id: :the_shape2, type: :shape, parents: [:view], children: [], clones: [],
           left: 99, right: 99, width: 99, height: 99,
           color: { renderers: [:browser], id: :c31, type: :color, parents: [:the_shape2], children: [],
                    red: 1, green: 0.15, blue: 0.15, alpha: 0.6 } }
)
