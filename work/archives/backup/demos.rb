######### demos
# we create a code container
element({ id: :code_container, data: :empty })
puts "Attention this method only work with a server due to security restriction "
demo_container = grab('intuition').box({ id: :demo_container, left: 0, overflow: :scroll, height: 567 })
clearer = grab('intuition').circle({ top: 3, left: 3, width: 39, height: 39, color: :orange, id: :debugger })
view_code = grab('intuition').circle({ top: 3, left: 99, width: 39, height: 39, color: :red, id: :clearer })
# view=grab(:view)
view_code.touch(true) do
  code = grab(:code_container).data
  grab(:view).text({ data: code, width: :auto, height: 333, left: :auto, depth: 33, right: 0, overflow: :scroll })
end

clearer.touch(true) do
  grab(:view).clear(true)
  # atomes_found=[]
  # Universe.atomes.each do |atome_id_found, _atome_content_found|
  #   atomes_found << atome_id_found
  # end
end

context = grab(:view)
demo_container.read('rubies/demos_list.rb') do |demos_found|
  # we eval the demo list
  eval demos_found
  demos_list.each_with_index do |demo, index|
    current_demo = demo_container.text ({ data: demo, top: 16 * index, left: 12, visual: { size: 12 } })
    current_demo.touch(true) do
      # TODO : create a ruby method for console clear
      `console.clear()`
      atome_infos
      puts "current demo: #{demo}"
      context.clear(true)
      # atomes_fasten=context.fasten
      users_atomes = []
      Universe.atomes.each do |k, _v|
        users_atomes << k
      end

      # puts "=> before > atomes fasten : #{atomes_fasten}"
      # puts "==-> before > users_atomes : #{users_atomes}"

      # we delete/clear the prev scene
      # atomes_fasten.each do |atome_id_found|
      #   unless atome_id_found == :view_color
      #     atome_found=grab(atome_id_found)
      #     atome_found.delete(true) if atome_found
      #   end
      # end
      # we eval the demo content
      demo_container.read('rubies/examples/' + demo) do |demo_requested|
        grab(:view).eval demo_requested
        grab(:code_container).data(demo_requested)
      end
      # puts "=> after >atomes fasten : #{atomes_fasten}"
      # puts "==-> after > users_atomes : #{users_atomes}"

    end
  end
end