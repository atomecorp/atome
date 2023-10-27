# frozen_string_literal: true

gen = generator({ id: :genesis, build: {top: 66, copies: 1} })
gen.build({ id: :bundler, copies: 32, color: :red, width: 33, height: 44,  left: 123, smooth: 9, blur: 3, attach: [:view] })
grab(:bundler_1).color(:blue)



#   Atome.new(
#   { renderers:  [:html], id: :atomix, type: :element, tag: { system: true }, attach: [], attached: [] }
# )
#
#
# {:id=>:eDen, :type=>:element, :renderers=>[], :tag=>{:system=>true}, :attach=>[], :attached=>[]}
# {:renderers=>[], :id=>:eDen, :type=>:element, :tag=>{:system=>true}, :attach=>[], :attached=>[]}