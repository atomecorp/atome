# ruby main Object extensions
require "extensions/hash"
# fake methods to make Rubocop shut it's mouth
require "atome/fake_methods"
# atome's property builders
require "atome/builder/property"
require "atome/environment/default"
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
#require "atome/properties/legacy"
# Atome helper (help system for atomes)
require "atome/system/helper"
# main atome builder
require "atome/builder/object"
# Atome helper (methods availlable at main Object level)
require "atome/utilities/helper"
# elementary atomes for basic environment
require "atome/environment/initialize"
# helper methods to facilitate atome's creation
require "atome/utilities/creation"