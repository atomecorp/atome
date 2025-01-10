# frozen_string_literal: true

# TODO : make this work : b.shadow({color: :red})

b = box({ id: :the_box, left: 99, top: 99 })




s = b.shadow({ renderers: [:browser], id: :shadow2, type: :shadow,
               left: 3, top: 9, blur: 9, direction: :inset,
               red: 0, green: 0, blue: 0, alpha: 1
             })

 s.left(16)

# s.color(:red)
# wait 1 do
#   s.attach([:the_box])
#   # or
#   # b.children([:shadow2])
#   wait 1 do
#     s.blur(9)
#     wait 1 do
#       wait 2 do
#         s.direction('')
#         s.green(0.007)
#         s.left(14)
#         wait 1 do
#           s.delete(true)
#         end
#       end
#       s.left(44)
#       s.green(0.7)
#     end
#   end
# end
#
# wait 3 do
#   b.shadow({ blur: 33 })
#   wait 2  do
#     b.shadow({ blur: 3 })
#   end
# end

wait 2 do
  s.red(1)
end

wait 4 do

  puts "-----------> now!!!!!!"
  b.shadow({ green: 1 })
  # c2=color(:red)
  # b.shadow.attach(c2.id)
end


edition = <<~STR
  <path id="p1" d="M257.7 752c2 0 4-0.2 6-0.5L431.9 722c2-0.4 3.9-1.3 5.3-2.8l423.9-423.9c3.9-3.9 3.9-10.2 0-14.1L694.9 114.9c-1.9-1.9-4.4-2.9-7.1-2.9s-5.2 1-7.1 2.9L256.8 538.8c-1.5 1.5-2.4 3.3-2.8 5.3l-29.5 168.2c-1.9 11.1 1.5 21.9 9.4 29.8 6.6 6.4 14.9 9.9 23.8 9.9z m67.4-174.4L687.8 215l73.3 73.3-362.7 362.6-88.9 15.7 15.6-89zM880 836H144c-17.7 0-32 14.3-32 32v36c0 4.4 3.6 8 8 8h784c4.4 0 8-3.6 8-8v-36c0-17.7-14.3-32-32-32z"/>
STR
v=vector({left: 300, width: 300, height: 300, definition: edition})
# v.color(:red)
v.shadow({ renderers: [:browser], id: :shadow7, type: :shadow,
           left: 3, top: 9, blur: 9, direction: :inset,
           red: 0, green: 0, blue: 0, alpha: 1
         })

v.shadow({ renderers: [:browser], id: :shadow8, type: :shadow, real: true,
           left: 3, top: 9, blur: 9, direction: :inset,
           red: 0, green: 0, blue: 0, alpha: 1
         })
b=box({top: 300})

wait 4 do
  b.fasten(:shadow7)
  v.fasten(:shadow7)
end


wait 6 do
  b.fasten(:shadow8)
  v.fasten(:shadow8)
end