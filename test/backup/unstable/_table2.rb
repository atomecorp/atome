# frozen_string_literal: true

generator = Genesis.generator

# generator.build_atome(:collector)
class Atome

  #
  def cells(cells_number)
    # collector({id: :toto, renderers: [], children: [], attach: []})
    # collector_object = collector({})
    collector_object = collector
    collected_atomes = []
    cells_number.each do |cell_found|
      atome_found = grab("#{id}_#{cell_found}")
      collected_atomes << atome_found
    end
    # collector_object.data(collected_atomes)
    # collector_object
  end

  def cell(cell_nb)
    grab("#{id}_#{cell_nb}")
  end

end

# class Batch
#
#   def each(&proc)
#     value.each do |val|
#       instance_exec(val, &proc) if proc.is_a?(Proc)
#     end
#   end
#
#   def id(val = nil)
#     if val
#       @id = val
#     else
#       @id
#     end
#   end
#
#   def initialize(params)
#     @id = params[:id] || "batch_#{Universe.atomes.length}"
#     Universe.add_to_atomes(@id, self)
#   end
#
#   def dispatch (method, *args, &block)
#     @data.each do |atome_found|
#       atome_found.send(method, *args, &block)
#     end
#   end
#
#   # TODO:  automatise collector methods creation when creato,g a new atome type
#   def color(args, &block)
#
#     dispatch(:color, args, &block)
#   end
#
#   def shadow(args, &block)
#     dispatch(:color, args, &block)
#   end
#
#   def method_missing(method, *args, &block)
#     dispatch(method, args, &block)
#   end
#
#   def data(collection)
#     @data = collection
#   end
#
# end

generator = Genesis.generator
generator.build_atome(:collector) do |params = {}, &bloc|
  atome_type = :collector
  generated_render = params[:renderers] || []
  generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
  generated_parents = params[:parents] || [id.value]
  generated_children = params[:children] || []
  params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
  Batch.new({ atome_type => params }, &bloc)
end


generator.build_atome(:barnabe)
# #
# # TODO : make the code below works
# # alert 'solve this'
# # b=box({width: 600, height: 600})
# # b.matrix({width: '100%', height: '100%'})
#
# # matrix({ id: :totot,columns: { count: 24 } })
# m = matrix
# # m.collector({id: :toto, renderers: [], children: [], attach: []})
# m.cells([20, 5])
# # m.cells([20, 5]).color(:red)
# # m.columns(≈6).data[0..3].color(:green)
# # alert :plp
# #######
# b=box
# c=b.collector
 # c.data
# alert c.data
b=barnabe.id(:ttot)
alert b.id
# alert b.data(33)