# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_touch) do |_value, proc|
  @browser_object.on :click do |e|
    instance_exec(&proc) if proc.is_a?(Proc)
  end
end
