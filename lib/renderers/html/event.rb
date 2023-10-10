# frozen_string_literal: true


new({ method: :drag, type: :symbol, renderer: :html }) do |options, user_bloc|
  options.each do |_option, params|
    html.event(:drag, params, user_bloc)
  end
end

new({ method: :touch, type: :integer, renderer: :html }) do |params, user_bloc|
  # alert options
  # options.each do |option, params|
  #   puts "#{params}"
    html.event(:touch, params, user_bloc)
  # end
end

new({ method: :over, type: :integer, renderer: :html }) do |options, user_bloc|
  options.each do |_option, params|
    html.event(:over, params, user_bloc)
  end
end
