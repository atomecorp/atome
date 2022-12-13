def run_demo
  scripts = %i[animation atome.new auto_height auto_width bottom box circle
color create_atome_in_atome drag get_renderer_list grab height image
left link parent read repeat right rotate schedule smooth text
top touch video wait web width]

  scripts.each_with_index do |toto, index|
    wait 1 * index do
      puts toto
      read("examples/#{toto}.rb", :ruby)
      `console.clear()`
    end
  end
end

run_demo