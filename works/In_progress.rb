JSUtils.load_opal_parser
require './app/scripts/background.rb'
gradient = [{ red: 0.6, green: 0.3, blue: 0.9 }, { red: 0.6, green: 0.3, blue: 0.9 }]
gradient = [{ red: 0.75, green: 0.75, blue: 0.75 }, { red: 0.7, green: 0.7, blue: 0.7 }]
# gradient = [{ red: 0.9, green: 0.9, blue: 0.9 }, { red: 0.9, green: 0.9, blue: 0.9 }]
Background.theme(gradient)

####################### Selector tryout #########################
def open_tool(tool_id, size)
  # animate({
  #        start: { smooth: 0, blur: 0, rotate: 0, color: { red:1, green: 1, blue: 1} },
  #        end: { smooth: 25, rotate: 180, blur: 20, color: { red:1, green: 0, blue: 0} },
  #        duration: 1000,
  #        loop: 1,
  #        curve: :easing,
  #        target: tool_id
  #      })

  animate({
            start: {  shadow: { x: 0, y: size / 15, thickness: 0, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } }},
            end: {  shadow: { x: 10, y: -size / 15, thickness: 3, blur: size / 3, color: { red: 1, green: 0, blue: 0, alpha: 0.7 } }},
            duration: 1000,
            loop: 1,
            curve: :easing,
            target: tool_id
          })

  # animate({
  #           start: {   blur: 0},
  #           end: {   blur: 10},
  #           duration: 1000,
  #           loop: 1,
  #           curve: :easing,
  #           target: tool_id
  #         })
end

tool_name = :scale
size = 33
shadows = [{ x: size / 15, y: size / 15, thickness: 0, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } },
           { x: -size / 15, y: -size / 15, thickness: 0, blur: size / 3, color: { red: 1, green: 1, blue: 1, alpha: 0.7 } }]
tool_style = { type: :tool, content: { points: 4 }, color: { red: 0.9, green: 0.9, blue: 0.9, alpha: 0.15 }, parent: :view, shadow: shadows, blur: {value: 6, invert: true} }

tool = Atome.new(tool_style.merge({ parent: :intuition, atome_id: "tool_" + tool_name, id: "tool_" + tool_name, width: size, height: size, smooth: size / 9 }))
tool.drag(true)
tool.image({ content: tool_name, width: size - size / 2, height: size - size / 2, center: true, color: :black })
boat=image({content: :boat,x: 333, id: :the_boat,atome_id: :the_boat,shadow:{ x: size / 15, y: size / 15, thickness: 0, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } }})


tool.touch do
  open_tool("tool_" + tool_name, size)
  open_tool(boat.id, size)
  read("./medias/e_rubies/tools/#{tool_name}.rb") do |data|
    @scale_tool={options: :verified}
    compile data
  end
end

tool.x(400).y(66)

# b=circle
# b.touch do
#   alert b.inspect
# end
def jq_get(atome_id)
  Element.find("#" + atome_id)
end





read("./medias/e_images/icons/#{tool_name}.svg") do |datas|
  # alert datas
  jq_get(:view).append("<div id='toto' style='left: 96px; width: 89px;background-color: orange;height: 33px'>#{datas}</div>")

  `
  //alert($("#toto").html());
$("#toto").css({ fill: 'red'});
$("#toto").find( "path" ).css({ fill: 'cyan'});
$("#toto").find( "path" ).css({ stroke: 'yellow'});
$("#toto").find( "path" ).css({ strokeWidth: 33});
`

  #   `
  # var draw = SVG().addTo('#view')
  # var a=draw.rect(100, 100).move(100, 50).fill('#f06')
  # a.stroke("red")
  # a.fill("yellowgreen")
  # `
end


def shape(path)
  alert "get shape from file and extarct svg"
end


a=shape("scale")