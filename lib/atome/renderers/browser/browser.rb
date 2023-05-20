# frozen_string_literal: true

require 'atome/renderers/browser/opal_add_on'
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
require 'atome/renderers/browser/helpers/drop_helper'
# require 'atome/renderers/browser/helpers/over_helper'
require 'atome/renderers/browser/helpers/effect_helper'
require 'atome/renderers/browser/helpers/event_helper'
require 'atome/renderers/browser/helpers/image_helper'
require 'atome/renderers/browser/helpers/shadow_helper'
require 'atome/renderers/browser/helpers/shape_helper'
require 'atome/renderers/browser/helpers/text_helper'
require 'atome/renderers/browser/helpers/video_helper'
require 'atome/renderers/browser/helpers/web_helper'

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
