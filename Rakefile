# require "c_lexer"
require "opal"
require "opal-jquery"
require "uglifier"
require "fileutils"
require "filewatcher"
unless File.directory?("app/temp")
  FileUtils.mkdir_p("app/temp")
end

def generate_demos_list
  require "./scripts/demo_generator.rb"
end


def generate_methods
  require "./scripts/properties_generator.rb"
end


def update_opal_libraries
  file 'www/public/js/dynamic_libraries/opal/opal.js': ["www/public/js/dynamic_libraries/opal"] do |t|
    opal = Opal::Builder.new
    opal.build("opal")
    File.write(t.name, opal.to_s)
  end

  file 'www/public/js/dynamic_libraries/opal/opal_jquery.js': ["www/public/js/dynamic_libraries/opal"] do |t|
    parser = Opal::Builder.new
    parser.build("opal-jquery")
    File.write(t.to_s, parser.to_s)
  end

  file 'www/public/js/dynamic_libraries/opal/opal_parser.js': ["www/public/js/dynamic_libraries/opal"] do |t|
    parser = Opal::Builder.new
    parser.build('./atome/lib/atome/extensions/opal/opal_parser.rb')
    File.write(t.to_s, parser.to_s)
  end
end


def update_medias_list
  # todo : only copy if there's a change! use monitoring if possible
  if File.directory?("eVe/medias/.")
    FileUtils.cp_r "eVe/medias/.", "www/public/medias/"
  end
  rm_f "app/temp/media_list.rb"
  file 'app/temp/media_list.rb': ["app/temp"] do |t|
    require "image_size"
    a_images = Dir.glob("./www/public/medias/images/**/*").select { |e| File.file? e }
    e_images = Dir.glob("./www/public/medias/e_images/**/*").select { |e| File.file? e }
    images = a_images.concat(e_images)
    images_list = {}
    a_videos = Dir.glob("./www/public/medias/videos/**/*").select { |e| File.file? e }
    e_videos = Dir.glob("./www/public/medias/e_videos/**/*").select { |e| File.file? e }
    videos = a_videos.concat(e_videos)
    videos_list = {}
    a_audios = Dir.glob("./www/public/medias/audios/**/*").select { |e| File.file? e }
    e_audios = Dir.glob("./www/public/medias/e_audios/**/*").select { |e| File.file? e }
    audios = a_audios.concat(e_audios)
    audios = audios.concat(videos)
    audios_list = {}

    images.each do |image|
      path = image.sub("www/public/", "./")
      filename = File.basename(image, File.extname(image))
      image_info = ImageSize.path(image)
      width = image_info.width
      height = image_info.height
      unless width
        width=333
      end
      unless height
        height=333
      end
      images_list[filename.to_sym] = { width: width, height: height, path: path }
    end

    videos.each do |video|
      path = video.sub("www/public/", "./")
      filename = File.basename(video, File.extname(video))
      videos_list[filename.to_sym] = { path: path }
    end

    audios.each do |audio|

      path = audio.sub("www/public/", "./")
      filename = File.basename(audio, File.extname(audio))
      audios_list[filename.to_sym] = { path: path }
    end
    medias_list = "$images_list=" + images_list.to_s + "\n$videos_list=" + videos_list.to_s + "\n$audios_list=" + audios_list.to_s
    medias_list = medias_list + "\n" + "module Universe\ndef self.images\n#{images_list}\nend\ndef self.videos\n#{videos_list}\nend\ndef self.audios\n#{audios_list}\nend\nend"
    File.open(t.name, "w") { |file| file.write(medias_list) }
  end
end

medias_dir_to_inspect = Dir.glob("www/public/medias/**/*")
eve_medias_dir_to_inspect = Dir.glob("eVe/medias/**/*")
nb_of_medias_files = (medias_dir_to_inspect.length + eve_medias_dir_to_inspect.length).to_s

unless File.exist?("app/temp/nb_of_medias_files")
  File.write("app/temp/nb_of_medias_files", "")
end

nb_of_medias_files_stored = File.read("app/temp/nb_of_medias_files")
# we only update the media lib if there"s a change in number of medias file
if nb_of_medias_files != nb_of_medias_files_stored || !File.file?("app/temp/nb_of_medias_files")
  update_medias_list
  File.write("app/temp/nb_of_medias_files", nb_of_medias_files)
end
media_monitoring = unless File.file?("app/temp/media_list.rb")
                     update_medias_list
                   end
FileUtils.mkdir_p "www/public/js/dynamic_libraries/"
file 'www/public/js/dynamic_libraries/atome_medias.js': media_monitoring do |t|
  builder = Opal::Builder.new
  builder.build("./app/temp/media_list.rb")
  File.write(t.name, builder.to_s)
end

directory "www/public/js/dynamic_libraries/opal"
directory "app/temp"

atome_monitoring = Dir.glob("atome/lib/**/*")
file 'www/public/js/dynamic_libraries/atome.js': atome_monitoring do |t|
  builder = Opal::Builder.new
  builder.append_paths("atome/lib")
  builder.build("atome")
  File.write(t.name, builder.to_s)
end

app_monitoring = Dir.glob("app/**/*") + Dir.glob("eVe/app.rb") + Dir.glob("eVe/projects/**/*") + Dir.glob("eVe/eVe/lib/**/*")
file 'www/public/js/dynamic_libraries/atome_app.js': app_monitoring do |t|
  builder = Opal::Builder.new
  if File.exist?("./eVe")
    builder.build("./eVe/app.rb")
  else
    builder.build("./app/app.rb")
  end
  File.write(t.name, builder.to_s)
end

opal = "www/public/js/dynamic_libraries/opal/opal.js"
opal_jquery = "www/public/js/dynamic_libraries/opal/opal_jquery.js"
parser = "www/public/js/dynamic_libraries/opal/opal_parser.js"
atome = "www/public/js/dynamic_libraries/atome.js"
atome_app = "www/public/js/dynamic_libraries/atome_app.js"
atome_medias = "www/public/js/dynamic_libraries/atome_medias.js"

required_js_lib = [opal, opal_jquery, parser, atome, atome_app, atome_medias]

desc "Run atomic_reaction"
task 'run::atomic_reaction': required_js_lib do
end

desc "Run server"
task 'run::server': required_js_lib do
  Dir.chdir("www") do
    require "rack"
    # below we put the browser opening in a thread to delay waiting for th server to be ready
    # todo:  wait for page to respond instead of 2 sec sleep
    # Thread.new do
    #   sleep 2
    #   system("open", "http://localhost:9292")
    # end
    # sh "puma -b tcp://127.0.0.1:9292"
    ##sh "puma -b 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'"
    sh "rackup --server puma --port 9292  --env production"
    #Rack::Server.start(config: 'config.ru', server: 'puma')
    #https version:
    #Thread.new do
    #  sleep 2
    #  system("open", "https://localhost:9292")
    #end
    #sh 'puma -b "ssl://127.0.0.1:9292?key=localhost.key&cert=localhost.crt"'
  end
end

desc "Run browser"
task 'run::browser': required_js_lib do
  sh "cordova run browser"
end

desc "Run osx"
task 'run::osx': required_js_lib do
  sh "cordova run osx"
end

desc "Run ios"
task 'run::ios': required_js_lib do
  sh "cordova run ios"
end

desc "Run android"
task 'run::android': required_js_lib do
  sh "cordova run android"
end

desc "Run windows"
task 'run::windows': required_js_lib do
  sh 'cordova run windows --arch="x64"'
end

desc "Run electron"
task 'run::electron': required_js_lib do
  sh "cordova run electron"
end

# production modes

def production(opal, opal_jquery, parser, atome)
  uglified = Uglifier.new(harmony: true).compile(File.read(opal))
  File.open(opal, "w") do |f|
    f.puts uglified
  end

  uglified = Uglifier.new(harmony: true).compile(File.read(opal_jquery))
  File.open(opal_jquery, "w") do |f|
    f.puts uglified
  end

  uglified = Uglifier.new(harmony: true).compile(File.read(parser))
  File.open(parser, "w") do |f|
    f.puts uglified
  end

  uglified = Uglifier.new(harmony: true).compile(File.read(atome))
  File.open(atome, "w") do |f|
    f.puts uglified
  end
end

desc "production server"
task 'production::server': required_js_lib do
  production opal, opal_jquery, parser, atome
  Dir.chdir("www") do
    require "rack"
    system("open", "http://127.0.0.1:9292")
    sh "rackup"
    # Rack::Server.start(config: 'config.ru', server: 'puma')
  end
end

desc "production browser"
task 'production::browser': required_js_lib do
  production opal, opal_jquery, parser, atome
  sh "cordova run browser"
end

desc "production osx"
task 'production::osx': required_js_lib do
  production opal, opal_jquery, parser, atome
  sh "cordova run osx"
end

desc "production ios"
task 'production::ios': required_js_lib do
  production opal, opal_jquery, parser, atome
  sh "cordova run ios"
end

desc "production android"
task 'production::android': required_js_lib do
  production opal, opal_jquery, parser, atome
  sh "cordova run android"
end

desc "production windows"
task 'production::windows': required_js_lib do
  production opal, opal_jquery, parser, atome
  sh "cordova run windows"
end

desc "production electron"
task 'production::electron': required_js_lib do
  production opal, opal_jquery, parser, atome
  sh "cordova run electron"
end

# desc "Cleanup generated files"
# task "clean" do
#   rm_f "app/temp/media_list.rb"
#   rm_f "www/public/js/dynamic_libraries/atome.js"
#   rm_f "www/public/js/dynamic_libraries/atome_app.js"
#   rm_f "www/public/js/dynamic_libraries/atome_medias.js"
#   rm_f "www/public/js/dynamic_libraries/opal/opal.js"
#   rm_f "www/public/js/dynamic_libraries/opal/opal_parser.js"
# end

def cleanup_temp_files
  rm_f "app/temp/media_list.rb"
  rm_f "app/temp/nb_of_medias_files.rb"
  rm_f "www/public/js/dynamic_libraries/atome.js"
  rm_f "www/public/js/dynamic_libraries/atome_app.js"
  rm_f "www/public/js/dynamic_libraries/atome_medias.js"
  rm_f "www/public/js/dynamic_libraries/opal/opal.js"
  rm_f "www/public/js/dynamic_libraries/opal/opal_parser.js"
end


generate_demos_list
generate_methods
# update_opal_libraries
# # to force update media_list uncomment below
# update_medias_list
# # to cleanup all generated files
# cleanup_temp_files