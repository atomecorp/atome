# frozen_string_literal: true

new({ particle: :left, type: :integer })
new({ particle: :right, type: :integer })
new({ particle: :top, type: :integer })
new({ particle: :bottom, type: :integer })
new({ particle: :rotate, type: :integer }) do |p|
  # 88
  alert "last : #{p}"
  @params= 88
  p
end
new({ sanitizer: :rotate }) do |p|
  alert "sanitizer : #{p}"
  p=1
  p
end

new({ pre: :rotate }) do |p|
  alert "pre : #{p}"
  p=2
  p
end

new({ post: :rotate }) do |p|
  alert "post : #{p}"
  p=3
  p
end

new({ after: :rotate }) do |p|
  alert "after : #{p}"
  p=4
  p
end
new({ particle: :direction, type: :string })
new({ particle: :center, type: :string})
new({particle: :depth, type: :integer})

