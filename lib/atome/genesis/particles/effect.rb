# frozen_string_literal: true

new({ particle: :smooth, category: :effect, type: :int })

new({ particle: :blur, category: :effect, type: :int }) do |params|
  if affect.nil?
      affect_to = affect
  else
    affect_to = [:self]
  end
  val= { value: params, affect: affect_to } unless params.instance_of?(Hash)
  val
end

