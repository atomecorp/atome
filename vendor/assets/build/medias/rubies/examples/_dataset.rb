# # frozen_string_literal: true
#
#
#
# generator = Genesis.generator
# generator.build_atome(:data_set)
# generator.build_particle(:assign) do |cell_nb,&proc |
#     # current_cell = grab("#{@matrix_id}_#{cell_nb}")
#     if proc
#       # @matrix_dataset[cell_nb] << proc
#       # current_cell.instance_exec(&proc) if proc.is_a? Proc
#     else
#       # @matrix_dataset[cell_nb]
#     end
# end
# class Atome
#   def data_set(params = {}, &bloc)
#     atome_type = :data_set
#     generated_render = params[:renderers] || []
#     generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
#     generated_parents = params[:parents] || [id.value]
#     params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
#     Atome.new({ atome_type => params }, &bloc)
#   end
# end
#
#
# # create_atome(:data_set)
#
# a = data_set({})
# puts a
#
# a.assign(2) do
#   curent_cell = self
#   curent_cell.image({ path: "./medias/images/moto.png", width: 33, height: 33})
#   curent_cell.active(:inactive)
#   touch(:long) do
#     if curent_cell.active.value ==:inactive
#       curent_cell.color(:yellow)
#       curent_cell.active(:active)
#     else
#       curent_cell.color(:red)
#       curent_cell.active(:inactive)
#     end
#   end
# end
#
#*
# a.assign(3) do
#   color({ red: 0.6, green: 0.333, blue: 0.6, alpha: 1 })
#   grab(:vie_playground_3).shadow({ blur: 12 })
# end
# puts  "assign : #{a.assign}"
#
box
circle
generator = Genesis.generator

generator.build_atome(:template)

generator.build_sanitizer(:template) do |params|

  default_params = { renderers: [], id: "template_#{Universe.atomes.length}", type: :template,
  }
  default_params.merge!(params)
end

generator.build_particle(:display) do |params|
  template_needed = params[:template]
  targeted_atomes = params[:list]
  alert template_needed
  alert targeted_atomes
end

template({ id: :child_in_table, code: [], cells: 16, columns: 4, rows: 4 })
the_view = grab(:view)
the_view.display(template: :child_in_table, list: [the_view.children.value], left: 33, top: 63, width: 333, height: 333)

# alert the_view



