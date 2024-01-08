# frozen_string_literal: true

new({ particle: :smooth })


new({ particle: :blur }) do |params|
  # alert params
  { value: params, affect: :self } unless params.instance_of?(Hash)
  # params
end