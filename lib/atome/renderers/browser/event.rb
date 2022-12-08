# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:browser_touch) do |value, proc|
  atome_id = @browser_object.attribute(:id)
  BrowserHelper.send("browser_touch_#{value}", atome_id, proc)
  # end
end

generator.build_render(:browser_play) do |value, proc|
  # first we reinit the 'at' event so the condition will be met again
  # @at_time[:used] = nil
  @browser_object.currentTime = value if value != true
  BrowserHelper.send("browser_play_#{@atome[:type]}", value, @browser_object, @atome, self, proc)
end

generator.build_render(:browser_time) do |value = nil, _proc|
  if value
    @browser_object.currentTime = value
  else
    @browser_object.currentTime
  end
end

generator.build_render(:browser_pause) do |_value, proc|
  instance_exec(@browser_object.currentTime, &proc) if proc.is_a?(Proc)
  @browser_object.pause
end

generator.build_render(:on) do |value, proc|
  @browser_object.on(value) do |e|
    instance_exec(e, &proc) if proc.is_a?(Proc)
  end
end

generator.build_render(:fullscreen) do |_value, _proc|
  atome_id = atome[:id]
  atome_js.JS.fullscreen(atome_id)
end

generator.build_render(:mute) do |value, _proc|
  if value
    browser_object.muted
  else
    browser_object.unmuted
  end
end

generator.build_render(:browser_at) do |at, proc|
  # @atime is check at each toick of frame in 'time_callback'
  @at_time = { code: proc }.merge(at)
end

generator.build_render(:browser_drag) do |options, proc|
  options.each do |method, params|
    atome_id = @atome[:id]
    BrowserHelper.send("browser_drag_#{method}", params, atome_id, self, proc)
  end
end

generator.build_render(:browser_sort) do |options, _proc|
  atome_js.JS.sort(options, @atome[:id], self)
end

# TODO: for now unbind remove all touch event we should remove only the targeted one (store proc and restore it)
generator.build_render(:browser_unbind) do |options, _proc|
  id_found = self.atome[:id]
  `
const el = document.getElementById(#{id_found});
interact('#'+#{id_found}).unset(#{options});
`
end


