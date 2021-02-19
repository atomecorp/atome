# ruby main Object extensions
require "extensions/hash"
# fake methods to make Rubocop shut it's mouth
require "atome/fake_methods"
# atome's property builders
require "atome/builder/property"
# property processors
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
# utilities
require "atome/system/utilities"
require "atome/system/renderer"
# main atome builder
require "atome/builder/object"
# Atome helper (methods available at main Object level)
require "atome/utilities/global"
# elementary atomes for basic environment
require "atome/environment/initialize"
# helper methods to facilitate atome's creation
require "atome/utilities/creation"