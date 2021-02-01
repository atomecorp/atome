
dir_to_inspect= Dir.glob('../www/public/medias/**/*')
dir_to_inspect_2= Dir.glob('../eVe/medias/**/*')

nb_of_medias_files = (dir_to_inspect.length+dir_to_inspect_2.length).to_s

nb_of_medias_files_stored=File.read("../cache/nb_of_medias_files")

unless nb_of_medias_files == nb_of_medias_files_stored
  File.write("../cache/nb_of_medias_files", nb_of_medias_files)
end


