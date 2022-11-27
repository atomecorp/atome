# frozen_string_literal: true

require 'atome/renderers/browser/effect'
require 'atome/renderers/browser/event'
require 'atome/renderers/browser/geometry'
require 'atome/renderers/browser/identity'
require 'atome/renderers/browser/material'
require 'atome/renderers/browser/spatial'
require 'atome/renderers/browser/atome'
require 'atome/renderers/browser/utility'

class Atome
  attr_accessor :browser_object
end

# for opal rendering
module BrowserHelper
  def self.browser_document
    # Work because of the patched version of opal-browser(0.39)
    Browser.window
  end

  def self.browser_attach_div(parents, html_object, _atome)
    html_object.append_to(browser_document[parents])
  end

  def self.browser_attach_web(parents, html_object, _atome)
    html_object.append_to(browser_document[parents])
  end

  def self.browser_attach_style(parents, _html_object, atome)
    browser_document[parents].add_class(atome[:id])
  end

  def self.browser_blur_style(_browser_object, value, atome)
    b_left = "#{atome[:left]}px"
    b_top = "#{atome[:top]}px"
    b_blur = "#{atome[:blur] = value}px"
    b_red = atome[:red] * 255
    b_green = atome[:green] * 255
    b_blue = (atome[:blue]) * 255
    b_direction = atome[:direction]
    b_alpha = atome[:alpha]

    shadow_updated = "#{b_left} #{b_top} #{b_blur} rgba(#{b_red}, #{b_green}, #{b_blue}, #{b_alpha}) #{b_direction}"
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
  end

  def self.browser_blur_div(browser_object, value, _atome)
    browser_object.style[:filter] = "blur(#{value}px)"
  end

  def self.browser_colorize_color(color_updated, atome)
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.backgroundColor = #{color_updated}`
  end

  def self.browser_colorize_shadow(color_updated, atome)
    left = atome[:left]
    top = atome[:top]
    blur = atome[:blur]
    direction = atome[:direction]
    shadow_updated = "#{left}px #{top}px #{blur}px #{color_updated} #{direction}"
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
  end

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

  # shadow
  def self.browser_left_shadow(value, _browser_object, atome)
    ls_left = "#{atome[:left] = value}px"
    ls_top = "#{atome[:top]}px"
    ls_blur = "#{atome[:blur]}px"
    red = atome[:red] * 255
    green = atome[:green] * 255
    blue = (atome[:blue]) * 255
    direction = atome[:direction]
    alpha = atome[:alpha]

    shadow_updated = "#{ls_left} #{ls_top} #{ls_blur} rgba(#{red}, #{green}, #{blue}, #{alpha}) #{direction}"
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
  end

  def self.browser_top_shadow(value, _browser_object, atome)
    rs_left = "#{atome[:left]}px"
    rs_top = "#{atome[:top] = value}px"
    rs_blur = "#{atome[:blur]}px"
    red = atome[:red] * 255
    green = atome[:green] * 255
    blue = (atome[:blue]) * 255
    direction = atome[:direction]
    alpha = atome[:alpha]

    shadow_updated = "#{rs_left}px #{rs_top}px #{rs_blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}) #{direction}"
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
  end

  def self.browser_left_color(_value, _browser_object, _atome)
    puts 'code to write when implementing gradient'
  end

  def self.browser_right_color(_value, _browser_object, _atome)
    puts 'code to write when implementing gradient'
  end

  def self.browser_top_color(_value, _browser_object, _atome)
    puts 'code to write when implementing gradient'
  end

  def self.browser_bottom_color(_value, _browser_object, _atome)
    puts 'code to write when implementing gradient'
  end

  # text
  def self.browser_left_text(value, browser_object, _atome)
    browser_object.style[:left] = "#{value}px"
  end

  def self.browser_right_text(value, browser_object, _atome)
    browser_object.style[:right] = "#{value}px"
  end

  def self.browser_top_text(value, browser_object, _atome)
    browser_object.style[:top] = "#{value}px"
  end

  def self.browser_bottom_text(value, browser_object, _atome)
    browser_object.style[:bottom] = "#{value}px"
  end

  def self.browser_data_text(value)
    browser_object.text = value
  end

  # web
  def self.browser_left_web(value, browser_object, _atome)
    browser_object.style[:left] = "#{value}px"
  end

  def self.browser_right_web(value, browser_object, _atome)
    browser_object.style[:right] = "#{value}px"
  end

  def self.browser_top_web(value, browser_object, _atome)
    browser_object.style[:top] = "#{value}px"
  end

  def self.browser_bottom_web(value, browser_object, _atome)
    browser_object.style[:bottom] = "#{value}px"
  end

  def self.browser_path_web(value, browser_object, _atome)
    browser_object[:src] = value
  end

  # video
  def self.browser_left_video(value, browser_object, _atome)
    browser_object.style[:left] = "#{value}px"
  end

  def self.browser_right_videob(value, browser_object, _atome)
    browser_object.style[:right] = "#{value}px"
  end

  def self.browser_top_video(value, browser_object, _atome)
    browser_object.style[:top] = "#{value}px"
  end

  def self.browser_bottom_video(value, browser_object, _atome)
    browser_object.style[:bottom] = "#{value}px"
  end

  def self.browser_path_video(value, browser_object, _atome)
    browser_object[:src] = value
  end

  def self.browser_play_video(_value, browser_object_found, atome_found, atome_object, proc)
    browser_object_found.play
    # TODO : change timeupdate for when possible requestVideoFrameCallback
    # (opal-browser/opal/browser/event.rb line 36)
    video_callback = atome_found[:code] # this is the video callback not the play callback
    play_callback = proc # this is the video callback not the play callback
    browser_object_found.on(:timeupdate) do |e|
      e.prevent # Prevent the default action (eg. form submission)
      # You can also use `e.stop` to stop propagating the event to other handlers.
      current_time = browser_object_found.currentTime
      atome_object.instance_exec(current_time, &video_callback) if video_callback.is_a?(Proc)
      atome_object.instance_exec(current_time, &play_callback) if play_callback.is_a?(Proc)
    end
  end
end
