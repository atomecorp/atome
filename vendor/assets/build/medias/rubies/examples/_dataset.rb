# # frozen_string_literal: true

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

box
circle({top: 300})
generator = Genesis.generator

generator.build_atome(:template)
generator.build_particle(:cells)
generator.build_particle(:rows)
generator.build_particle(:columns)
generator.build_sanitizer(:template) do |params|
  default_params = { renderers: [], id: "template_#{Universe.atomes.length}", type: :template }
  default_params.merge!(params)
end

def resize_matrix(params)
  matrix=params[:matrix]
  matrix_width = params[:width]
  matrix_height = params[:height]
  cells=params[:cells]
  nb_of_cols= params[:columns]
  nb_of_rows= params[:rows]
  margin=params[:margin]
  cell_width = (matrix_width / nb_of_cols) - margin
  cell_height = (matrix_height / nb_of_rows) - margin
  row = -1
  cells.each_with_index do |cell, index|
    cell.height = cell_height
    cell.width = cell_width
    row += 1 if index.modulo(nb_of_cols).zero?
    cell.left(index % nb_of_cols * (cell_width + margin) + margin)
    cell.top(row * (cell_height + margin) + margin)
  end

  matrix.width = matrix_width + margin
  matrix.height = matrix_height + margin
end

generator.build_particle(:display) do |params|
  template_needed = params[:template]
  targeted_atomes = params[:list]
  puts "add this to cells #{targeted_atomes}"
  matrix_back_color=create_matrix_colors('matrix_color_back',0,1,0,1)
  cell_back_color=create_matrix_colors('cell_color_back',1,0.15,0.7,1)
  matrix_back_id="#{template_needed}_display_nb"
  matrix_back=create_matrix_back( matrix_back_id, { width: 33, smooth: 9 })
  matrix_back_color.attach([matrix_back_id])
  cells=create_matrix_cells(matrix_back_id,cell_back_color,33,{width: 33, height: 33, smooth: 9})
  resize_matrix({matrix: matrix_back, width: 333, height: 333, cells: cells, columns: 2, rows: 8, margin: 9 })
end

def create_matrix_colors(name,red,green,blue,alpha)
  Atome.new({ color: { renderers: [:browser], id: name, type: :color, parents: [], children: [],
                       red: red, green: green, blue: blue, alpha: alpha  } })
end

def create_matrix_back( id, style)
  matrix = Atome.new(
    shape: { type: :shape, renderers: [:browser], id: id, parents: [:view],width: 333, height: 333,left: 333,
             overflow: :auto,children: [] }
  )
  matrix.style(style)
  matrix
end


def create_matrix_cells(id,cell_back_color, number_of_cells, style)
  counter=0
  cells=[]
  while counter < number_of_cells
    id_generated=id + "_#{counter}"
    cells << a = Atome.new(
      shape: { type: :shape, renderers: [:browser], id: id_generated, parents: ['child_in_table_display_nb'],
               children: [:cell_color]

               }
    )
    cell_back_color.attach([id_generated])
    a.style(style)
    counter += 1
  end
  cells
end

template({ id: :child_in_table, code: [], cells: 16, columns: 4, rows: 4 })
the_view = grab(:view)
the_view.display(template: :child_in_table, list: [the_view.children.value], left: 33, top: 63, width: 333, height: 333)


