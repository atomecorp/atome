
require "uglifier"
require "fileutils"
 
 def minify path
   newpath=path.gsub(".js",".min.js")
   uglified = Uglifier.new(harmony: true).compile(File.read(path))
    File.open(newpath, "w") do |f|
      f.puts uglified
    end
   
 end
 

#usage : minify "zim.js"