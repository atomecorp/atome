# frozen_string_literal: true

b=box
b.classes(:new_class)

c=circle
c.classes(:new_class)

puts Universe.classes
b.remove({classes: :new_class})


puts Universe.classes