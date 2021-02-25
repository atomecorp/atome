# ruby main Object extensions
require "atome/extensions/object/hash"
# default_value
require "atome/environment/default_values"
# opal specific
require "atome/extensions/opal/opal_helpers"
require "atome/extensions/opal/opal_jquery"
# render helper
require "atome/renderers/renderer_helper"
# html renderer
require "atome/renderers/html/audio"
require "atome/renderers/html/communication"
require "atome/renderers/html/effect"
require "atome/renderers/html/event"
require "atome/renderers/html/geometry"
require "atome/renderers/html/helper"
require "atome/renderers/html/hierarchy"
require "atome/renderers/html/identity"
require "atome/renderers/html/media"
require "atome/renderers/html/spatial"
require "atome/renderers/html/utility"
require "atome/renderers/html/visual"
require "atome/renderers/html"
# property
require "atome/properties/audio"
require "atome/properties/communication"
require "atome/properties/effect"
require "atome/properties/event"
require "atome/properties/geometry"
require "atome/properties/helper"
require "atome/properties/hierarchy"
require "atome/properties/identity"
require "atome/properties/media"
require "atome/properties/spatial"
require "atome/properties/utility"
require "atome/properties/visual"
# property processors
require "atome/processors/audio"
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
require "atome/processors/visual"
# utilities
require "atome/helpers/utilities"
# main atome builder
require "atome/builder/properties"
require "atome/builder/object"
# Atome helper (methods available at main Object level)
require "atome/extensions/atome_helpers"
# class to create a new device
require "atome/environment/device"
# elementary atomes for basic environment
require "atome/environment/initialize"
# methods to simplify object creation
require "atome/extensions/creation"