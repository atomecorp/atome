# frozen_string_literal: true

# for browser rendering
module BrowserHelper

  def self.touch_helper_callback(event, atome, proc)
    atome.instance_exec(event, &proc) if proc.is_a?(Proc)
  end

  def self.browser_touch_true(browser_object, atome, proc)
    `
    interact('#'+#{browser_object})
  .on('tap', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })
`
  end

  def self.browser_touch_long(browser_object, atome, proc)
    `
    interact('#'+#{browser_object})
  .on('hold', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })
`
  end

  def self.browser_touch_double(browser_object, atome, proc)
    `
    interact('#'+#{browser_object})
  .on('doubletap', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })
`
  end

  def self.browser_touch_down(browser_object, atome, proc)

    `
    interact('#'+#{browser_object})
  .on('down', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })

`
  end

  def self.browser_touch_up(browser_object, atome, proc)
    `
    interact('#'+#{browser_object})
  .on('up', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })
`
  end

  def self.browser_over_enter(browser_object, atome, proc)
    browser_object.on :mouseover do |event|
      atome.instance_exec(event, &proc) if proc.is_a?(Proc)
      atome_id = atome.id.value
      # @enter_action_proc = proc
      atome_js.JS.over_enter(atome_id, atome, proc)
    end
  end

  def self.browser_over_leave(browser_object, atome, proc)
    browser_object.on :mouseout do |event|
      atome.instance_exec(event, &proc) if proc.is_a?(Proc)
      atome_id = atome.id.value
      # @leave_action_proc = proc
      atome_js.JS.over_leave(atome_id, atome,proc)
    end
  end

end


