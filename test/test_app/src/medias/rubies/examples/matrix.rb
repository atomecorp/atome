# frozen_string_literal: true

params = {

  id: :my_table, left: 0, top: 0, width: 500, height: 399, smooth: 8, color: :yellowgreen,
  columns: { count: 8,
             titles: { 1 => :col1, 3 => :mycol },
             data: { 3 => :col_content },
             actions: { 2 => { touch: :the_action } },
             particles: { color: :blue }
  },
  rows: { count: 6,
          titles: { 1 => :my_first_row, 5 => :other_row },
          data: { 0 => :col_content },
          actions: {},
          particles: { shadows: :black }
  },
  cells: {
    particles: { margin: 9, color: :blue, smooth: 9, shadow: { blur: 9, left: 3, top: 3,id: :cell_shadow } }
  },
  exceptions: {
    columns: {
      fusion: { 1 => [3, 5], 7 => [2, 5] }
    },
    rows: {
      divided: { 1 => 3 },
      fusion: { 2 => [0, 3], 5 => [2, 5] }
    }
  }
}
m = matrix(params)

found = m.columns(5) do |el|
  el.color(:yellow)
end

m.rows(3) do |el|
  el.color(:orange)
end

m.rows(1) do |el|
  el.color(:lightgray)
end

found.data.each do |el|
  el.color(:red)
end

# found.data[0..2].each do |el|
#   el.color(:cyan)
# end
#
grab(:my_table_21).color(:pink)
grab(:my_table_26).color(:purple)
# m.cells([20, 5]).rotate(15)
# m.cell(9).color(:black)
# test = m.cells([23, 26])
# test.color(:blue)
# m.columns(6).data[0..3].color(:white)

grab(m.id).drag({ move: true }) do |e|
  puts e
end
# wait 1 do
#   m.add_columns(3)
#   m.rows(3) do |el|
#     el.color(:orange)
#   end
#     wait 1 do
#       m.add_rows(4)
#       m.rows(1) do |el|
#         el.color(:lightgray)
#       end
#       wait 1 do
#         found.data.each do |el|
#           el.color(:red)
#         end
#         m.resize(330, 300)
#
#         m.fusion(rows: { 2 => [0, 3], 3 => [2, 5] })
#       end
#     end
# end

#
# m.fusion(columns: { 3=>  [3, 5], 4 => [2, 5] })
# m.fusion(rows: { 0 => [0, 3], 3 => [5, 9] })
# # m.override( {
# #              columns: { number: [ 0, 3 ] ,width: 200},
# #              rows: { number: [ 1, 4 ] ,height: 200},
# #            })
# m.last(:rows) do |el|
#   el.color(:violet)
# end
# m.divide( rows: {1 => 3})
# m.cell(9).box({left: 0, top: 0, id: :the_big_one, width: 66, height: 66, color: :black})
# m.cell(9).content([box({ left: 0, top: 0, id: :another_one, width: 66, height: 66, color: :black })])





