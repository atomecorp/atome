# frozen_string_literal: true

generator = Genesis.generator

# generator.build_render_method(:html_left) do |_value, user_proc|
#   instance_exec(&user_proc) if user_proc.is_a?(Proc)
# end
#
# generator.build_optional_methods(:pre_get_left) do
#   user_proc = @user_proc
#   instance_exec(&user_proc) if user_proc.is_a?(Proc)
# end

generator.build_render_method(:html_left) do |value, _user_proc|
  @html_object.style[:left] = "#{value}px" unless @html_type == :style
  # @html_object.style[:left] = "#{value}px"
end

generator.build_render_method(:html_right) do |value, _user_proc|
  @html_object.style[:right] = "#{value}px" unless @html_type == :style
  # @html_object.style[:right] = "#{value}px"
end

generator.build_render_method(:html_top) do |value, _user_proc|
  @html_object.style[:top] = "#{value}px" unless @html_type == :style
  # @html_object.style[:top] = "#{value}px"
end

generator.build_render_method(:html_bottom) do |value, _user_proc|
  @html_object.style[:bottom] = "#{value}px" unless @html_type == :style
  # @html_object.style[:bottom] = "#{value}px"
end
