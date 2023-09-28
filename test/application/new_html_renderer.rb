######## tests

############ user objects ######

# s_c = grab(:shape_color)
#
# # Atome.new(
# #   { renderers: default_render, id: :my_test_box, type: :shape, width: 100, height: 100, attach: [:view],
# #     left: 120, top: 0, apply: [:shape_color],attached: []
# #   }
# # )
# # a = Atome.new(
# #   { renderers: default_render, id: :my_test_box, type: :shape, attach: [:view], apply: [:shape_color],
# #     left: 120, top: 0, width: 100, height: 100, overflow: :visible, attached: []
# #   }
# #
# # )
# a = Atome.new(
#   { renderers: default_render, id: :my_shape, type: :shape, attach: [:view], apply: [:shape_color],
#     left: 120, top: 0, width: 100, height: 100, overflow: :visible, attached: []
#   }
#
# )
#

# s_c.red(0.2)
# s_c.blue(0)
# s_c.green(0)
# a.top(99)
# aa.unit[:width] = "%"
# aa.width(88)
# a.smooth(33)
# a.web({ tag: :span })
# aa.smooth(9)
# # FIXME:  add apply to targeted shape, ad affect to color applied
# # box
# # circle
# # text(:hello)
# # Atome.new({  :type => :shape, :width => 99, id: :my_id, :height => 99, :apply => [:box_color], :attach => [:view],
# # :left => 300, :top => 100, :clones => [], :preset => :box, :id => "box_12", :renderers => [:html] })
# aa.unit[:left] = :inch
# aa.unit({ top: :px })
# aa.unit({ bottom: '%' })
# aa.unit[:bottom] = :cm
# aa.unit[:right] = :inch
# aa.unit[:top] = :px
# puts " unit for aa is : #{aa.unit}"
#
# # new({ atome: :poil })
# # new({ atome: :poil })
# # poil(:data)
# # piol
#
# # new({ renderer: :html, method: :text, type: :hash }) do |value, _user_proc|
# #   alert value
# # end
# # ###################### uncomment below
# Atome.new(
#   { renderers: default_render, id: :my_txt, type: :text, width: 100, height: 100, attach: [:my_shape],
#     data: "too much cool for me", apply: [:text_color], attached: []
#   }
# )
#

############## tests
aa = Atome.new(
  { renderers: [:html], id: :my_shape2, type: :shape, attach: [:view], apply: [:box_color],
    left: 120, top: 30, width: 100, height: 100, overflow: :visible, attached: [:my_shape]

  }
)

# # Atome.class_variable_set(:@@variable_de_classe_externe, "ma valeur")
aa.touch(:long) do
  puts "cooly long touched!"
end

aa.touch(:double) do
  puts "cooly double touched!"
end

aa.touch(:up) do
  puts "cooly up touched!"
end

aa.touch(:down) do
  puts "cooly down touched!"
end
# over
aa.touch(true) do
  puts "cooly touched!"
end

aa.over(:enter) do
  puts "cool enter"
end

aa.over(true) do
  puts "true over"
end
aa.over(:leave) do
  puts "cool leave"
end
#
# b = box({ id: :titi })
# t = b.text({ data: :orangered, id: :the_orange, attach: [:my_txt] })
# aa.text({ data: :hello, id: :the_text })
# b.color(:orange)
# # ###################### uncomment above
#
# # c = circle
# # c.color(:blue)
#
# tt = text({ data: :cool, id: :new_text })
# tt.left(333)
# # alert tt.left
# tt.color(:red)
# # c.left(333)
#
#
# puts Atome.class_variable_get(:@@post_touch)
# alert Atome.class_variable_get(:@@variable_de_classe_externe)
# aa.touch(:kool)
# text(:hello_you)
#
# ################### works below
# def wait(time, &proc)
#   if time == :kill
#     # Annuler le setTimeout actuel
#     JS.eval("clearTimeout(window.myTimeoutId);")
#   else
#     # Enregistrement de la fonction de rappel pour qu'elle soit accessible depuis JavaScript
#     JS.global[:myRubyCallback] = proc
#
#     # Utilisation de JS.eval pour appeler setTimeout en JavaScript et stocker l'ID de timeout
#     JS.eval("window.myTimeoutId = setTimeout(function() { myRubyCallback(); }, #{time});")
#   end
# end
#
# wait(2000) do
#   alert "Temps écoulé !"
# end
#
# # wait(:kill)
# ################### works above

# ##### wait usage
# # Simple usage
# wait 1 do
#   alert :good
# end
#
# # Advanced usage
wait_id = wait(4, 'timeout1') do
  puts "Ceci est affiche  après 4 secondes."
end
#
wait(5, 'timeout2') do
  puts "Ceci est affiche  après 5 secondes."
end

wait(3) do
  puts "Ceci est affiche après 3 secondes."
end

wait(1) do
  wait(:kill, wait_id)
end
#
# sleep(2)
# wait(:kill, 'timeout1')
# alert aa.inspect

# text({id: 'phone_nb', data: :hello,component: {left: 333}})
#  grab(:phone_nb).color(:pink)
# alert grab('phone_nb')
# wait 2 do
#   alert grab(:phone_nb)
#   grab(:phone_nb).color(:green)
# end
############# crash
the_text = text({ data: [
  '74 Bis Avenue des Thermes - Chamalieres, tel: ',
  { data: '06 63 60 40 55!', width: :auto, component: { size: 63, top: 30 }, top: 0, color: :blue, id: :phone_nb },
  { data: 'la suite', width: :auto }, :super, :cool, :great
], center: true, top: 120, width: 955, id: :my_x_text, component: { size: 11 } })
# grab('phone_nb').top(55)
# alert grab('phone_nb')
grab('phone_nb').color(:red)
grab('phone_nb').touch(true) do
  grab('phone_nb').color(:green)
end
wait 2 do
  # alert grab('phone_nb')
  grab('phone_nb').component({ size: 9 })
  grab('phone_nb').color(:yellow)
end
wait 4 do
  # alert grab('phone_nb')
  grab('my_x_text').component({ top: 229 })
end
# TODO : Important make it work below add uniq id to wait
wait 3 do
  puts 'check passed'
end

############# crash
# the_text=text({ data:[ ' text de verif',visual:{size: 37, top: 0, width: 555}, id: :my_new_text, width: 222] })
# the_text.visual({size: 88})
the_text.color(:green)
text(:kool)
t=text({ data: :hello })
# alert t.class
wait 2 do
  t.data('hi')
end
the_one=circle(markup: :h1)
wait 3 do
  the_one.markup(:div)
end

#
# # Done: implement complex concatenated texts
# # TODO: rename particle as property
# # the_text.color(:yellow)

############# drag
aa.drag(true)
# aa.drag(:end)

cc = aa.circle
cc.drag(true) do |event|
  puts event.to_s
  dx = event[:dx]
  dy = event[:dy]
  puts "dx : #{dx}: dy: #{dy}"
  puts event.class
  puts '----'
  puts event[:clientX]
  puts event[:pageX]
end

# TODO : drag and drop api
# TODO : animation api
# TODO : video api
# TODO : shadow api
# TODO : remove @atome in atome/lib as it store instance variable twice
# TODO : unify proc usage using, for drag: drag_proc_option_start

b=box({id: :tutu})
b.color(:yellow)
# b.top do
#   puts 'ok'
# end
#
# alert b.inspect


