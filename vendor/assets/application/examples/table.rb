# frozen_string_literal: true

class HTML

  def table(data)
    table_html = JS.global[:document].createElement("table")
    thead = JS.global[:document].createElement("thead")
    header_row = JS.global[:document].createElement("tr")
    header_row.setAttribute('id', "0")
    cell_height = 50

    data.first.keys.each do |header|
      th = JS.global[:document].createElement("th")
      th[:textContent] = header.to_s
      header_row.appendChild(th)
    end
    thead.appendChild(header_row)
    table_html.appendChild(thead)
    tbody = JS.global[:document].createElement("tbody")
    data.each_with_index do |row, row_index|
      tr = JS.global[:document].createElement("tr")
      tr.setAttribute('id', row_index.to_s)
      row.values.each_with_index do |cell, cell_index|
        td = JS.global[:document].createElement("td")
        td.setAttribute('id', "#{row_index}_#{cell_index}")
        td[:style][:border] = "1px solid black"
        td[:style][:overflow] = "auto"
        td[:style][:backgroundColor] = "white"
        td[:style][:boxShadow] = "10px 10px 5px #888888"
        td[:style][:width] = "#{cell_height}px"
        td[:style][:height] = "#{cell_height}px"
        td[:style][:overflow] = 'hidden'
        if cell.instance_of? Atome
          cell.fit(cell_height)
          html_element = JS.global[:document].getElementById(cell.id.to_s)
          td.appendChild(html_element)
          html_element[:style][:transformOrigin] = "top left"
          html_element[:style][:position] = "relative"
          cell.top(0)
          cell.left(0)
        else
          td[:textContent] = cell.to_s
        end

        tr.appendChild(td)
      end
      tbody.appendChild(tr)
    end
    table_html.appendChild(tbody)
    JS.global[:document].querySelector("##{@id}").appendChild(table_html)
  end


  def table_clean(cell_coordinates)

    row_index, cell_index = cell_coordinates[:cell]
    cell_id = "#{row_index}_#{cell_index}"
    cell_element = JS.global[:document].getElementById(cell_id)
    if cell_element.nil?
      return
    end
    cell_element[:textContent] = ""
  end



end

new({ atome: :matrix })
new({ particle: :format })
new({ particle: :border })
# new({ particle: :cell }) do |value, user_proc|
#   row_nb = value[0]
#   column_nb = value[1]
#   alert data[row_nb][data[row_nb].keys[column_nb]]
#   # alert data[column_nb].keys[row_nb]
# end
# new({ particle: :cells }) do |value, user_proc|
#   # instance_exec
#   # alert
#   #   grab(parent).instance_exec(content, &bloc)
#   user_proc.call(value)
# end

new({ particle: :clean }) do |params|
  cell=params[:cell]
  row_nb = cell[0]
  column_nb = cell[1]
  data[row_nb][data[row_nb].keys[column_nb]]="" # we remove the data from the cell
  params
end

new({ renderer: :html,method: :clean }) do |params|
  # html.clean
end

new({ particle: :get }) do |params|
  cell=params[:cell]
  row_nb = cell[0]
  column_nb = cell[1]
  data[row_nb][data[row_nb].keys[column_nb]] # we get the content of the cell
end

new({ method: :clean, renderer: :html, type: :hash }) do |params|
  html.table_clean(params)
end

new({ particle: :insert }) do |params|

  content= params[:content]
  cell=params[:cell]
  row_nb = cell[0]
  column_nb = cell[1]
  data[row_nb][data[row_nb].keys[column_nb]]=content # we remove the data from the cell
  params
end

new({ method: :insert, renderer: :html, type: :hash }) do |params|
  html.table_insert(params)
end

new({ particle: :remove }) do |params|
  # puts "params are #{params}"
end

new({ method: :remove, renderer: :html, type: :hash }) do |params|
  html.table_remove(params)
end

new({ particle: :sort }) do |params|
  # puts "params are #{params}"
end

new({ method: :sort, renderer: :html, type: :hash }) do |params|
  html.table_sort(params)
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
             left: 333, top: 0, width: 300, smooth: 15, height: 900, overflow: :scroll, data: [
    { dfgdf: 1, name: 'Alice', age: 30, no: 'oko', t: 123, r: 654, f: 123, g: 654, w: 123, x: 654, c: 123, v: 654 },
    { id: 2, name: 'Bob', age: 22 },
    { dfg: 3, name: 'Vincent', age: 33, no: grab(:my_cirle) },
    { dfgd: 3, name: 'Roger', age: 18, no: image(:red_planet) }

  ]
           })

# tests
m.color(:orange)
m.border({ thickness: 5, color: color(:blue), pattern: :dotted })

m.get({ cell: [1, 1] })
m.clean({ cell: [1, 1] })

m.insert({ cell: [2, 2], content: 'super**********' })




# m.insert({ column: { before: 2, id: :new_col } })
# m.insert({ row: { before: 1, id: :new_row } })
# m.remove({ column: 3 })
# m.remove({ row: 3 })
# m.insert({ row: { before: 1, id: :new_row } })
# m.sort({ column: 3 })

# # cell.fusion()