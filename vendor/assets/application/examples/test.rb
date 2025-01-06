# frozen_string_literal: true

def contact_template
  { id: :humans, role: nil, date: { companies: [], project: {}, events: {}, last_name: nil, first_name: nil,
                                    emails: { home: nil }, phones: {}, address: {}, groups: [] } }
end

element({ id: :testing, data: contact_template })
# grab(:testing).data(contact_template)

wait 2 do
  grab(:testing).data
end

def api_infos
  {
    "example": "Purpose of the example",
    "methods_found": []
  }
end

########## new tests

atome_object_list = {
  particles: Universe.particle_list.keys,
  atomes: Universe.atome_list,
  molecules: Universe.molecule_list,
  preset: Universe.preset_list,

}

################ code to develop #######################
A.browser("../src/medias/utils/examples")
########################################################
b = box
b.touch(true) do
  A.write({ name: './my file.txt', content: "my texte is ...." }) do |data|
    text "file content  :\n #{data}"
  end
  wait 0.5 do
    A.read('./my file.txt') do |data|
      text "file content  :\n #{data}"
    end
  end

  wait 2 do
    A.terminal('pwd') do |data|
      text "terminal response  :\n #{data}"
      path_f = data.chomp + '/atome_server.rb'
      text "path is : #{path_f}"

    end
  end

  wait 1 do
    A.terminal('ls') do |data|
      text "terminal response  :\n #{data}"
    end
  end
end

# class EFile
#   def self.open(*args)
#     puts "=======> File Custom open called with arguments: #{args.inspect}"
#     # new  # Retourne une instance de AFile
#   end
#
#   def method_missing(name, *args, &block)
#     puts "=======> File Method '#{name}' called with arguments: #{args.inspect}"
#   end
# end
#
# def send_dir_to_server(var)
#   puts "===> Sending directory to server: #{var}"
#   # Simule une réponse du serveur avec une liste de fichiers
#   ['file1.txt', 'file2.rb', 'file3.md']
# end
#
# class EDir
#   def self.foreach(path)
#     files = send_dir_to_server(path) # Appel au serveur pour récupérer la liste des fichiers
#     files.each do |file|
#       yield file if block_given?
#     end
#   end
#
#   def method_missing(name, *args, &block)
#     send_dir_to_server(name)
#   end
# end
#
# #
# # # Écriture dans un fichier
# #
# EFile.open(“index.rb”, “w”) do |f|
#   f.puts "hello world"
# end
# #
# # # Lister les fichiers d’un dossier
# #
# # dossier = “chemin_du_dossier”
# # fichiers = Dir.entries(dossier).select { |f| File.file?(File.join(dossier, f)) }
# #
# # # Parcourir les fichiers d’un dossier
#
#
# # EDir.foreach('./') do |f|
# #   puts f unless EFile.directory?("./#{f}")
# # end
#
#
#
# fichier = EFile.open("index.rb","r")
# # contenu = fichier.read
# # puts contenu
# # fichier.close

# ####################### works

# # Appel principal avec bloc
# b = image('waveform')
# atomes_found = b.dig
#
# found_area_used(atomes_found) do |result|
#   total_width = result[:max][:x] - result[:min][:x]
#   total_height = result[:max][:y] - result[:min][:y]
#   alert total_width
#   alert total_height
# end

# b=box
# b=image('red_planet')
#
#   atomes_found = b.dig
# # alert b.dig
# # alert b.dig.class
#   total_width = found_area_used(atomes_found)[:max][:x] - found_area_used(atomes_found)[:min][:x]
#   # total_height = found_area_used(atomes_found)[:max][:y] - found_area_used(atomes_found)[:min][:y]
#   alert total_width

