require 'opal'
require 'opal-jquery'
require 'opal-browser'
require 'uglifier'
rm_f 'app/temp/media_list.rb'

directory 'www/public/js/third_parties/opal'

file 'www/public/js/third_parties/opal/opal.js': ['www/public/js/third_parties/opal'] do |t|
  #require 'opal'
  #require 'opal-jquery'
  #require 'opal-browser'
  builder = Opal::Builder.new
  builder.build('opal')
  builder.build('opal-jquery')
  builder.build('opal-browser')
  File.write(t.name, builder.to_s)
end

file 'www/public/js/third_parties/opal/opal_parser.js': ['www/public/js/third_parties/opal'] do |t|
  require 'opal'
  parser = Opal::Builder.new
  parser.build('./opal_compiler/lib/parser.rb')
  File.write(t.to_s, parser.to_s)
end

directory 'app/temp'

file 'app/temp/media_list.rb': ['app/temp'] do |t|
  require 'image_size'
  images = Dir.glob('./www/public/medias/images/**/*').select { |e| File.file? e }
  images_list = {}
  videos = Dir.glob('./www/public/medias/videos/**/*').select { |e| File.file? e }
  videos_list = {}
  audios = Dir.glob('./www/public/medias/audios/**/*').select { |e| File.file? e }
  audios = audios.concat(videos)
  audios_list = {}

  images.each do |image|
    path = image.sub('www/public/', './')
    filename = File.basename(image, File.extname(image))
    image_info = ImageSize.path(image)
    width = image_info.width
    height = image_info.height
    images_list[filename.to_sym] = {width: width, height: height, path: path}
  end

  videos.each do |video|
    path = video.sub('www/public/', './')
    filename = File.basename(video, File.extname(video))
    videos_list[filename.to_sym] = {path: path}
  end

  audios.each do |audio|
    path = audio.sub('www/public/', './')
    filename = File.basename(audio, File.extname(audio))
    audios_list[filename.to_sym] = {path: path}
  end

  medias_list = '$images_list=' + images_list.to_s + "\n$videos_list=" + videos_list.to_s + "\n$audios_list=" + audios_list.to_s

  File.open(t.name, 'w') { |file| file.write(medias_list) }
end

atome_monitoring = ['app/temp/media_list.rb', 'opal_compiler/lib/opal_addon.rb', 'renderers/html.rb', 'app/app.rb', 'atome/lib/atome/environment/require.rb', 'atome/lib/atome/builder/object.rb'] + Dir.glob('app//*')
file 'www/public/js/atome.js': atome_monitoring do |t|
  #require 'opal'
  builder = Opal::Builder.new
  builder.append_paths('atome/lib')
  builder.build('./app/temp/media_list.rb')
  builder.build('./opal_compiler/lib/opal_addon.rb')
  builder.build('./renderers/html.rb')
  builder.build('atome')
  if File.exist?('./eVe')
    builder.build('./eVe/app.rb')
  else
    builder.build('./app/app.rb')
  end
  File.write(t.name, builder.to_s)
end

opal = 'www/public/js/third_parties/opal/opal.js'
parser = 'www/public/js/third_parties/opal/opal_parser.js'
atome = 'www/public/js/atome.js'


desc 'Run server'
task 'run::server': [opal, parser, atome] do
  Dir.chdir('www') do
    require 'rack'
    #below we put the browser opening in a thread to delay wating for th server to be ready
    Thread.new do
      sleep 2
      system("open", "http://localhost:9292")
    end
    sh 'rackup --server puma --port 9292 --env production'
    #Rack::Server.start(config: 'config.ru', server: 'puma')

  end
end

desc 'Run browser'
task 'run::browser': [opal, parser, atome] do
  sh 'cordova run browser'
end

desc 'Run osx'
task 'run::osx': [opal, parser, atome] do
  sh 'cordova run osx'
end

desc 'Run ios'
task 'run::ios': [opal, parser, atome] do
  sh 'cordova run ios'
end


desc 'Run android'
task 'run::android': [opal, parser, atome] do
  sh 'cordova run android'
end

desc 'Run windows'
task 'run::windows': [opal, parser, atome] do
  sh 'cordova run windows --arch="x64"'
end

desc 'Run electron'
task 'run::electron': [opal, parser, atome] do
  sh 'cordova run electron'
end

#production modes

def production opal, parser, atome
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
task 'production::server': [opal, parser, atome] do
  production opal, parser, atome
  Dir.chdir('www') do
    require 'rack'
    system("open", "http://127.0.0.1:9292")
    sh 'rackup'
    #Rack::Server.start(config: 'config.ru', server: 'puma')
  end
end

desc 'production browser'
task 'production::browser': [opal, parser, atome] do
  production opal, parser, atome
  sh 'cordova run browser'
end

desc 'production osx'
task 'production::osx': [opal, parser, atome] do
  production opal, parser, atome
  sh 'cordova run osx'
end

desc 'production ios'
task 'production::ios': [opal, parser, atome] do
  production opal, parser, atome
  sh 'cordova run ios'
end


desc 'production android'
task 'production::android': [opal, parser, atome] do
  production opal, parser, atome
  sh 'cordova run android'
end

desc 'production windows'
task 'production::windows': [opal, parser, atome] do
  production opal, parser, atome
  sh 'cordova run windows'
end

desc 'production electron'
task 'production::electron': [opal, parser, atome] do
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