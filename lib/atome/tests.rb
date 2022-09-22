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
  verif = Universe.atomes[0]
  place = Universe.atomes.index verif
  Universe.atomes[place] = nil
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

######### other solution #########
a = Atome.new({ shape: { y: 99 } })
a.shape(x: 66)
a.shapes({ x: 33, y: 199 })
{ shapes: { id: :all_shapes, x: 33, y: 200, content: [{ id: :shape1, type: :shape, x: 66, y: 99, width: 120, height: 333 }] } }
# exeption below try to find another strategy
a.group(:child1, :child3)
{ groups: { id: :all_groups, children: [:child1, :chlid3] } }

a.text(:hello)
{ texts: { id: :all_texts, content: [{ id: :text1, type: :text, content: :hello, width: 333, height: 33,
                                       colors: {
                                         id: :all_colors, content: [{ id: :col1, red: 0, green: 0.3, blue: 0.9,
                                                                      alpha: 1, diffusion: :linear, x: 33, Y: 33 }]
                                       } }] } }

a.set
a.replace
a.add
a.new(:jkl)

######### best solution #########
{ id => { type => { id => { particles: :value } } } }
{ s_all: { shapes: { s1: { x: 30 } } } }
{ s_all: { shapes: { s1: { x: 30, colors: { c1: { red: 1, green: 1, blue: 1, alpha: 1 } } } } } }
{ g_all: { groups: { g1: { x: 30, child: [:child1, :child3] } } } }
