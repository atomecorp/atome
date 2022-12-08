# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:html_touch) do |_value, proc|
  @html_object.on :click do |e|
    instance_exec(&proc) if proc.is_a?(Proc)
  end
end
