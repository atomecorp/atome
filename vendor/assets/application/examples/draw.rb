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
# b = box({ id: :my_test, width: 300, height: 300, color: :red, attach: :view })
# b.touch(true) do
#   b.alternate({ color: :red, }, { color: :orange })
#
# end
v = grab(:view)
v2 = v.canvas({ id: :my_canvas, })
i = 0
v2.touch(true) do
  if i % 2 == 0
    b.color(:blue)
  else
    b.color(:yellow)
  end
  i += 1

end

# brush type: pencil, circle, pattern, spray
#  shape type: circle, square, triangle,

# v2.brush({ shadow: {},thickness: 33, type: :pattern, id: :the_brush, shape: :triangle, color: { blue: 0, green: 0.3, alpha: 1 } })

js = <<-JS
document.querySelectorAll('.canvas-container, .lower-canvas, .upper-canvas')
  .forEach(el => el.style.pointerEvents = 'none');
document.addEventListener('click', (e) => {
  // Récupérer l'élément cliqué
  const target = e.target;
  // Obtenir le style calculé de l'élément
  const computedStyle = window.getComputedStyle(target);
  // Récupérer la valeur de pointer-events
  const pointerEventsValue = computedStyle.pointerEvents;

  // Afficher le résultat (ici dans la console)
  console.log(`La propriété pointer-events de element clicked est : ${pointerEventsValue}, ${e.id}`);

  // Ou l'afficher via une alerte
  // alert(`La propriété pointer-events de l'élément cliqué est : ${pointerEventsValue}`);
});
JS

# wait 6 do
v2.brush({ shadow: {}, thickness: 33, type: :pencil, id: :the_brush, shape: :circle, color: { blue: 0, green: 0.3, alpha: 1 } })

#   wait 3 do
#
#     v2.line({ shadow: {}, thickness: 16, color: :yellow, pattern: :dotted})
#
#     # v2.line({ edition: true})
#     # #   puts 'stop'
#     # #   JS.eval(js)
#     # v2.line({ edition: false})
#
#     #   v2.line({ edition: true})
#   #   puts 'stop'
#   #   JS.eval(js)
#   # end
# end

# end

# alert b.type

# list = Atome.new({ renderers: [:html], id: :tutu, type: :text, color: { alpha: 0 }, attach: :view })

# Account creation
#
 box({ id: :account_box, width: 300, height: 60, color: :blue, attach: :view })

def message_sender(type, message)

  A.message({ action: type, data: message }) do |response|
    alert response
  end
  # case type
#   when :login_creation
#     A.message({ action: type, data: msg }) do |response|
#       alert response
#     end
#   when :pass_creation
#
#   when :phone_creation
#
#   when :login
#
#
#   when :pas
#
#
# else
#           #
#
#   end

end

def account_creation
  new_user={}
  account_box = grab(:account_box)
  account_box.clear(true)
  A.temporary(:login)

  user_input = account_box.text({ data: 'login', color: :white, width: 255, top: 0, left: 33, edit: true })

  user_input.keyboard(:down) do |native_event|
    event = Native(native_event)
    if event[:keyCode].to_s == '13'
      event.preventDefault()
      user_input.color(:white)
      if A.temporary == :login
        # new_user[:login] = Black_matter.encode(user_input.data)
        new_user[:login] = user_input.data
        user_input.data('password')
        A.temporary(:password)
        back_color = grab(:back_selection)
        text_color = grab(:text_selection)
        back_color.red(1)
        back_color.alpha(1)
        text_color.green(1)
        user_input.component({ selected: true })
      elsif A.temporary == :password
        new_user[:password] = Black_matter.encode(user_input.data)
        A.temporary(:phone)
        user_input.color(:green)
        user_input.data('phone')
        user_input.component({ selected: true })
      elsif A.temporary == :phone
        # new_user[:phone] = Black_matter.encode(user_input.data)
        new_user[:phone] = user_input.data
        message_sender(:user_creation, new_user)
        # phone = Black_matter.encode(user_input.data)
        A.temporary(:send)
        user_input.color(:green)
        user_input.data('sent')
        login_test=account_box.box({ id: :account_button, width: 99, height: 30, color: :yellowgreen, top: 3, left: 150 })
        login_test.text({ data: 'login test', color: :white, top: 1, left: 1 })
        login_test.touch(true) do
          account_login
        end
      end

    else
      user_input.color(:gray)
    end
  end

  user_input.touch(:up) do
    back_color = grab(:back_selection)
    text_color = grab(:text_selection)
    back_color.red(1)
    back_color.alpha(1)
    text_color.green(1)
    user_input.component({ selected: true })
  end
end


def account_login
  user={}
  account_box = grab(:account_box)
  account_box.clear(true)
  A.temporary(:login)

  user_input = account_box.text({ data: 'login', color: :white, width: 255, top: 0, left: 33, edit: true })

  user_input.keyboard(:down) do |native_event|
    event = Native(native_event)
    if event[:keyCode].to_s == '13'
      event.preventDefault()
      user_input.color(:white)
      if A.temporary == :login
        # login = Black_matter.encode(user_input.data)
        login = user_input.data
        user[:login] = login
        A.temporary(:password)
        user_input.data('password')
        back_color = grab(:back_selection)
        text_color = grab(:text_selection)
        back_color.red(1)
        back_color.alpha(1)
        text_color.green(1)
        user_input.component({ selected: true })
      elsif A.temporary == :password
       pass = Black_matter.encode(user_input.data)
           user[:pass] = pass
       message_sender(:user_login, pass)
        A.temporary(:send)
        user_input.color(:green)
        user_input.data('sent')
      end
    else
      user_input.color(:gray)
    end
  end

  user_input.touch(:up) do
    back_color = grab(:back_selection)
    text_color = grab(:text_selection)
    back_color.red(1)
    back_color.alpha(1)
    text_color.green(1)
    user_input.component({ selected: true })
  end
end
# #
# # account_creation
#
#
# c=circle({ id: :the_c, color: :red, top: 0, left: 0, width: 300, height: 60,})
#
# c.touch(true) do
#
#   A.message({ action: :insert, data: { table: :atome,  particles: {left: 777, top: 555} } }) do |data_received_from_server|
#     puts "1 my first insert #{data_received_from_server}"
#   end
#
#   # A.message({ action: :insert, data: {table: :user, } }) do |response|
#   #   alert response
#   # end
#
#     # A.message({ action: :user_login, data: 'poiop' }) do |response|
#     #   alert response
#     # end
#     {} #important to avoid crshes
#   # A.message({ action: :insert, data: { table: :identity, particle: :tit, data: 'dummy' } }) do |data_received_from_server|
#   #   puts "7 test 2 :  #{data_received_from_server}"
#   # end
# end
# new({ particle: :creation, category: :property, type: :hash })
#
