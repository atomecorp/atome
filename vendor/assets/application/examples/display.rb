#  frozen_string_literal: true


# matrix
new({ particle: :display }) do |params|
  unless params.instance_of? Hash
    params = { mode: params, target: :atomes }
  end
  target_found = params[:target]
  mode = params[:mode]
  case mode
  when :list
  when :table
  end
end
b = box
b.display({ mode: :table, target: :particles, structure: {row: 2, column: 8, width: 333, height: 444} , items: {width: :auto,height: 66, rotate: 12 }})
b.display(:table)

# TODO : find how to restore natural display after removing display mode