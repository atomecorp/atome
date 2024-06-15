# frozen_string_literal: true

box({ id: :the_box, drag: false, color: {alpha: 0} })

menu1_code = lambda do
  puts :menu1_code
end
menu2_code = lambda do
  puts :menu2
end
b=buttons({
            id: :menu1,
            attach: :the_box,

            inactive: { text: { color: :gray }, width: 66, height: 12, spacing: 133, disposition: :horizontal,
                        color: :orange, margin: { left: 33, top: 12 } },
            active: { text: { color: :white, shadow: {} }, color: :blue, shadow: {} },
            item_1: {
              text: :acceuil,
              code: menu1_code
            },
            item_2: {
              text: :page_2,
              code: menu2_code

            },
            item_3: {
              text: :page_3,
            },
          })
# alert Universe.atomes.length

# wait 1 do
#
#
#   b.delete({recursive: true})
  # alert Universe.atomes.length
  wait 1 do
    prev_data= b.data
    essential_keys = ["id", "attach", "inactive", "active"]
    # Créer le premier hachage en utilisant les clés spécifiées
    essential_data = prev_data.select { |key, value| essential_keys.include?(key) }
    # Créer le deuxième hachage en enlevant les clés du premier hachage de l'original
    prev_menu_content = prev_data.reject { |key, value| essential_keys.include?(key) }
    menu2_code = lambda do
      puts "new_code"
    end
    b.fasten.each do |item_id|
      item=grab(item_id)
      item.touch(false)
      item.touch(:down) do
      end
    end
    verif= lambda do
      puts 'so coooll!!!'
    end

    new_data=prev_menu_content.merge(essential_data).merge({
                                              item_1: {
                                                text: :ok,
                                                code: menu1_code
                                              },
                                              item_5: {
                                                text: :kool,
                                                code: menu2_code
                                              },
                                              item_6: {
                                                code: verif,
                                                text: :super,
                                              }

                                  })

    # puts "#{prev_menu_content} \n<=====>\n #{new_data}"
    # b.fasten.each do |item_id|
    #   item=grab(item_id)
    #   item.touch(false)
    # end
    b.delete({recursive: true})
    buttons(new_data)
    # buttons({
    #           id: :menu1,
    #           attach: :the_box,
    #
    #           inactive: { text: { color: :gray }, width: 66, height: 12, spacing: 133, disposition: :horizontal,
    #                       color: :orange, margin: { left: 33, top: 12 } },
    #           active: { text: { color: :white, shadow: {} }, color: :blue, shadow: {} },
    #           item_1: {
    #             text: :acceuil,
    #             code: menu1_code
    #           },
    #           item_2: {
    #             text: :page_2,
    #             code: menu2_code
    #
    #           },
    #           item_3: {
    #             text: :page_3,
    #           },
    #         })
  end
# end
# wait 2 do
#   b.update({ item_4: {
#     text: :page_4_added,
#   } })
# end


# b=box
# b.touch(:down) do
#   alert :hello
# end
#
#
# # wait 2 do
#   b.touch(false)
#   # wait 7 do
#     b.touch(:down) do
#       alert :super
#     end
#   # end
# # end
# TODO: remove menu_item , add menu_item, reset_menu