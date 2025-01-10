# frozen_string_literal: true

m=matrix({  id: :my_table, left: 330, top: 0, width: 500, height: 399, smooth: 8, color: :yellowgreen,
            cells: {
              particles: { margin: 9, color: :red, smooth: 9, shadow: { blur: 9, left: 3, top: 3,id: :cell_shadow } }
            }
         })

m.cells do |el|
  group(el)
  group.color(:white).rotate(22).text(:hello)
end

m.cells(["my_table_2", 9, "my_table_5"]) do |el|
  group(el)
  group.color(:red).rotate(33)
end


mm=matrix
#
mm.cells do |el|
  group(el)
  group.color(:yellowgreen).rotate(33)
end



mm.cells.each do |el|
  el_found=grab(el)
  el_found.rotate(22).text(:hello).color(:red)
end