# frozen_string_literal: true

new({ particle: :smooth, category: :effect, type: :int })

new({ particle: :blur, category: :effect, type: :int }) do |params|
  affect_to = if affect.nil?
                affect
              else
                [:self]
              end
  val = { value: params, affect: affect_to } unless params.instance_of?(Hash)
  val
end

