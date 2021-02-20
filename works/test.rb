#
#dir_to_inspect= Dir.glob('../www/public/medias/**/*')
#dir_to_inspect_2= Dir.glob('../eVe/medias/**/*')
#
#nb_of_medias_files = (dir_to_inspect.length+dir_to_inspect_2.length).to_s
#
#nb_of_medias_files_stored=File.read("../cache/nb_of_medias_files")
#
#unless nb_of_medias_files == nb_of_medias_files_stored
#  File.write("../cache/nb_of_medias_files", nb_of_medias_files)
#end
#


# hash={"type"=>"particle", "content"=>nil, "atome_id"=>"a_74", "id"=>"particle_74"}
# hash= hash.sort_by  do |k, v|
#   -k.length
#  end.to_h

# puts hash
# hash={"type"=>"particle", "content"=>:kool, "atome_id"=>"a_74", "id"=>"particle_74"}
#
# a=[:content,:atome_id , :id,:type ]
# puts hash.sort_by_array(a)

# class Hash
#   def sort_by_array a; Hash[sort_by{|k, _| a.index(k) || length}] end
# end
#
#
# a = [:content,:atome_id , :id,:type ]
# hash={:type=>"particle", :content=>:kool, :atome_id=>"a_74", :id=>"particle_74"}
# hash=hash.sort_by_array(a)
# puts hash

#                           a = ["Is", "Gandalf", "The", "Gray", "Insane"]
# hash={:count=>21, "Is"=>19, "Gandalf"=>1, "Gray"=>0, "Insane"=>1, "The"=>5}
# hash=hash.sort_by_array(a)
# puts hash
require 'filewatcher'
Filewatcher.new(['/Users/jean-ericgodard/Desktop/atome/eVe/', '/Users/jean-ericgodard/Desktop/atome/atome/']).watch do |changes|
  puts :poil
  #changes.each do |filename, event|
  #  puts "#{filename} #{event}"
  #end
end

