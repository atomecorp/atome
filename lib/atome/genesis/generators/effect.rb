# frozen_string_literal: true

new({ particle: :smooth, category: :effect, type: :int })


new({ particle: :blur, category: :effect, type: :int }) do |params|
  # alert params
  { value: params, affect: :self } unless params.instance_of?(Hash)
  # params
end