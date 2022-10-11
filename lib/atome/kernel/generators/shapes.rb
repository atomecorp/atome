# frozen_string_literal: true

def box(params = {})
  temp_default = { render: [:headless], id: "box_#{Universe.atomes.length}", type: :shape, width: 99, height: 99, left: 9, top: 9,
                   color: { render: [:headless], id: "color_#{Universe.atomes.length}", type: :color,
                            red: 0.69, green: 0.69, blue: 0.69, alpha: 1 } }
  params = temp_default.merge(params)

  Atome.new(params)
end

def circle(params = {})
  temp_default = { render: [:html], id: "box_#{Universe.atomes.length}", type: :shape, width: 99, height: 99, left: 9, top: 9,
                   color: { render: [:html], id: "color_#{Universe.atomes.length}", type: :color,
                            red: 1, green: 0.69, blue: 1, alpha: 1 }, smooth: "100%" }
  params = temp_default.merge(params)

  Atome.new(params)
end