# frozen_string_literal: true

require 'extensions/atome'
require 'extensions/js'
require 'extensions/geolocation'
require 'extensions/ping'
require 'extensions/sha'
require 'extensions/color'
require 'native'
def alert(val)
  # JS.eval("alert('#{val}')")
  `alert(#{val})`
end

