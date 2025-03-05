# frozen_string_literal: true

menu_svg=<<str
  <svg id="mySvg" xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 50 50">
    <circle cx="20" cy="20" r="20" fill="blue" stroke="black" stroke-width="2"/>
  </svg>
str


converter = Svg_to_atome.new
converter_data = converter.convert(menu_svg)
 vector_data=converter_data[0]
 vector_view_box=converter_data[1] #if needed
b=box({width: 120, height: 120, id: :the_box})
b.vector({ data: vector_data , id: :the_svg, width: '100%', height: '100%', drag: true})
