# frozen_string_literal: true

# for browser rendering

module BrowserHelper

  # drag helper
  def self.browser_drag_move(params, atome_id, atome, proc)
    atome.drag_move_proc = proc
    atome_js.JS.drag(params, atome_id, atome)
  end

  # def self.browser_drag_end(params, atome_id, atome, proc)
  #   # alert :kool
  #   # atome.drag_move_proc = proc
  #   # atome_js.JS.drag(params, atome_id, atome)
  # end

  def self.browser_drag_lock(params, atome_id, atome, _proc)
    atome_js.JS.lock(params, atome_id, atome)
  end

  def self.browser_drag_remove(params, atome_id, atome, _proc)
    params = params != true
    atome_js.JS.remove(params, atome_id, atome)
  end

  def self.browser_drag_snap(params, atome_id, atome, _proc)
    atome_js.JS.snap(params.to_n, atome_id, atome)
  end

  def self.browser_drag_inertia(params, atome_id, atome, _proc)
    atome_js.JS.inertia(params, atome_id, atome)
  end

  def self.browser_drag_constraint(params, atome_id, atome, _proc)
    atome_js.JS.constraint(params.to_n, atome_id, atome)
  end

  def self.browser_drag_start(_params, _atome_id, atome, proc)
    atome.drag_start_proc = proc
  end

  def self.browser_drag_end(_params, _atome_id, atome, proc)
    atome.drag_end_proc = proc
  end

end
