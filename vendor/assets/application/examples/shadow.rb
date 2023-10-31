# frozen_string_literal: true

# class Atome
#   # Initialisation de la liste des méthodes existantes
#   @methodes_existantes = instance_methods(false)
#
#   def self.method_added(method_name)
#     if @methodes_existantes.include?(method_name)
#       puts "La méthode #{method_name} a été modifiée."
#     else
#       puts "La méthode #{method_name} a été créée."
#       @methodes_existantes << method_name
#     end
#     super
#   end
# end

c = circle({ id: :the_circle, left: 122, color: :orange, drag: { move: true, inertia: true, lock: :start } })
####### test begin here
col = c.color({ id: :col1, red: 1, blue: 1 })
# col = color({  affect: [:the_circle], id: :col1, red: 1,blue: 1 })
####### test end here
# col.affect([:the_circle])
# col.affect([:the_circle])
#
# ###################################
# # uncomment beleow
# color_la_ci = c.color({ id: :yellow_green, blue: 0.5, green: 1 })
# c2 = circle({ id: :the_circle2, left: 222, drag: { move: true, inertia: true, lock: :start } })
#
# b = circle({ id: :the_buzz })
# b.color({ id: :the_red, red: 1 })
# b.color(:green)
# b.color({ id: :la_col, red: 0 })
# circle({ id: :the_circle3, left: 322, drag: { move: true, inertia: true, lock: :start } })
####### test begin here
s1 = c.shadow({
              id: :s1,
              # affect: [:the_circle],
              left: 9, top: 3, blur: 9,
              invert: false,
              red: 0, green: 0, blue: 0, alpha: 1
            })


# s1 = shadow({
#                 id: :s1,
#                 left: 9, top: 3, blur: 9,
#                 affect: [:the_circle],
#                 invert: false,
#                 red: 0, green: 0, blue: 0, alpha: 1
#               })

####### test end here
# alert "** #{s1.inspect}"
# alert "==> #{s1.inspect}"
# c.shadow({
#            id: :s2,
#            affect: [:the_circle],
#            left: 3, top: 9, blur: 9,
#            invert: true,
#            red: 0, green: 0, blue: 0, alpha: 1
#          })
# c.shadow({
#            id: :s3,
#            affect: [:the_circle],
#            left: -3, top: -3, blur: 9,
#            invert: true,
#            red: 0, green: 0, blue: 0, alpha: 1
#          })
#
# c.shadow({
#            id: :s4,
#            affect: [:the_circle],
#            left: 20, top: 0, blur: 9,
#            option: :natural,
#            red: 0, green: 0, blue: 0, alpha: 1
#          })
#
# c2.shadow({
#             id: :s5,
#             affect: [:the_circle2],
#             left: 9, top: 9, blur: 9,
#             option: :natural,
#             red: 0, green: 0, blue: 0, alpha: 1
#           })
#
# c3.shadow({
#             id: :s6,
#             affect: [:the_circle3],
#             left: 3, top: 3, blur: 9,
#             red: 0, green: 0, blue: 0, alpha: 1
#           })
# c3.shadow
# alert c2.inspect



