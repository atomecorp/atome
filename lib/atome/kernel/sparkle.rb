# frozen_string_literal: true

# init basic object for atome environment

# let's create the view port

# done: add an id generator when id data is missing
# TODO: reorder data to place id at the begining of the hash

view = Atome.new({left: 0, right: 0, top: 0, bottom: 0, id: :view,
                  shape: {color: {id: :c1,render: [:native], red: 0.15, green: 0.15, blue: 0.15, alpha: 1 }} })
# view.width(222) do |toto|
#   puts "jhgjhgjh"
# end
#
# puts "view is : #{view.shape}"
# view.width(99)
# puts view.id
#
# puts view.width

# puts view

puts Utilities.grab(:c1)
# puts Atome.current_machine
# puts Atome.current_user
