# frozen_string_literal: true
# v1.0
b=box
margin = 12
b2=box({top: below(b, margin)})
b3=box({top: below(b2, margin)})
b4=box({top: below(b3, margin)})
box({top: below(b4, margin)})
i=0

# Global Purpose:
# The code demonstrates Atome's capabilities to:
# - Create complex dynamic structures: vertical stacking and horizontal alignment with repeated elements.
# - Handle mixed units (fixed and relative) for positioning, showcasing flexibility in designing adaptive layouts.
# - Simplify visual prototyping by using simple methods like 'below' and 'after' for consistent placement without external calculations.
# If integrated into a demonstration or project, this code could explain these concepts to developers or test Atome's engine flexibility.

def infos
  "The code demonstrates Atome's capabilities to:\n" \
    "- Create complex dynamic structures: vertical stacking and horizontal alignment with repeated elements.\n" \
    "- Handle mixed units (fixed and relative) for positioning, showcasing flexibility in designing adaptive layouts.\n" \
    "- Simplify visual prototyping by using simple methods like 'below' and 'after' for consistent placement without external calculations.\n" \
    "If integrated into a demonstration or project, this code could explain these concepts to developers or test Atome's engine flexibility."
end

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
