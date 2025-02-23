new({ particle: :brush }) do |params, _bloc|
  params
end
new({ method: :brush, type: :hash, renderer: :html }) do |params, _user_proc|
  html.brush(params)
end

new({ particle: :line }) do |params, _bloc|
  params
end
new({ method: :line, type: :hash, renderer: :html }) do |params, _user_proc|
  html.line(params)
end
new({ molecule: :canvas }) do |params, _bloc|

  new_id = params.delete(:id) || identity_generator

  default_parent = if self.instance_of?(Atome)
                     id
                   else
                     :view
                   end
  attach_to = params[:attach] || default_parent
  renderer_found = grab(attach_to).renderers
  drawing = Atome.new({ renderers: renderer_found, width: '100%', height: '100%', id: new_id, type: :draw, color: { alpha: 0 }, attach: attach_to }.merge(params))
  drawing
end
b = box({})
b.touch(true) do
  alert :cool
end
v = grab(:view)
b = v.canvas({ id: :poilu, })

# brush type: pencil, circle, pattern, spray
#  shape type: circle, square, triangle,

# b.brush({ thickness: 33, type: :pencil, id: :the_brush, shape: :triangle, color: { blue: 1, green: 1, alpha: 0.7 } })
# wait 33 do
  b.line({ thickness: 18, color: :black , color: :red})
# end

# end

# alert b.type

# list = Atome.new({ renderers: [:html], id: :tutu, type: :text, color: { alpha: 0 }, attach: :view })

