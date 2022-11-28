# frozen_string_literal: true

# for browser rendering
module BrowserHelper

  def self.browser_left_shape(value, browser_object, _atome)
    browser_object.style[:left] = "#{value}px"
  end

  def self.browser_right_shape(value, browser_object, _atome)
    browser_object.style[:right] = "#{value}px"
  end

  def self.browser_top_shape(value, browser_object, _atome)
    browser_object.style[:top] = "#{value}px"
  end

  def self.browser_bottom_shape(value, browser_object, _atome)
    browser_object.style[:bottom] = "#{value}px"
  end

end
