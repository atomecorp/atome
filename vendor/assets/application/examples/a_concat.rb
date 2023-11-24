# Chemin du dossier contenant les fichiers
folder_path = "./*"

# Chemin du fichier de sortie
output_file_path = "./!all.rb"

# Création et ouverture du fichier de sortie
File.open(output_file_path, "w") do |output_file|
  # Lecture de tous les fichiers du dossier
  Dir.glob(folder_path).each do |file_path|
    # Lecture et écriture du contenu de chaque fichier
    File.read(file_path).each_line do |line|
      output_file.write(line)
    end
  end
end