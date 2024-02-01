path = ARGV[0]
name = ARGV[1]

File.open("#{path}#{name}.txt", 'w') do |f|
  f.write("Le chemin ; #{path}!\n")
  f.write("Le nom du fichier #{name}\n")
end

# `gphoto2 --capture-image-and-download --filename "../src/medias/images/photos/verif.jpg"`
`gphoto2 --capture-image-and-download --filename "#{path}#{name}.jpg"`
