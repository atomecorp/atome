# frozen_string_literal: true

Atome.new(
  shape: { type: :shape, renderers: [:browser], id: :the_shape, attach: [:view], clones: [],
           left: 99, right: 99, width: 399, height: 99,
           # color: { renderers: [:browser], id: :c315, type: :color, attach: [:the_shape],
           #          red: 0.3, green: 1, blue: 0.6, alpha: 1 }
  }
)

Atome.new(
  shape: { type: :color, renderers: [:browser], id: :c315, attach: [:the_shape],
           red: 0.3, green: 1, blue: 0.6, alpha: 1 }

)

Atome.new(
  shape: { renderers: [:browser], id: :the_shape2, type: :shape, attach: [:view], clones: [],
           left: 99, right: 99, width: 99, height: 99,

  }
)

Atome.new(
  shape: { renderers: [:browser], id: :c31, type: :color, attach: [:the_shape2],
           red: 1, green: 0.15, blue: 0.15, alpha: 0.6 }
)