# frozen_string_literal: true

Atome.new(container: {id: :element14, type: :element ,data: :hello, renderers: []})

element(data: :hello_world)
puts "atomes are: #{Universe.atomes.keys}"