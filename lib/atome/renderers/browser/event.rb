# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_touch) do |_value, proc|
  @browser_object.on :click do |e|
    instance_exec(e, &proc) if proc.is_a?(Proc)
  end
end

generator.build_render_method(:browser_play) do |value, proc|
  BrowserHelper.send("browser_play_#{@atome[:type]}", value, @browser_object, @atome, self, proc)
end

generator.build_render_method(:browser_time) do |value = nil, _proc|
  if value
    @browser_object.currentTime = value
  else
    @browser_object.currentTime
  end
end

generator.build_render_method(:browser_pause) do |_value, proc|
  instance_exec(@browser_object.currentTime, &proc) if proc.is_a?(Proc)
  @browser_object.pause
end

generator.build_render_method(:on) do |value, proc|
  @browser_object.on(value) do |e|
    instance_exec(e, &proc) if proc.is_a?(Proc)
  end
end