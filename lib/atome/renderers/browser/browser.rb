# frozen_string_literal: true

require 'atome/renderers/browser/effect'
require 'atome/renderers/browser/event'
require 'atome/renderers/browser/geometry'
require 'atome/renderers/browser/identity'
require 'atome/renderers/browser/material'
require 'atome/renderers/browser/spatial'
require 'atome/renderers/browser/atome'
require 'atome/renderers/browser/utility'

# for opal rendering
class BrowserHelper
  def self.browser_document
    $document
  end

  def self.browser_attach_div(parents, html_object, _atome)
    html_object.append_to(browser_document[parents])
  end

  def self.browser_attach_style(parents, _html_object, atome)
    browser_document[parents].add_class(atome[:id])
  end

  def self.browser_blur_style(_browser_object, value)
    puts "now decide how to alter the tag!!#{value}"
    # browser_document[parents].add_class(atome[:id])
  end

  def self.browser_blur_div(browser_object, value)
    browser_object.style[:filter] = "blur(#{value}px)"
  end
end
