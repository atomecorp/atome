require 'uglifier'
minify=Dir.glob('../www/public/js/third_parties//**/*')
minify.each do |lib|
if lib.end_with?("js")
 lib = '../www/public/js/third_parties/rendering_engines/zim.min.js'
 uglified = Uglifier.new(harmony: true).compile(File.read(lib))
  open(lib, 'w') do |f|
    f.puts uglified
  end
end
end


