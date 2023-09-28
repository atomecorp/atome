# frozen_string_literal: true

# for browser rendering

module BrowserHelper

  # drop helper
  def self.browser_drop_action(params, atome_id, atome, proc)
    atome.drop_action_proc = proc
    atome_js.JS.drop(params, atome_id, atome)
  end

end
