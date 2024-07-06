# frozen_string_literal: true

# t = text({ int8: { english: :hello, french: :salut, deutch: :halo } })

# wait 1 do
#   t.language(:french)
#   wait 1 do
#     t.language(:english)
#     # data is updated to the latest choice
#     puts t.data
#     wait 1 do
#       t.data(:hi)
#     end
#   end
# end

Universe.translation[:hello] = { english: :hello, french: :salut, deutch: :halo }

b = box({ left: 155,
          drag: true,
          id: :boxy })
# b.drag(true) do
#   puts 'hhh'
# end

t=b.text({ data: :hello, id: :t1, position: :absolute, color: :black })
t2 = b.text({ data: :hello, id: :t2, left: 9, top: 33, position: :absolute })

# wait 1 do
#   b.instance_variable_set('@top', 255)
#   # b.refresh
#   wait 1 do
#     # refresh
#   end
# end

# b.refresh


Universe.language = :french
wait 2 do
  # puts "1"

  # t.refresh
  t2.refresh
  Universe.language = :deutch
  ########

  wait 2 do
  #
    Universe.language = :deutch
    # grab(:t2).refresh
  # grab(:boxy).refresh
  # grab(:view).refresh
  # refresh
  alert "retrieve( true , true) , first true is order second is include self"
  grab(:boxy).refresh

  # grab(:boxy).retrieve( true , true) do |child|
  #   child.refresh
  # end
  #
  #
  #   atome_ids_found=grab(:view).fasten.dup
  #   atome_ids_found.each do |atome_id_found|
  #     atome_id_found=atome_id_found.to_sym
  #     # alert atome_id_found
  #     grab(atome_id_found).refresh
  #   end
  end

  #######



end

    # t.language(:english)
    # alert t.language
    # wait 1 do
    #   t.refresh
    # end
    # wait 1 do
    #
    #   wait 1 do
    #     t.data(:hi)
    #     wait 1 do
    #       t.data(:hello)
    #       wait 1 do
    #         Universe.language=:english
    #         t.refresh
    #         # t.data(:hello)
    #       end
    #     end
    #   end
    # end
    # puts t.data

    # Universe.language=:english
    # Universe.translation[:hello]={ english: :hello, french: :salut, deutch: :halo }
    #
    # c=circle({drag: true})
    # a=c.text({id: :tutu, data: :hello})
    #
    # Universe.language=:french
    # a.color(:red)
    #
    #
    # wait 1 do
    #   id_found=a.id
    #   a.id(:item_to_trash)
    #    a.duplicate({ id: id_found})
    # end



grab(:boxy).instance_variable_set('@left', 555)
# grab(:boxy).refresh
# alert grab(:view).attach
# wait 3 do
#
#   grab(:view).retrieve do |child|
#     grab(:boxy).refresh
#       wait 0.1 do
#         child.refresh
#       end
#
#   end
# end

# wait 5 do
#   parent = grab(:view)
#   grab(:view).retrieve(:inverted) do |child|
#     child.delete(true)
#   end
# end

