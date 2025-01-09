# frozen_string_literal: true

b=box({})
margin = 12
b2=box({top: below(b, margin)})
b3=box({top: below(b2, margin)})
b4=box({top: below(b3, margin)})
box({top: below(b4, margin)})
i=0
wait 1 do
  t= text({data: :hello})
  wait 1 do
    t.color(:red)
    dd.poil(:tutu)
  end
end
# b=boxx
b = circle(left: 333, top: 333)
margin = "2%"
# margin = 120
i = 0

while i < 10 do
  #below first params is the object after which we place the objet, the second the margin
  # here in percent and the third is the reference object used for the percent
  # b = circle({top: below(b, margin, grab(:view)), left: b.left})
  # b = circle({top: :auto,bottom: above(b, margin, grab(:view)), left: b.left})
  b = circle({top: b.top,left: after(b, margin, grab(:view))})
  # b = circle({left: :auto,right: before(b, margin, grab(:view))})
  i += 1
end
def api_infos
  {
    "example": "Purpose of the example",
    "methods_found": [
      "left",
      "top"
    ],
    "left": {
      "aim": "Controls the horizontal position of the object within its container.",
      "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
    },
    "top": {
      "aim": "Defines the vertical position of the object in its container.",
      "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
    }
  }
end
