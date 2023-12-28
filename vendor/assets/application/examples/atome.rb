# frozen_string_literal: true

Atome.new(
  { renderers: [:html], id: :test_box, type: :shape, attach: :view, apply: [:shape_color],
    tag: { system: true }, left: 120,  top: 120, bottom: 0, width: 333, height:333, overflow: :auto,
  }

)
