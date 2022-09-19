# frozen_string_literal: true

# the entry class
# class Atome
#   def initialize(params)
#     puts " init : #{params}"
#   end
#
#
# end


def shape (params)
 verif= Universe.atomes[0]
 place= Universe.atomes.index verif
 Universe.atomes[place]=nil
 puts Universe.atomes[place]

 # puts Universe.atomes[0].id
 # Universe.atomes[0].shape(params)
  # puts Universe.atomes[0].inspect
  # strategy atomes shoud be formatted as follow : atomes={@id => atome}
  # try to delete doing @id= nil , then atomes.delete(@id)
  ## bad idea!! if getter_preprocess try the following method:
  ## instances_variables.each do  |method|
  ##   generate_method method
  # #end
end
a = Atome.new({ x: 30, id: :s1, width: 30,
                color: { id: :c1, red: 1, green: 0, stack: [{ id: :c2, red: 1 }, { id: 3, red: 0 }] } })

# a.new(:hello)
# #easy way =>
a = shape(x: 30, id: :s1, width: 30,
          color: { id: :c1, red: 1, green: 0, stack: [{ id: :c2, red: 1 }, { id: 3, red: 0 }] })
puts a

puts Atome.current_machine
# #fast way =>
# Atome.set({shape: {s1: {x:30,width: 30,color: {c1: {red: 1, green: 0, stack:{c2: {red: 0.1,green: 1}}}}}}})
# #or also fast =>
# Atome.new({shape: {s1: {x:30,width: 30,color: {c1: {red: 1, green: 0, stack:{c2: {red: 0.1,green: 1}}}}}}}))
#
# #is stored =>
# a={shape: {s1: {x:30,width: 30,color: {c1: {red: 1, green: 0, stack:{c2: {red: 0.1,green: 1}}}}}}}
#
# #fast setter =>
# a.fset color({c1: {red: 1}}) #=> must be formatted as stored
# a.fadd color({c2: {red: 0.1}})
#
# #easy setter =>
# b.color({id: :c1, red: 1}) #=> add id if not set and clean data
# b.set({color: :red,x: 30})
# b.add({color: :blue},{color: :cyan})
# b.add(color: [:red,:cyan])
#
#
# # apply set
# # add new
# # delete replace
# # update
# # get read
