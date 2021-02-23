# ruby main Object extensions
require "extensions/hash"
# opal specific
require "atome/interpreter/opal/opal_helpers"
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
require "atome/processor/audio"
require "atome/processor/communication"
require "atome/processor/effect"
require "atome/processor/event"
require "atome/processor/geometry"
require "atome/processor/helper"
require "atome/processor/hierarchy"
require "atome/processor/identity"
require "atome/processor/media"
require "atome/processor/spatial"
require "atome/processor/utility"
require "atome/processor/visual"
# utilities
require "atome/system/utilities"
# main atome builder
require "atome/builder/object"
# Atome helper (methods available at main Object level)
require "atome/utilities/global"
# class to create a new device
require "atome/environment/device"
# elementary atomes for basic environment
require "atome/environment/initialize"
# methods to simplify object creation
require "atome/system/creation"