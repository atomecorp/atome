# frozen_string_literal: true

# for browser rendering
module BrowserHelper

  def self.browser_left_group(_value, _browser_object, _atome)
    # browser_object.style[:left] = BrowserHelper.value_parse(value)
  end

  def self.browser_left_shape(value, browser_object, _atome)
    browser_object.style[:left] = BrowserHelper.value_parse(value)
  end

  def self.browser_right_shape(value, browser_object, _atome)
    browser_object.style[:right] = BrowserHelper.value_parse(value)
  end

  def self.browser_top_shape(value, browser_object, _atome)
    browser_object.style[:top] = BrowserHelper.value_parse(value)
  end

  def self.browser_bottom_shape(value, browser_object, _atome)
    browser_object.style[:bottom] = BrowserHelper.value_parse(value)
  end

end
