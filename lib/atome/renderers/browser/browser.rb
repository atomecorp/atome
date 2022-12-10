# frozen_string_literal: true

require 'atome/renderers/browser/effect'
require 'atome/renderers/browser/event'
require 'atome/renderers/browser/geometry'
require 'atome/renderers/browser/identity'
require 'atome/renderers/browser/material'
require 'atome/renderers/browser/spatial'
require 'atome/renderers/browser/atome'
require 'atome/renderers/browser/utility'
require 'atome/renderers/browser/time'
require 'atome/renderers/browser/helpers/browser_helper'
require 'atome/renderers/browser/helpers/animation_helper'
require 'atome/renderers/browser/helpers/color_helper'
require 'atome/renderers/browser/helpers/drag_helper'
require 'atome/renderers/browser/helpers/effect_helper'
require 'atome/renderers/browser/helpers/event_helper'
require 'atome/renderers/browser/helpers/image_helper'
require 'atome/renderers/browser/helpers/shadow_helper'
require 'atome/renderers/browser/helpers/shape_helper'
require 'atome/renderers/browser/helpers/text_helper'
require 'atome/renderers/browser/helpers/video_helper'
require 'atome/renderers/browser/helpers/web_helper'

class Atome
  attr_accessor 'browser_object'
end

def atome_js
  `atomeJS`
end
