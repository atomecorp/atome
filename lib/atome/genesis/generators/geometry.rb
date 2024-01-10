# frozen_string_literal: true

new({particle: :width })
new({particle: :height })
new({particle: :size }) do |params|
  params
end

new({particle: :size, specific: :text }) do |params|
  params
end


new({particle: :size }) do |params|
  alert :poi
end
