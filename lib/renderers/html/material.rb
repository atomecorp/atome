# frozen_string_literal: true

new({ method: :overflow,renderer: :html,  type: :string }) do |params, bloc|
  # alert params
 html.overflow(params,bloc)
end