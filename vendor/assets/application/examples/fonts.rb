# frozen_string_literal: true

# add new font face
A.add_text_visual({ path: 'Roboto', name: 'Roboto-Thin' })
A.add_text_visual({ path: 'Roboto', name: 'Roboto-Thin' })
A.add_text_visual({ path: 'Roboto', name: 'Roboto-LightItalic' })

# now applying it
first_text=text({ data: :hello, component: { size: 55, visual: 'Roboto-Thin' } })
wait 1 do
  text({ data: :hello, component: { size: 55, visual: 'Roboto-Black' } })
  wait 1 do
    first_text.component({visual: 'Roboto-LightItalic'})
  end
end
