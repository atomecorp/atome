# frozen_string_literal: true

b=box
b.class(:new_class)

c=circle
c.class(:new_class)

puts Universe.classes
b.remove({class: :new_class})


puts Universe.classes