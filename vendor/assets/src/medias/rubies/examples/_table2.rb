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
    # data: { 0 => :here, 2 => "hello", 4 => :hi, 5 => :good, 7 => :super },
    # actions: { 2 => { touch: :my_lambda } },
    particles: { margin: 9, color: :blue, smooth: 9, shadow: { blur: 9, left: 3, top: 3 } }
  },
  exceptions: {
    columns: {
      # divided: { 2 => 3 },
      fusion: { 1 => [3, 5], 7 => [2, 5] }
    },
    rows: {
      divided: { 1 => 3 },
      fusion: { 2 => [0, 3], 5 => [2, 5] }
    }
  }
}


matrix(params)
# matrix({ id: :totot,columns: { count: 24 } })
# matrix
