# # frozen_string_literal: true
#
# # m = table({ renderers: [:html], attach: :view, id: :my_test_box, type: :table, apply: [:shape_color],
# #             left: 333, top: 0, width: 900, smooth: 15, height: 900, overflow: :scroll, option: { header: false },
# #             component: {
# #               # border: { thickness: 5, color: :blue, pattern: :dotted },
# #               # overflow: :auto,
# #               # color: "red",
# #               shadow: {
# #                 id: :s4,
# #                 left: 20, top: 0, blur: 9,
# #                 option: :natural,
# #                 red: 0, green: 0, blue: 0, alpha: 1
# #               },
# #               height: 5,
# #               width: 12,
# #               component: { size: 12, color: :black }
# #             },
# #             # data: [
# #             #   { titi: :toto },
# #             #   { dfgdf: 1, name: 'Alice', age: 30, no: 'oko', t: 123, r: 654 },
# #             #   { id: 2, name: 'Bob', age: 22 },
# #             #   { dfg: 4, name: 'Vincent', age: 33, no: grab(:my_circle) },
# #             #   { dfgd: 3, name: 'Roger', age: 18, no: image(:red_planet), now: :nothing }
# #             #
# #             # ]
# #           })
# b=box({top: 120})
# box({top: 190, id: :the_box})
#
# b.touch(true) do
#   a=JS.eval("return performance.now()")
#   z=Time.now
#   circle
#   columns = []
#
#   96.times do
#     line = {}
#     128.times do |index|
#       line[:"vel#{index}"] = nil
#     end
#     columns << line
#   end
#   columns.each_with_index do |a, index|
#     b= box({left: index*30, width: 12})
#     # b.touch(true) do
#     #   alert b.id
#     # end
#   end
#   z2=Time.now
#   x=JS.eval("return performance.now();")
#   alert "#{x.to_f-a.to_f} : #{(z2-z)*1000}"
#
# end
#
#
# # m.data(columns)
# # # tests
# # m.color(:orange)
# # m.border({ thickness: 5, color: :blue, pattern: :dotted })
# #
# #   m.get({ cell: [1, 2]}).class
# # wait 2 do
# #   m.insert({ cell: [2, 2], content: 999 })
# #   m.insert({ row: 1 })
# #   wait 1 do
# #     m.remove({ row: 2 })
# #   end
# #   wait 2 do
# #     m.remove({ column: 1 })
# #   end
# #   wait 3 do
# #     m.insert({ column: 3 })
# #   end
# #
# #   wait 4 do
# #     m.sort({ column: 1, method: :alphabetic })
# #     puts 1
# #     wait 1 do
# #       puts 2
# #       m.sort({ column: 2, method: :numeric })
# #       wait 1 do
# #         puts 3
# #         m.sort({ column: 3, method: :numeric })
# #         wait 1 do
# #           puts 4
# #           m.sort({ column: 1, method: :numeric })
# #         end
# #       end
# #     end
# #   end
# #
# # end
# #
# # #  cell.fusion() # to be implemented later
#
#
# # b=box({width: 1200, height: 900, color: {alpha: 0},top: -50})
# # grab(:black_matter).image({id: :kb,path: 'medias/images/utils/keyboard.svg', width: 66, left: 55})
# # # grab(:black_matter).image({id: :planet,path: 'medias/images/red_planet.png', width: 66,height: 66,  left: 555, top: 180})
# # b.fill([atome:  :kb, repeat: {x: 8, y: 1}])
# # b.drag(true)
# #
# #
# # b2=box({width: 1200, height: 298,  top: -100})
# # grab(:black_matter).image({id: :notes,path: 'medias/images/utils/notes.svg', width: 166, left: 55})
# # # grab(:black_matter).image({id: :planet,path: 'medias/images/red_planet.png', width: 66,height: 66,  left: 555, top: 180})
# # b2.fill([atome:  :notes, repeat: {x: 8, y: 5}])
# # b2.drag(true)
#
#
# JS.eval("
# // Fonction pour créer les divs
# function createDivs() {
#   // Démarrer le chronomètre
#   const startTime = performance.now();
#
#   const view = document.getElementById('view');
#   //view.innerHTML = '';  // Nettoyer le contenu précédent de 'view' si nécessaire
#
#   // Boucle pour créer 98 divs sur l'axe X
#   for (let i = 0; i < 98; i++) {
#     const xDiv = document.createElement('div');
#     xDiv.style.display = 'flex';
#     xDiv.style.flexDirection = 'column';
#     xDiv.style.margin = '2px';  // Marge entre les divs de l'axe X
#
#     // Boucle pour créer 128 divs sur l'axe Y
#     for (let j = 0; j < 128; j++) {
#       const yDiv = document.createElement('div');
#       yDiv.style.width = '10px';  // Largeur de chaque div sur l'axe Y
#       yDiv.style.height = '10px'; // Hauteur de chaque div sur l'axe Y
#       yDiv.style.border = '1px solid black';  // Bordure pour rendre les divs visibles
#       yDiv.style.boxSizing = 'border-box';    // Inclure la bordure dans les dimensions
#       xDiv.appendChild(yDiv);
#     }
#
#     view.appendChild(xDiv);
#   }
#
#   // Arrêter le chronomètre
#   const endTime = performance.now();
#   const timeTaken = endTime - startTime;
#
#   // Afficher le temps écoulé en console
#  alert(`Temps écoulé pour créer les divs : ${timeTaken.toFixed(2)} ms`);
# }
#
# // Ajouter un écouteur d'événements au div 'the_box'
# document.getElementById('the_box').addEventListener('click', createDivs);
# ``
#
# ")

new({particle: :merge})
a=box
c=box
d=a.merge(c)