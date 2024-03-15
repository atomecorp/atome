# frozen_string_literal: true

styles = {
  width: 199,
  height: 33,
  margin: 6,
  shadow: { blur: 9, left: 3, top: 3, id: :cell_shadow, red: 0, green: 0, blue: 0, alpha: 0.6 },
  left: 0,
  color: :yellowgreen
}

element = { width: 33,
            height: 33,
            component: { size: 11 },
            left: :center,
            top: :center,
            color: :black,
            center: { x: 0, y: 0 },
            type: :text }

listing = [
  { data: :'hello' },
  { data: :'salut', color: :red },
  { data: :hi },
  { data: :ho }
]

 A.list({
                  styles: styles,
                  element: element,
                  listing: listing
                })



styles = {
  width: 199,
  height: 33,
  margin: 6,
  shadow: { blur: 9, left: 3, top: 3, id: :cell_shadow, red: 0, green: 0, blue: 0, alpha: 0.6 },
  left: 0,
  color: :yellowgreen
}

element = { width: 25,
            height: 25,
            smooth: '100%',
            center: { x: 0, y: 0 },
            color: :orange,
            type: :shape }

listing = [
  { smooth: '100%' },
  { color: :red },
  {},
  {},

  { width: 33 },
  {},
]

list_2 = A.list({ left: 300,
                  styles: styles,
                  element: element,
                  listing: listing
                })
wait 1 do
  list_2.left(120)
end