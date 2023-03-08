# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  def self.browser_document
    # Work because of the patched version of opal-browser(0.39)
    Browser.window
  end

  def self.browser_attach_(_parents, _html_object, _atome)
    # dummy methods to catch atomes that do not need to be attached to any particular visual atime
  end

  def self.browser_attach_div(parents, html_object, _atome)
    html_object.append_to(browser_document[parents])
  end

  def self.browser_attach_style(parents, _html_object, atome)
    browser_document[parents].add_class(atome[:id])
  end

  def self.browser_attached_div(children, _html_object, atome)
    children.each do |child_found|
      # atome_child.browser_attach_div
      html_child=grab(child_found).browser_object
      html_child.append_to(browser_document[atome[:id]])
    end
  end

  def self.browser_attached_style(children, _html_object, atome)

    browser_document[atome[:id]].add_class(children)
  end

  def self.value_parse(value)
    if value.instance_of?(String)
      value
    else
      "#{value}px"
    end

  end
end
