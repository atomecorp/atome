# parameter example

b=box
b.parameter({ target: :the_box,
              type: :circular,
              length: 33,
              thickness: 12,
              helper_length: nil,
              helper_thickness: 12
            })
t=text({ content: " click to box to view params stored in ", visual: 15, x: 99 })
b. touch do
  t.content(parameter.to_s)
end