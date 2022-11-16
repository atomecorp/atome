# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:html_left) do |_value, user_proc|
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end

generator.build_optional_methods(:pre_get_left) do
  user_proc = @user_proc
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end
