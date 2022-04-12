# require "opal-jquery"

# class Element
#   def self.create(tag = 'div', opt = {})
#     `jQuery('<'+tag+'/>',opt.$to_n())`
#   end
# end
#
# def box(params = {})
#   # el = Element.new(:div)
#   el = Element.create(:div, { id: 'some_big_id',
#                               class: 'some-class some-other-class',
#                               title: 'now this div has a title!' })
#   # el.text("kjh")
#   Element.find('#user_view').append(el)
#   el.css(:color, :red).css( "box-shadow": "0px 0px 9px red")
#     .css(:width, 33).css(:height, 33).css(:position, "absolute").css(:left, "33px").css(:top, "33px")
#     .css( 'border-radius', '3px 6px 3px 6px')
#
#   el.on(:click) do
#     el.css("background-color", "yellowgreen")
#     el.text(el.css("background-color"))
#   end
# end
# alert :kool
# box({ width: 33, height: 33, smooth: 6, shadow: { blur: 6, x: 6, y: 6, invert: false, thickness: 0, bounding: true, color: :black } })



def toto(e)
  e.prevent
  e.on.inner_text = "Super Clicked!"
end

$document.on(:mousedown, "#good") do |e|
  toto(e)
end
$document.on(:touchstart, "#good") do |e|
  toto(e)
end

verif = <<-STR
$document.ready do
	DOM {
	div.info {
	  span.red "Opal eval cooked up!"
	}
	}.append_to($document.body)
  end
STR

eval(verif)


$document.body.style.apply {
  background color: 'black'
  color 'orange'
  font family: 'Verdana'
}
$document.ready do
  DOM {
    div.info {
      i=0
      while i< 20
        i+=1
        span(id: "good").red "Opal cooked up, click me #{i}"
        div(id: "hook").red "lllll#{i} --"
      end
    }
  }.append_to($document["user_view"])

  # alert($document.body.id)
  # $document.getElementById("hook").style.color("red")
  # bb=$document.find('header')
  bb=`document.getElementById('hook')`
  # a=	$document.get_element_by_id(:hook)
  a=	$document[:hook]

  elem = $document.at_css(".red").style(color: :yellow)

  $document.on :click do |e|
    elem.style(color: :yellowgreen)
    # elem.style.apply {
    # 	background color: 'blue'
    # 	color 'green'
    # 	font family: 'Verdana'
    # }
    # a.style.apply {
    # 		  background color: 'red'
    # 		  color 'black'
    # 		  font family: 'Verdana'
    # 		}
  end

  # bb =$document.id='hook'
  # bb= $document["hook"]
  #  bb.on.inner_text"jsqhdgfjqhsdgfjqhsgdjhqsg Clicked!"
  # bb.style.apply {
  # 	background color: 'black'
  # 	color 'orange'
  # 	font family: 'Verdana'
  # }

end

$document.body.style.apply {
  background color: 'black'
  color 'orange'
  font family: 'Verdana'
}


def box(params={})
  DOM do
    el=div(id: "hook")
    el( ",jb,jb")
  end.append_to($document["user_view"])

end

box

e=$document.at_css("#hook")
e.style { background color: 'lime' }
$document.at_css("#hook").style(color: :red)
# Example 2
DOM do
  div(id: "hook").red "lllll"
  div(id: "poil").red "kool"
end.append_to($document["user_view"])
elem = $document.css("#poil").style(color: :orange)

# #Example 3
def box(params = {})
  params = { color: :pink, width: 100, height: 100 }.merge(params)
  DOM do
    div(id: "hook",
        class: :toto,
        style: "background-color: #{params[:color]};
               width: #{params[:width]}px;
               height: #{params[:height]}px;
               box-shadow: #{params[:shadow]};
               ")
      .the_class
  end.append_to($document["user_view"])
end

window_height= $window.view.height/12
window_width= $window.view.width/12
box({ color: :green, shadow: "0px 0px 10px black;" })
$document.body['foo'] = 'bar'


$window.on :resize do |e|
  puts $window.view.height
  puts  $window.view.width
  puts "------"
  # alert  $document.body.width
end

puts $document.search('div').size
# $document.search('div')['foo'] = 'bar'


