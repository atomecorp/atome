# frozen_string_literal: true

new({ particle: :left, type: :integer }) do |_params, user_proc|
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end
new({ particle: :right, type: :integer })
new({ particle: :top, type: :integer })


new({ particle: :bottom, type: :integer })
new({ particle: :rotate, type: :integer })
new({ particle: :direction, type: :string })
new({ particle: :center, type: :string})
new({particle: :depth, type: :integer})

