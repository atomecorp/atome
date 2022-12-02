# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  def self.browser_document
    # Work because of the patched version of opal-browser(0.39)
    Browser.window
  end

  def self.browser_attach_div(parents, html_object, _atome)
    html_object.append_to(browser_document[parents])
  end

  def self.browser_attach_style(parents, _html_object, atome)
    browser_document[parents].add_class(atome[:id])
  end
end
