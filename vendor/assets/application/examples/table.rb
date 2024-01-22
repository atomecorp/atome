# frozen_string_literal: true

class HTML

  def set_td_style(td)
    # puts  @original_atome.component
    # Définir le style de la cellule
    cell_height = 50
    td[:style][:border] = "1px solid black"
    td[:style][:backgroundColor] = "white"
    td[:style][:boxShadow] = "10px 10px 5px #888888"
    td[:style][:width] = "#{cell_height}px"
    td[:style]['min-width'] = "#{cell_height}px"
    td[:style]['max-width'] = "#{cell_height}px"
    td[:style]['min-height'] = "#{cell_height}px"
    td[:style]['max-height'] = "#{cell_height}px"
    td[:style][:height] = "#{cell_height}px"
    td[:style][:overflow] = 'hidden'
    { cell_height: cell_height, cell_width: cell_height }
  end

  def table(data)
    table_html = JS.global[:document].createElement("table")
    thead = JS.global[:document].createElement("thead")

    max_length = data.max_by { |row| row.keys.length }.keys.length

    if @original_atome.option[:header]
      header_row = JS.global[:document].createElement("tr")
      # header_row.setAttribute('id', "#{@id}_header")

      max_length.times do |i|
        th = JS.global[:document].createElement("th")
        th[:textContent] = data.map { |row| row.keys[i].to_s }.compact.first || ""
        header_row.appendChild(th)
      end

      thead.appendChild(header_row)
    end

    table_html.appendChild(thead)
    tbody = JS.global[:document].createElement("tbody")

    data.each_with_index do |row, row_index|
      tr = JS.global[:document].createElement("tr")
      # tr.setAttribute('id', "#{@id}_#{row_index.to_s}")

      max_length.times do |cell_index|
        td = JS.global[:document].createElement("td")
        # td.setAttribute('id', "#{@id}_#{row_index}_#{cell_index}")
        cell_size = set_td_style(td)
        cell_height = cell_size[:cell_height]

        cell_value = row.values[cell_index]
        if cell_value.instance_of? Atome
          cell_value.fit(cell_height)
          html_element = JS.global[:document].getElementById(cell_value.id.to_s)
          td.appendChild(html_element)
          html_element[:style][:transformOrigin] = "top left"
          html_element[:style][:position] = "relative"
          cell_value.top(0)
          cell_value.left(0)
        else
          td[:textContent] = cell_value.to_s
        end
        tr.appendChild(td)
      end

      tbody.appendChild(tr)
    end
    table_html.appendChild(tbody)
    JS.global[:document].querySelector("##{@id}").appendChild(table_html)
  end

  def refresh_table(_params)

    # first we need to extact all atome from the table or they will be deleted by the table refres
    data = @original_atome.data
    data.each do |row|
      row.each do |k, v|
        if v.instance_of? Atome
          v.attach(:view)
        end
      end
    end
    table_element = JS.global[:document].querySelector("##{@id} table")
    if table_element.nil?
      puts "Table not found"
      return
    end
    (table_element[:rows].to_a.length - 1).downto(1) do |i|
      # row = table_element[:rows][i]
      # cells = row[:cells].to_a
      table_element.deleteRow(i)
    end

    max_cells = data.map { |row| row.keys.length }.max

    data.each do |row|
      new_row = table_element.insertRow(-1)
      max_cells.times do |i|
        key = row.keys[i]
        value = row[key]
        cell = new_row.insertCell(-1)
        if value.instance_of? Atome
          html_element = JS.global[:document].getElementById(value.id.to_s)
          cell.appendChild(html_element)
        else
          cell[:textContent] = value.to_s
        end
        set_td_style(cell)
      end
    end
  end

  # def refresh_table(_params)
  #   data = @original_atome.data
  #   table_element = JS.global[:document].querySelector("##{@id} table")
  #
  #   if table_element.nil?
  #     puts "Table not found"
  #     return
  #   end
  #   (table_element[:rows].to_a.length - 1).downto(1) do |i|
  #     row = table_element[:rows][i]
  #     cells = row[:cells].to_a
  #     cells.each_with_index do |cell, index|
  #       # alert cell[:innerHTML]
  #       puts "#{index} - Cell content : #{cell[:innerHTML]}"
  #     end
  #
  #     table_element.deleteRow(i)
  #   end
  #
  #   max_cells = data.map { |row| row.keys.length }.max
  #
  #   data.each do |row|
  #     new_row = table_element.insertRow(-1)
  #     max_cells.times do |i|
  #       key = row.keys[i]
  #       value = row[key]
  #       cell = new_row.insertCell(-1)
  #       if value.instance_of? Atome
  #         html_element = JS.global[:document].getElementById(value.id.to_s)
  #         # cell.appendChild(html_element)
  #       else
  #         cell[:textContent] = value.to_s
  #       end
  #       set_td_style(cell)
  #     end
  #   end
  # end

end



new({ atome: :matrix })
new({ particle: :format })
new({ particle: :border })

# table methods
new({ particle: :clean }) do |params|
  cell = params[:cell]
  row_nb = cell[0]
  column_nb = cell[1]
  data[row_nb][data[row_nb].keys[column_nb]] = "" # we remove the data from the cell
  params
end

new({ method: :clean, renderer: :html, type: :hash }) do |params|
  html.table_clean(params)
end

new({ particle: :get }) do |params|
  cell = params[:cell]
  row_nb = cell[0]
  column_nb = cell[1]
  data[row_nb][data[row_nb].keys[column_nb]] # we get the content of the cell
end

new({ particle: :insert }) do |params|
  # cell
  if params[:cell]
    content = params[:content]
    cell = params[:cell]
    row_nb = cell[0]
    column_nb = cell[1]
    data[row_nb][data[row_nb].keys[column_nb]] = content # we remove the data from the cell
  elsif params[:row]
    position_to_insert = params[:row]
    data.insert(position_to_insert, {})
  elsif params[:column]
  end

  params
end

new({ method: :insert, renderer: :html, type: :hash }) do |params|
  html.table_insert(params)
end

new({ particle: :remove }) do |params|

  if params[:row]
    data.delete_at(params[:row])

  elsif params[:column]
    column = params[:column]
    data.map do |hash|
      hash.delete(hash.keys[column]) if hash.keys[column]
      hash
    end
    # data.delete_at(params[:row])
  end
  params
end

new({ method: :remove, renderer: :html, type: :hash }) do |params|
  html.table_remove(params)
end

new({ particle: :sort }) do |params|
  column = params[:column]
  method = params[:method]

  if column.nil? || method.nil?
    puts "Column and method parameters are required."
    return
  end

  @data.sort_by! do |row|
    value = row.values[column - 1]
    if value.instance_of? Atome
      0
    else
      case method
      when :alphabetic
        value.to_s
      when :numeric
        if value.is_a?(Numeric)
          value
        elsif value.respond_to?(:to_i)
          value.to_i
        else
          0
        end
      else
        value
      end
    end
  end

  params
end


# new({ particle: :sort }) do |params|
#
#   column = params[:column]
#   method = params[:method]
#
#   if column.nil? || method.nil?
#     puts "Column and method parameters are required."
#     return
#   end
#
#   @data.sort_by! do |row|
#     value = row.values[column - 1]
#     if value.instance_of? Atome
#       # alert value
#       # we will try to sort by id , we have to ad  sort by type, by width, etc...
#       0
#     else
#       if method == :alphabetic
#         value.to_s
#       elsif method == :numeric
#         if value.is_a?(String) && (value.nil? || value.empty?)
#           0
#         else
#           value.to_i
#         end
#       else
#         value
#       end
#     end
#   end
#
#   params
# end

new({ method: :sort, renderer: :html, type: :hash }) do |params|
  html.refresh_table(params)
end

new({ method: :border, type: :hash, renderer: :html }) do |value, _user_proc|
  thickness = value[:thickness] || 5
  type = value[:pattern] || :solid
  color = if value[:color]
            color_found = value[:color]
            "#{color_found.red * 255},#{color_found.green * 255},#{color_found.blue * 255},#{color_found.alpha} "
          else
            "0,0,0,1"
          end

  html.style(:border, "#{type} #{thickness}px rgba(#{color})")
end

new({ method: :data, type: :string, specific: :matrix, renderer: :html }) do |value, _user_proc|
  html.table(value)
end

c = circle({ id: :my_cirle, color: :red, drag: true })
c.box({ left: 0, width: 22, height: 22, top: 65 })
c.touch(true) do
  alert :okk
end
m = matrix({ renderers: [:html], attach: :view, id: :my_test_box, type: :matrix, apply: [:shape_color],
             left: 333, top: 0, width: 600, smooth: 15, height: 900, overflow: :scroll, option: { header: true },
             component: {
               border: { thickness: 5, color: color(:blue), pattern: :dotted },
               overflow: :auto,
               color: "white",
               shadow: {
                 id: :s4,
                 left: 20, top: 0, blur: 9,
                 option: :natural,
                 red: 0, green: 1, blue: 0, alpha: 1
               },
               height: 50,
               width: 50,
               component: { size: 12, color: :black }
             },
             data: [
               { titi: :toto },
               { dfgdf: 1, name: 'Alice', age: 30, no: 'oko', t: 123, r: 654, f: 123, g: 654, w: 123, x: 654, c: 123, v: 654 },
               { id: 2, name: 'Bob', age: 22 },
               { dfg: 4, name: 'Vincent', age: 33, no: grab(:my_cirle) },
               { dfgd: 3, name: 'Roger', age: 18, no: image(:red_planet), now: :nothing }

             ]

             # data: [
             #   { titi: :toto },
             #   { dfgdf: 1, name: 'Alice', age: 30, no: 55, t: 123, r: 654, f: 123, g: 654, w: 123, x: 654, c: 123, v: 654 },
             #   { id: 2, name: 'Bob', age: 22 },
             #   { dfg: 5, name: 'Vincent', age: 33, no: 456 },
             #   { dfgd: 3, name: 'Roger', age: 18, no: 789 }
             #
             # ]
           })

# tests
m.color(:orange)
m.border({ thickness: 5, color: color(:blue), pattern: :dotted })

# done:
# puts m.get({ cell: [1, 2] })
# #
wait 2 do

  # alert m.data
  # m.insert({ cell: [2, 2], content: 999 })
  # alert m.data

  # m.insert({ row: 1 })
  # #
  # wait 1 do
  #   m.remove({ row: 0 })
  # end
  # wait 2 do
  #   m.remove({ column: 1 })
  # end
  # wait 3 do
  #   m.insert({ column: 3 })
  # end

end



# to do :
wait 2 do
  m.sort({ column: 1, method: :alphabetic })
  puts 1
  wait 1 do
    puts 2
    m.sort({ column: 2, method: :numeric })
    wait 1 do
      puts 3
      m.sort({ column: 3, method: :numeric })
      wait 1 do
        puts 4
        m.sort({ column: 1, method: :numeric })
      end
    end
  end
end

# # cell.fusion()

############ atomizer
new({ atome: :atomised, type: :hash })

# def atomizer(id)
#   # a=Atome.new({id: id, renderers: [:html], type: :html})
#   a=Atome.new(
#     renderers: [:html], id: id, type: :atomised
#     )
#
#   alert a.id
#   # convert any foreign object (think HTML) to a pseudo atome objet , that embed foreign objet
# end
#
#
#
#
#
# atomizer(:my_test_box_1_2)

# strategy get an html object , get its id or create one if none
# get its property convert this to atome particle
# create an atome apply the particles



