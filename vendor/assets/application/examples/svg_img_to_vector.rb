# frozen_string_literal: true

grab(:black_matter).image({ path: 'medias/images/icons/color.svg', id: :atomic_logo, width: 33, left: 333 })
img=vector({ width: 333, height: 333, id: :my_placeholder })
A.extract_svg({ source: :atomic_logo, target: :my_placeholder })

wait 2 do
  puts "test is : #{A.svg}"
  alert "img is : #{img.data}"
  new_vector= A.convert_svg(A.svg)
  alert "new_vector: #{new_vector}"
  img.color(:cyan)
  wait 2 do
    grab(:atomic_logo).delete(true)
  end
end



