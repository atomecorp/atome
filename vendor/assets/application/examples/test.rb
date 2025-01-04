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
#
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
# class EPol
#   def self.open(*args)
#     puts "=======> EPol File Custom open called with arguments: #{args.inspect}"
#     # new  # Retourne une instance de AFile
#   end
#
#   def method_missing(name, *args, &block)
#     puts "=======> EPol File Method '#{name}' called with arguments: #{args.inspect}"
#   end
# end
#
# #
# # # Écriture dans un fichier
# #
# # File.open(“exemple.txt”, “w”) do |f|
# #   f.puts "hello world"
# # end
# #
# # # Lister les fichiers d’un dossier
# #
# # dossier = “chemin_du_dossier”
# # fichiers = Dir.entries(dossier).select { |f| File.file?(File.join(dossier, f)) }
# #
# # # Parcourir les fichiers d’un dossier
#
#
# EPol.foreach('./') do |f|
#   puts f unless EFile.directory?("./#{f}")
# end
#
#
#
# fichier = EFile.open("index.rb","r")
# # contenu = fichier.read
# # puts contenu
# # fichier.close
#
#
#
#
#
#
#

