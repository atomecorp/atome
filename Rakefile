require 'c_lexer'
require 'opal'
require 'opal-jquery'
# require 'opal-browser'
require 'uglifier'
require 'fileutils'

def update_opal_libraries
  file 'www/public/js/third_parties/opal/opal.js': ['www/public/js/third_parties/opal'] do |t|
    builder = Opal::Builder.new
    builder.build('opal')
    builder.build('opal-jquery')
    # builder.build('opal-browser')
    File.write(t.name, builder.to_s)
  end
  file 'www/public/js/third_parties/opal/opal_parser.js': ['www/public/js/third_parties/opal'] do |t|
    require 'opal'
    parser = Opal::Builder.new
    parser.build('./opal_compiler/lib/parser.rb')
    File.write(t.to_s, parser.to_s)
  end
end

update_opal_libraries

def update_medias_list
  #todo : only copy if there's a change! use monitoring if possible
  if File.directory?("eVe/medias/.")
    FileUtils.cp_r "eVe/medias/.", "www/public/medias/"
  end
  rm_f 'app/temp/media_list.rb'
  file 'app/temp/media_list.rb': ['app/temp'] do |t|
    require 'image_size'
    a_images = Dir.glob('./www/public/medias/images/**/*').select { |e| File.file? e }
    e_images = Dir.glob('./www/public/medias/e_images/**/*').select { |e| File.file? e }
    images = a_images.concat(e_images)
    images_list = {}
    a_videos = Dir.glob('./www/public/medias/videos/**/*').select { |e| File.file? e }
    e_videos = Dir.glob('./www/public/medias/e_videos/**/*').select { |e| File.file? e }
    videos = a_videos.concat(e_videos)
    videos_list = {}
    a_audios = Dir.glob('./www/public/medias/audios/**/*').select { |e| File.file? e }
    e_audios = Dir.glob('./www/public/medias/e_audios/**/*').select { |e| File.file? e }
    audios = a_audios.concat(e_audios)
    audios = audios.concat(videos)
    audios_list = {}

    images.each do |image|
      path = image.sub('www/public/', './')
      filename = File.basename(image, File.extname(image))
      image_info = ImageSize.path(image)
      width = image_info.width
      height = image_info.height
      images_list[filename.to_sym] = { width: width, height: height, path: path }
    end

    videos.each do |video|
      path = video.sub('www/public/', './')
      filename = File.basename(video, File.extname(video))
      videos_list[filename.to_sym] = { path: path }
    end

    audios.each do |audio|
      path = audio.sub('www/public/', './')
      filename = File.basename(audio, File.extname(audio))
      audios_list[filename.to_sym] = { path: path }
    end

    medias_list = '$images_list=' + images_list.to_s + "\n$videos_list=" + videos_list.to_s + "\n$audios_list=" + audios_list.to_s
    puts medias_list
    File.open(t.name, 'w') { |file| file.write(medias_list) }
  end
end

dir_to_inspect = Dir.glob('www/public/medias/**/*')
dir_to_inspect_2 = Dir.glob('eVe/medias/**/*')
nb_of_medias_files = (dir_to_inspect.length + dir_to_inspect_2.length).to_s
nb_of_medias_files_stored = File.read("cache/nb_of_medias_files")
# we only update the media lib if there"s a change in number of medias file
if nb_of_medias_files != nb_of_medias_files_stored || !File.file?('cache/nb_of_medias_files')
  update_medias_list
  File.write('cache/nb_of_medias_files', nb_of_medias_files)
end

if File.file?('app/temp/media_list.rb')
  media_monitoring = ['app/temp/media_list.rb']
else
  update_medias_list
  media_monitoring = ['app/temp/media_list.rb']
end
file 'www/public/js/atome_medias.js': media_monitoring do |t|
  builder = Opal::Builder.new
  builder.build('./app/temp/media_list.rb')
  File.write(t.name, builder.to_s)
end

directory 'www/public/js/third_parties/opal'
directory 'app/temp'

atome_monitoring = ['opal_compiler/lib/opal_addon.rb', 'renderers/html.rb'] + Dir.glob('atome/lib/**/*')
file 'www/public/js/atome.js': atome_monitoring do |t|
  builder = Opal::Builder.new
  builder.append_paths('atome/lib')
  builder.build('./opal_compiler/lib/opal_addon.rb')
  builder.build('./renderers/html.rb')
  builder.build('atome')
  File.write(t.name, builder.to_s)
end

app_monitoring = Dir.glob('app/**/*') + Dir.glob('eVe/app.rb') + Dir.glob('eVe/projects/**/*') + Dir.glob('eVe/eVe/lib/**/*')
file 'www/public/js/atome_app.js': app_monitoring do |t|
  builder = Opal::Builder.new
  if File.exist?('./eVe')
    # builder.append_paths('eVe/eVe/lib/')
    builder.build('./eVe/app.rb')
  else
    builder.build('./app/app.rb')
  end
  File.write(t.name, builder.to_s)
end

opal = 'www/public/js/third_parties/opal/opal.js'
parser = 'www/public/js/third_parties/opal/opal_parser.js'
atome = 'www/public/js/atome.js'
atome_app = 'www/public/js/atome_app.js'
atome_medias = 'www/public/js/atome_medias.js'

required_js_lib = [opal, parser, atome, atome_app, atome_medias]

desc 'Run server'
task 'run::server': required_js_lib do
  Dir.chdir('www') do
    require 'rack'
    #below we put the browser opening in a thread to delay waiting for th server to be ready
    # todo:  wait for page to respond instead of 2 sec sleep
    Thread.new do
      sleep 2
      system("open", "http://localhost:9292")
    end
    sh 'rackup --server puma --port 9292 --env production'
    #Rack::Server.start(config: 'config.ru', server: 'puma')
  end
end

desc 'Run browser'
task 'run::browser': required_js_lib do
  sh 'cordova run browser'
end

desc 'Run osx'
task 'run::osx': required_js_lib do
  sh 'cordova run osx'
end

desc 'Run ios'
task 'run::ios': required_js_lib do
  sh 'cordova run ios'
end

desc 'Run android'
task 'run::android': required_js_lib do
  sh 'cordova run android'
end

desc 'Run windows'
task 'run::windows': required_js_lib do
  sh 'cordova run windows --arch="x64"'
end

desc 'Run electron'
task 'run::electron': required_js_lib do
  sh 'cordova run electron'
end

#production modes

def production(opal, parser, atome)
  uglified = Uglifier.new(harmony: true).compile(File.read(opal))
  open(opal, 'w') do |f|
    f.puts uglified
  end

  uglified = Uglifier.new(harmony: true).compile(File.read(parser))
  open(parser, 'w') do |f|
    f.puts uglified
  end

  uglified = Uglifier.new(harmony: true).compile(File.read(atome))
  open(atome, 'w') do |f|
    f.puts uglified
  end
end

desc 'production server'
task 'production::server': required_js_lib do
  production opal, parser, atome
  Dir.chdir('www') do
    require 'rack'
    system("open", "http://127.0.0.1:9292")
    sh 'rackup'
    #Rack::Server.start(config: 'config.ru', server: 'puma')
  end
end

desc 'production browser'
task 'production::browser': required_js_lib do
  production opal, parser, atome
  sh 'cordova run browser'
end

desc 'production osx'
task 'production::osx': required_js_lib do
  production opal, parser, atome
  sh 'cordova run osx'
end

desc 'production ios'
task 'production::ios': required_js_lib do
  production opal, parser, atome
  sh 'cordova run ios'
end

desc 'production android'
task 'production::android': required_js_lib do
  production opal, parser, atome
  sh 'cordova run android'
end

desc 'production windows'
task 'production::windows': required_js_lib do
  production opal, parser, atome
  sh 'cordova run windows'
end

desc 'production electron'
task 'production::electron': required_js_lib do
  production opal, parser, atome
  sh 'cordova run electron'
end

desc 'Cleanup generated files'
task 'clean' do
  rm_f 'app/temp/media_list.rb'
  rm_f 'www/public/js/atome.js'
  rm_f 'www/public/js/third_parties/opal/opal.js'
  rm_f 'www/public/js/third_parties/opal/opal_parser.js'
end