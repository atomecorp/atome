# frozen_string_literal: true

# for browser rendering

module BrowserHelper

  #drop helper
  def self.browser_over_action(params, atome_id, atome, proc)
    atome.over_action_proc = proc
    atome_js.JS.over(params, atome_id, atome)
  end

end
