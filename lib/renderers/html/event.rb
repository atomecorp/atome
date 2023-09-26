# frozen_string_literal: true

def browser_drag_move(params, atome_id, atome, proc)
  atome.drag_move_proc = proc
  atome_js.JS.drag(params, atome_id, atome)
end

new({ method: :drag, type: :symbol, renderer: :html }) do |options, user_bloc|
  options.each do |_option, params|
    # puts "method : #{method}"
    html.event(:drag, params, user_bloc)
  end
end

new({ method: :touch, type: :integer, renderer: :html }) do |options, user_bloc|
  options.each do |_option, params|
    html.event(:touch, params, user_bloc)
  end
end

new({ method: :over, type: :integer, renderer: :html }) do |options, user_bloc|
  options.each do |_option, params|
    html.event(:over, params, user_bloc)
  end
end
