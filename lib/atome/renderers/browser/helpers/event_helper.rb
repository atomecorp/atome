# frozen_string_literal: true

# for browser rendering
module BrowserHelper

  def self.touch_helper_callback(event,atome, proc)
    atome.instance_exec(event, &proc) if proc.is_a?(Proc)
  end

  def self.browser_touch_true(browser_object,atome, proc)
    `
    interact('#'+#{browser_object})
  .on('tap', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })
`
  end

  def self.browser_touch_long(browser_object,atome, proc)
    `
    interact('#'+#{browser_object})
  .on('hold', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })
`
  end

  def self.browser_touch_double(browser_object,atome, proc)
    `
    interact('#'+#{browser_object})
  .on('doubletap', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })
`
  end

  def self.browser_touch_down(browser_object,atome, proc)

    `
    interact('#'+#{browser_object})
  .on('down', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })

`
  end

  def self.browser_touch_up(browser_object, atome,proc)
    `
    interact('#'+#{browser_object})
  .on('up', function (event) {
Opal.BrowserHelper.$touch_helper_callback(event,#{atome},#{proc});
  })
`
  end

end


