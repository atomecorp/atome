# frozen_string_literal: true

grab(:black_matter).image({ path: 'medias/images/icons/color.svg', id: :atomic_logo, width: 33, left: 333 })
img=vector({ width: 333, height: 333, id: :my_placeholder })
A.fetch_svg({ source: :atomic_logo, target: :my_placeholder })
wait 2 do
  img.color(:cyan)
end
# grab(:atomic_logo).delete(true)
