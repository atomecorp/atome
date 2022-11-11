# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:html_left) do |_value, user_proc|
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
end

# generator.build_optional_methods(:post_save_left) do
#   # puts "******* |we'll try the change the value on the fly , how to change it without altering the @atome hash"
#   @atome[:left] = :magic!
# end
#
# generator.build_optional_methods(:pre_get_left) do
#   old_value = @atome
#   new_value = "#{old_value} + mega magic+params"
#   @atome = new_value
# end

generator.build_optional_methods(:pre_get_left) do
  user_proc = "#{@property},#{@value}, from #{@real_atome}, proc: #{@user_proc}"
  puts "#{user_proc.class}, so kool"
  user_proc = @user_proc
  instance_exec(&user_proc) if user_proc.is_a?(Proc)
  # old_value = @atome
  # new_value = "#{old_value} + mega magic+params"
  # @atome = new_value
end
