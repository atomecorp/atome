# frozen_string_literal: true

new({ particle: :left }) do |_params, user_proc|
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end
new({ particle: :right })
new({ particle: :top })
new({ particle: :bottom })
new({ particle: :rotate })
new({ particle: :direction })
new({ particle: :center })
new ({particle: :depth})

