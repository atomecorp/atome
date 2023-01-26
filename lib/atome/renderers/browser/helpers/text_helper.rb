# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  # text
  def self.browser_left_text(value, browser_object, _atome)
    browser_object.style[:left] = BrowserHelper.value_parse(value)
  end

  def self.browser_right_text(value, browser_object, _atome)
    browser_object.style[:right] = BrowserHelper.value_parse(value)
  end

  def self.browser_top_text(value, browser_object, _atome)
    browser_object.style[:top] = BrowserHelper.value_parse(value)
  end

  def self.browser_bottom_text(value, browser_object, _atome)
    browser_object.style[:bottom] = BrowserHelper.value_parse(value)
  end

  def self.browser_data_text(value,atome_send)
    atome_send.browser_object.text = value
  end

end