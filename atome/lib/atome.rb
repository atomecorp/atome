class Quark
  def self.property_generation
    :static
  end
end
# ruby main Object extensions
require "atome/extensions/ruby/hash"
# default_value
require "atome/environment/default_values"
# opal specific
require "atome/extensions/opal/opal_helpers"
require "atome/extensions/opal/opal_jquery"
# render helper
require "atome/renderers/html/processors/communication"
require "atome/renderers/html/processors/effect"
require "atome/renderers/html/processors/event"
require "atome/renderers/html/processors/geometry"
require "atome/renderers/html/processors/helper"
require "atome/renderers/html/processors/hierarchy"
require "atome/renderers/html/processors/identity"
require "atome/renderers/html/processors/media"
require "atome/renderers/html/processors/spatial"
require "atome/renderers/html/processors/utility"
require "atome/renderers/html/processors/material"
# html renderer
require "atome/renderers/html/properties/communication"
require "atome/renderers/html/properties/effect"
require "atome/renderers/html/properties/event"
require "atome/renderers/html/properties/geometry"
require "atome/renderers/html/properties/helper"
require "atome/renderers/html/properties/hierarchy"
require "atome/renderers/html/properties/identity"
require "atome/renderers/html/properties/media"
require "atome/renderers/html/properties/spatial"
require "atome/renderers/html/properties/utility"
require "atome/renderers/html/properties/material"
require "atome/renderers/html/helpers/html_helpers"
require "atome/renderers/html"
# property
if Quark.property_generation== :static
  # genesis uses meta programing to generate atome's methods
  require "atome/generated_properties/communications"
  require "atome/generated_properties/effects"
  require "atome/generated_properties/events"
  require "atome/generated_properties/geometries"
  require "atome/generated_properties/helpers"
  require "atome/generated_properties/hierarchies"
  require "atome/generated_properties/identities"
  require "atome/generated_properties/medias"
  require "atome/generated_properties/spatials"
  require "atome/generated_properties/utilities"
  require "atome/generated_properties/materials"
end
# property processors
require "atome/processors/communication"
require "atome/processors/effect"
require "atome/processors/event"
require "atome/processors/geometry"
require "atome/processors/helper"
require "atome/processors/hierarchy"
require "atome/processors/identity"
require "atome/processors/media"
require "atome/processors/spatial"
require "atome/processors/utility"
require "atome/processors/material"
# helpers
require "atome/helpers/atome_helpers"
require "atome/helpers/internal_helpers"
# main atome builder
require "atome/generated_properties/batch"
require "atome/builder/properties"
#Quark.genesis
require "atome/builder/atome_generator"
# Atome helper (methods available at main Object level)
require "atome/extensions/atome_extensions"
# class to create a new device
require "atome/environment/device"
# elementary atomes for basic environment
require "atome/environment/initialize"
# methods to simplify object creation
require "atome/extensions/atome_object_creator"