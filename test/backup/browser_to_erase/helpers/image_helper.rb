# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  # image
  def self.browser_left_image(value, browser_object, _atome)
    browser_object.style[:left] = "#{value}px"
  end

  def self.browser_right_image(value, browser_object, _atome)
    browser_object.style[:right] = "#{value}px"
  end

  def self.browser_top_image(value, browser_object, _atome)
    browser_object.style[:top] = "#{value}px"
  end

  def self.browser_bottom_image(value, browser_object, _atome)
    browser_object.style[:bottom] = "#{value}px"
  end

  def self.browser_path_image(value, browser_object, _atome)
    browser_object[:src] = value
  end

end
