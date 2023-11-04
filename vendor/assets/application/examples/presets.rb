# frozen_string_literal: true

b=box
b.preset({ circle:  {type: :shape, :width=>99, :height=>99, :smooth=>"100%", color: :red, :left=>100, :top=>100, :clones=>[]}})
b.preset(:circle)
puts " b preset is : #{b.preset}"