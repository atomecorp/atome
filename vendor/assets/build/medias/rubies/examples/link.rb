Atome.new(
  shape: { render: [:html], id: :crasher, type: :shape, parent: [:view], left: 99, right: 99, width: 99, height: 99,
           color: { render: [:html], id: :c315, type: :color,
                    red: 1, green: 0.15, blue: 0.15, alpha: 0.6 } }
)
text = Atome.new(
  text: { render: [:html], id: :text1, type: :text, parent: [:view], visual: { size: 33 }, string: "hello!", left: 399, top: 633, width: 199, height: 33,
  }
)

text.text.link(:c315)
# now we change the color all the obect that share the care modified
grab(:c315).red(0)