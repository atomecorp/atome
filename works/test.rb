
dir_to_inspect= Dir.glob('../www/public/medias/**/*')
dir_to_inspect_2= Dir.glob('../eVe/medias/**/*')

nb_of_medias_files = (dir_to_inspect.length+dir_to_inspect_2.length).to_s

nb_of_medias_files_stored=File.read("nb_of_medias_files")
#puts nb_of_medias_files_stored

if nb_of_medias_files.to_i == nb_of_medias_files_stored.to_i
  puts "do nothing its all good"
else
  puts ":"+nb_of_medias_files+":"
  puts ":"+nb_of_medias_files_stored+":"
  File.write("nb_of_medias_files", nb_of_medias_files)
end


