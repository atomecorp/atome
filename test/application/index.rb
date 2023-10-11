#  frozen_string_literal: true

require './examples/keyboard'
# https://github.com/travist/jsencrypt

# TODO : debug code below:

# TODO: check that atome gem build correctly the solution
# TODO: change atomic repository so that it install atome gem correctly
# TODO : add onscroll event
# TODO : find a way to unbind a specific event

# Importer la fonction requestAnimationFrame de JavaScript
# JS.global.JS[:import].call(`"requestAnimationFrame"`, `window`)

# class ScrollHandler
#   def initialize
#     @box = JS.global.JS[:document].getElementById("the_box")
#     @initialHeight = @box.JS[:clientHeight]
#
#     # Enregistrer un gestionnaire d'événement de défilement
#     `window.addEventListener("scroll", self.handle_scroll)`
#   end
#
#   def handle_scroll
#     # Calculer la nouvelle hauteur de la boîte en fonction de la position de défilement
#     scroll_position = `window.scrollY || window.pageYOffset`
#     new_height = @initialHeight + scroll_position
#
#     # Ajuster la hauteur de la boîte
#     @box.JS[:style].J[:height] = `#{new_height}px`
#   end
# end
#
# # Créer une instance de la classe ScrollHandler
# scroll_handler = ScrollHandler.new

# scroll




