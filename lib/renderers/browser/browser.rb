# frozen_string_literal: true

require 'renderers/browser/opal_add_on'
require 'renderers/browser/effect'
require 'renderers/browser/event'
require 'renderers/browser/geometry'
require 'renderers/browser/identity'
require 'renderers/browser/material'
require 'renderers/browser/spatial'
require 'renderers/browser/atome'
require 'renderers/browser/utility'
require 'renderers/browser/time'
require 'renderers/browser/helpers/browser_helper'
require 'renderers/browser/helpers/animation_helper'
require 'renderers/browser/helpers/color_helper'
require 'renderers/browser/helpers/drag_helper'
require 'renderers/browser/helpers/drop_helper'
# require 'renderers/browser/helpers/over_helper'
require 'renderers/browser/helpers/effect_helper'
require 'renderers/browser/helpers/event_helper'
require 'renderers/browser/helpers/image_helper'
require 'renderers/browser/helpers/shadow_helper'
require 'renderers/browser/helpers/shape_helper'
require 'renderers/browser/helpers/text_helper'
require 'renderers/browser/helpers/video_helper'
require 'renderers/browser/helpers/web_helper'




class Atome
  attr_accessor :browser_object

  def to_px
    id_found = real_atome[:id]
    property_found=property
    value_get = ''
    `
      div = document.getElementById(#{id_found});
      var style = window.getComputedStyle(div);
      var original_value = style.getPropertyValue(#{property_found});
      #{value_get}= parseInt(original_value);
    `
    value_get
  end
end

def atome_js
  `atomeJS`
end
