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
col = c.color({ id: :col1, red: 1, blue: 1 })
wait 2 do
  col.red(0.6)
  wait 2 do
    col.red(0) # Appel en écriture
  end
end

###################################
# # uncomment beleow
# color_la_ci=c.color({id: :yellow_green, blue: 0.5, green: 1})
# c2 = circle({ id: :the_circle2, left: 222, drag: { move: true, inertia: true, lock: :start } })
# c2
# b=circle({id: :the_buzz})
# b.color({id: :the_red, red: 1 })
# b.color(:green)
# color_la=b.color({id: :la_col,  red: 0})
# # grab(:view).color(:green)
# # grab(:view).color(:yellow)
# c3 = circle({ id: :the_circle3, left: 322, drag: { move: true, inertia: true, lock: :start } })
#
# # puts "c apply => #{c.instance_variable_get('@apply')}:"
# c.apply(color_la_ci)
# puts "c.apply : #{c.apply}"
# puts   "c.color : c.color#{c.color}"
#
# puts " color shis : #{ color_la.red}"
# wait 2 do
#   color_la.red(1)
#   puts "color should have changed : #{ color_la.red}"
# end
#
# # puts "atome_to_hash : #{c.atome_to_hash}"
#
# # puts "IV: #{c.inspect}  : #{c.inspect.class}"
# # puts "Saved :#{c.atome} : #{c.atome.class}"
#
#
# # hash1 = c.inspect
# # hash2 = c.atome
# #
# # def normalize_key(key)
# #   key.to_s.gsub(/[@:]/, '').to_sym  # Supprime les préfixes '@' et ':', puis convertit en symbole
# # end
# #
# # def normalize_hash(hash)
# #   hash.transform_keys { |k| normalize_key(k) }
# # end
# #
# # def common_elements(hash1, hash2)
# #   normalized_hash1 = normalize_hash(hash1)
# #   normalized_hash2 = normalize_hash(hash2)
# #
# #   common_keys = normalized_hash1.keys & normalized_hash2.keys
# #   common_keys.select { |k| normalized_hash1[k] == normalized_hash2[k] }.map { |k| [k, normalized_hash1[k]] }.to_h
# # end
# #
# # def orphan_elements(hash1, hash2)
# #   normalized_hash1 = normalize_hash(hash1)
# #   normalized_hash2 = normalize_hash(hash2)
# #
# #   orphan_keys_from_hash1 = normalized_hash1.keys - normalized_hash2.keys
# #   orphan_keys_from_hash2 = normalized_hash2.keys - normalized_hash1.keys
# #
# #   orphans_from_hash1 = orphan_keys_from_hash1.map { |k| [k, normalized_hash1[k]] }.to_h
# #   orphans_from_hash2 = orphan_keys_from_hash2.map { |k| [k, normalized_hash2[k]] }.to_h
# #
# #   [orphans_from_hash1, orphans_from_hash2]
# # end
# #
# #
# #
# # puts "Éléments communs : #{common_elements(hash1, hash2)}"
# # orphans_1, orphans_2 = orphan_elements(hash1, hash2)
# # puts "Éléments orphelins de instance variable : #{orphans_1}"
# # puts "Éléments orphelins de atome : #{orphans_2}"
# # puts '-------------'
#
# # puts puts "instance variable : #{hash1}"
# # puts puts "atome : #{hash2}"
#
# # puts c.html.inspect
# # c.box
# # c2.box
# # c2.box
# # c3.box
# # c3.color(:yellow)
# # alert c3.color
# # c.shadow({
# #            id: :s1,
# #            affect: [:the_circle],
# #            left: 29, top: 3, blur: 9,
# #            invert: false,
# #            red: 0, green: 0, blue: 0, alpha: 1
# #          })
#
# # c.shadow({
# #            id: :s2,
# #            affect: [:the_circle],
# #            left: 3, top: 9, blur: 9,
# #            invert: true,
# #            red: 0, green: 0, blue: 0, alpha: 1
# #          })
# # c.shadow({
# #            id: :s3,
# #            affect: [:the_circle],
# #            left: -3, top: -3, blur: 9,
# #            invert: true,
# #            red: 0, green: 0, blue: 0, alpha: 1
# #          })
# #
# # c.shadow({
# #            id: :s4,
# #            affect: [:the_circle],
# #            left: 20, top: 0, blur: 9,
# #            option: :natural,
# #            red: 0, green: 0, blue: 0, alpha: 1
# #          })
# #
# # c2.shadow({
# #             id: :s5,
# #             affect: [:the_circle2],
# #             left: 9, top: 9, blur: 9,
# #             option: :natural,
# #             red: 0, green: 0, blue: 0, alpha: 1
# #           })
# #
# # c3.shadow({
# #             id: :s6,
# #             affect: [:the_circle3],
# #             left: 3, top: 3, blur: 9,
# #             red: 0, green: 0, blue: 0, alpha: 1
# #           })
# # c3.shadow
# # alert c2.inspect



