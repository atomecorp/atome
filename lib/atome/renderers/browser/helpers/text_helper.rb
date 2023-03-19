# frozen_string_literal: true

# for browser rendering
module BrowserHelper

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
    value = value.gsub(/\n/, '<br/>')
    atome_send.browser_object.inner_html = value
  end

  def self.browser_data_shape(_value,_atome_send)

  end
  def self.browser_data_color(_value,_atome_send)

  end

  def self.browser_data_find(value,_atome_send)

  end

end