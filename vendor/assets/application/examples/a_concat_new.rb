# Nom du fichier de sortie
output_file = "Apis_examples.rb"

# Chemin du dossier contenant les fichiers à récupérer
dossier = "./examples"

# Ouvrir le fichier de sortie en mode écriture
File.open(output_file, "w") do |fichier_sortie|
  # Liste tous les fichiers dans le dossier spécifié
  Dir.glob(File.join(dossier, "*")).each do |fichier|
    # Vérifie si le chemin pointe vers un fichier (plutôt qu'un sous-dossier)
    if File.file?(fichier)
      # Récupère le nom du fichier
      fichier_nom = File.basename(fichier)

      # Lit le contenu du fichier
      contenu = File.read(fichier)

      # Écrit le nom du fichier en tant que commentaire
      fichier_sortie.puts("# =====> example : #{fichier_nom}\n\n")
      
      # Écrit le contenu du fichier
      fichier_sortie.puts(contenu)

      # Ajoute une ligne vide pour séparer les fichiers
      fichier_sortie.puts("\n#-----------------------------\n\n")
    end
  end
end

puts "Terminé ! Les fichiers ont été combinés dans #{output_file}."
