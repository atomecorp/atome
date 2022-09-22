# frozen_string_literal: true
# the entry class
class Atome
  def initialize(params)
    params.each do |k,v|
      send k,v
    end

  end


end

# def shape (params)
#   verif = Universe.atomes[0]
#   place = Universe.atomes.index verif
#   Universe.atomes[place] = nil
#   puts Universe.atomes[place]
#
#   # puts Universe.atomes[0].id
#   # Universe.atomes[0].shape(params)
#   # puts Universe.atomes[0].inspect
#   # strategy atomes shoud be formatted as follow : atomes={@id => atome}
#   # try to delete doing @id= nil , then atomes.delete(@id)
#   ## bad idea!! if getter_preprocess try the following method:
#   ## instances_variables.each do  |method|
#   ##   generate_method method
#   # #end
# end

a = Atome.new(shape: { s1: { x: 30, width: 30,
                         color: { c1: {  red: 1, green: 0, stack: [{ id: :c2, red: 1 }, { id: 3, red: 0 }] } }} })
puts a .class
# a.new(:hello)
# #easy way =>
# a = shape(x: 30, id: :s1, width: 30,
#           color: { id: :c1, red: 1, green: 0, stack: [{ id: :c2, red: 1 }, { id: 3, red: 0 }] })

######### best solution #########
{ id: { type: { id: { particles: :value } } } }
{ s_all: { shapes: { s1: { x: 30 } } } }
{ s_all: { shapes: { s1: { x: 30, colors: { c1: { red: 1, green: 1, blue: 1, alpha: 1 } } } } } }
{ g_all: { groups: { g1: { x: 30, child: [:child1, :child3] } } } }
