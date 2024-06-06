# frozen_string_literal: true
# wait 0.5 do
#   JS.eval("console.clear()")
# end
########################### Test  check and verification below ############################

new({ tool: :combined }) do |params|

  active_code = lambda {
    puts :alteration_tool_code_activated
  }

  inactive_code = lambda { |param|
    puts :alteration_tool_code_inactivated
  }
  pre_code = lambda { |params|
    puts "pre_creation_code,atome_touched: #{:params}"

  }
  post_code = lambda { |params|
    puts "post_creation_code,atome_touched: #{:params}"

  }

  zone_spe = lambda { |current_tool|
    # puts "current tool is : #{:current_tool} now creating specific zone"
    # b = box({ width: 33, height: 12 })
    # b.text({ data: :all })

  }

  {
    activation: active_code,
    inactivation: inactive_code,
    alteration: { width: 22, blur: 3 },
    pre: pre_code,
    post: post_code,
    zone: zone_spe,
    icon: :color,
    int8: { french: :couleur, english: :color, german: :colorad } }

end

new({ tool: :box }) do |params|

  active_code = lambda {
    puts :creation_tool_code_activated
  }

  inactive_code = lambda { |atomes_treated|
    puts :creation_tool_code_inactivated

  }
  pre_creation_code = lambda { |params|
    puts "pre_creation_code : atome_touched : #{:params} "

  }

  post_creation_code = lambda { |params|
    puts "post_creation_code,atome_touched: #{:params}"
  }

  { creation: { box: { color: :blue, width: 66, height: 66 } },
    activation: active_code,
    inactivation: inactive_code,
    pre: pre_creation_code,
    post: post_creation_code,
    int8: { french: :formes, english: :shape, german: :jesaispas } }

end

new({ tool: :project }) do
  active_code = lambda {

    alert :get_projects_now
    # if  Atome.selection.instance_of? Array
    # end
    # Atome.selection.each do |atome_id_to_treat|
    #   # #   # reinit first to avoid multiple drag event
    #   # #   grab(atome_id_to_treat).drag(false)
    # end
    # drag_remove
    # puts :alteration_tool_code_activated
  }
  { activation: active_code }
end

new({ tool: :move }) do
  active_code = lambda {
    puts 'move activated1'
  }
  move_code = lambda {
    drag(true)
  }
  inactive_code = lambda { |data|
    data[:treated].each do |atome_f|
      atome_f.drag(false)
    end
  }

  { activation: active_code,
    alteration: { event: move_code },
    inactivation: inactive_code}
end

new({ tool: :drag }) do
  active_code = lambda {
    puts 'move activated2'
  }
  move_code = lambda {
    drag(true) do
      puts left
    end
  }

  { activation: active_code, alteration: { event: move_code } }
end

new({ tool: :touch }) do
  move_code = lambda {
    touch(:down) do
      color(:red)
    end
  }
  { alteration: { event: move_code } }
end

new({ tool: :toolbox1 }) do
  active_code = lambda {
    toolbox({ tools: [:combined], toolbox: { orientation: :ew, left: 90, bottom: 9, spacing: 9 } })
  }
  { activation: active_code }
end

new({ tool: :color }) do
  active_code = lambda {
    puts 'color activated1'
  }
  color_code = lambda {
   # color(:green)
   # tools_values
  }
  inactive_code = lambda { |data|
    data[:treated].each do |atome_f|
      # atome_f.drag(false)
      # atome_f.color(:green)
    end
  }

  { activation: active_code,
    alteration: { event: color_code },
    inactivation: inactive_code,
    target: :color,
    particles: { red: 0, green: 0.5, blue: 1, alpha: 1 }}
end

# Universe.tools_root= {tools: [:blur, :box, :test, :toolbox1],toolbox: { orientation: :ew, left:90 , bottom: 9, spacing: 9} }
Universe.tools_root = {id: :root_tools, tools: [:box, :drag, :touch,:color, :move, :toolbox1], toolbox: { orientation: :ew, left: 9, bottom: 9, spacing: 9 } }
puts "above we added an id because each tool may be in many toolbox and have an uniq ID"
Atome.init_intuition

b = box({ id: :the_test__box, selected: true })
circle({ left: 90, id: :the_test_circle, selected: true })
b.touch(true) do
  if b.width == 170
    b.width(55)
  else
    b.width(170)
  end

end

# box({id: :the_box})
# circle({left: 90, id: :the_circle})
# alert b.aid

# b=box
#
# active_code = lambda {
#   b=grab(:view).circle({color: :red, left: 88})
#   b.touch(true) do
#     alert :kool
#   end
# }
# b.touch(true) do
#   # c=circle({color: :red})
#   active_code.call
#   # c.touch(true) do
#   #   # active_code.call
#   # end
# end

# ################### check below

# b = box({ left: 123, top: 66, selected: false, id: :the_box, color: :green })
# b.touch(:down) do
#   puts " on touch : #{Universe.allow_localstorage}"
# end
# b.resize(true) do
#   puts :good!
# end
# the_circ = circle({ left: 123, top: 120, selected: false, id: :the_circle })
#
# the_circ.touch(:down) do |params|
#   puts " down : params: #{params}, id: #{the_circ.id}"
# end
#
# the_circ.touch(:up) do
#   puts "up :kool"
# end
# the_circ.drag(true) do
#   puts "drag : now"
# end
#
# bb = box({ left: 333, width: 120, selected: false, id: :big_box })
#
# b = box({ id: :the_big_boxy })

#################@
# text({ data: :hello, selected: true, left: 120, id: :texting, blur: 12 })
# text({data: :hello, left: 120, id: :texting})
# Universe.tools.each_with_index do |(tool_name, bloc), index|
#  Atome.instance_exec(&bloc) if bloc.is_a?(Proc)
#   # alert "#{tool_name} : #{tool_content}"
#   # alert b.id
# end

# wait 2 do
#   # c.preset( {:box=>{:width=>39, :height=>39, :apply=>[:box_color], :left=>0, :top=>0}} )
#   c.preset( :box )
# end
# b=box({left: 333, top: 333})
# b.touch(true) do
#   alert Atome.selection
# end
# grab(:the_texting).color(:white)
# grab(:the_texting).left(33)
# grab(:the_texting).top(133)
# grab(:the_texting).width(133)
# grab(:the_texting).top(133)
# grab(:the_texting).data(:kool)
# grab(:the_texting).type(:text)
# grab(:the_texting).rotate(:text)

# b=box
# b.touch(true) do
#   puts :ok
#   # alert b.instance_variable_get('@touch')
#   # alert b.instance_variable_get('@touch_code')
#   b.touch(false)
#   wait 3 do
#     puts :ready
#     b.touch(true) do
#       puts :kool
#     end
#     # alert b.touch
#     # alert b.instance_variable_get('@touch')
#     # alert b.instance_variable_get('@touch_code')
#   end
# end

# A.html.record

# A.html.record

# edition = "M257.7 752c2 0 4-0.2 6-0.5L431.9 722c2-0.4 3.9-1.3 5.3-2.8l423.9-423.9c3.9-3.9 3.9-10.2 0-14.1L694.9 114.9c-1.9-1.9-4.4-2.9-7.1-2.9s-5.2 1-7.1 2.9L256.8 538.8c-1.5 1.5-2.4 3.3-2.8 5.3l-29.5 168.2c-1.9 11.1 1.5 21.9 9.4 29.8 6.6 6.4 14.9 9.9 23.8 9.9z m67.4-174.4L687.8 215l73.3 73.3-362.7 362.6-88.9 15.7 15.6-89zM880 836H144c-17.7 0-32 14.3-32 32v36c0 4.4 3.6 8 8 8h784c4.4 0 8-3.6 8-8v-36c0-17.7-14.3-32-32-32z"
#
# v = vector({left: 99, data: { path: { d: edition, id: :p1, stroke: :black, 'stroke-width' => 37, fill: :red } } })
# v2 = vector({top: 66,data: { circle: { cx: 300, cy: 300, r: 340, id: :p2, stroke: :blue, 'stroke-width' => 35, fill: :yellow } } } )
# wait 1 do
#   v.color(:blue)
#   wait 1 do
#     v2.color(:blue)
#   end
# end

s = box({ color: :red, left: 123, top: 123 })
# tap event content :
# 	1.	Common Properties:
# 	•	target: The element that is being interacted with.
# 	•	interaction: The Interaction object that the event belongs to.
# 	•	x0, y0: The page coordinates where the interaction started.
# 	•	clientX0, clientY0: The client coordinates where the interaction started.
# 	•	dx, dy: The change in coordinates since the last event.
# 	•	velocityX, velocityY: The velocity of the pointer.
# 	•	speed: The speed of the pointer.
# 	•	timeStamp: The time when the event was created.
# 	2.	Tap Specific Properties:
# 	•	pointerId: The identifier of the pointer used for the tap.
# 	•	pageX, pageY: The X and Y coordinates of the event relative to the page.
# 	•	clientX, clientY: The X and Y coordinates of the event relative to the viewport.

s.touch(true) do |event|
  x_pos = event[:clientX]
  { left: '20', alert: 'hello! and big bisous!!, position : ' + x_pos.to_s }
end
####### empty local storage :
JS.eval("localStorage.clear();")
############## soluce below

# def verif(val, &pro)
#   datas=  pro.call(val)
#   alert  datas.delete(:left)
#   datas.each do |k,v|
#     send(k,v)
#   end
# end
#
# verif(val=33) do |var|
#   # puts left = '20' + var.to_s
#   {left: '20' + var.to_s, alert: 'hello! and big bisous!!'}
# end