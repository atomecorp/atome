# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  # web
  def self.browser_left_web(value, browser_object, _atome)
    browser_object.style[:left] = BrowserHelper.value_parse(value)
  end

  def self.browser_right_web(value, browser_object, _atome)
    browser_object.style[:right] = BrowserHelper.value_parse(value)
  end

  def self.browser_top_web(value, browser_object, _atome)
    browser_object.style[:top] = BrowserHelper.value_parse(value)
  end

  def self.browser_bottom_web(value, browser_object, _atome)
    browser_object.style[:bottom] = BrowserHelper.value_parse(value)
  end

  def self.browser_path_web(value, browser_object, _atome)
    browser_object[:src] = value
  end

end
