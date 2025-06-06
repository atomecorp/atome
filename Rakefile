# frozen_string_literal: true

require 'fileutils'
require 'securerandom'
require 'digest/sha2'
require 'rubygems'
require 'rubygems/command_manager'
require 'rubygems/uninstaller'
require 'bundler/gem_tasks'
load 'exe/atome'

# folder_name = 'lib/eVe'
#
# # allow or deny eVe gem content to be copied to local eVe or not
# refresh_eVe=true
#
# # if refresh_eVe
# # # doesn't work
# #   `bundle update`
# # end
#
# unless Dir.exist?(folder_name)
#   Dir.mkdir(folder_name)
#     File.open('lib/eVe/eVe_relative.rb', 'w') do |file|
#     end
#     File.open('lib/eVe/eVe.rb', 'w') do |file|
#     end
# end

task :clean_derived_data do
  derived_data_path = File.expand_path("~/Library/Developer/Xcode/DerivedData")
  if Dir.exist?(derived_data_path)
    puts "Cleaning DerivedData..."
    FileUtils.rm_rf(derived_data_path)
    puts "DerivedData cleaned."
  else
    puts "DerivedData folder not found."
  end
end



task :auv3_ipad_opal => :test_opal do

  FileUtils.cp_r('./src/atomeAuv3/', './tmp/atomeAuv3/')
  FileUtils.cp_r('./tmp/test/src/', './tmp/atomeAuv3/')
  FileUtils.cp_r('./tmp/atomeAuv3/src/index_opal.html', './tmp/atomeAuv3/src/index.html')

  Dir.chdir('./tmp/atomeAuv3') do
    sh 'xcodebuild -project atome.xcodeproj ' \
         '-scheme atomeauv3 ' \
         '-destination "id=00008027-000520902E31802E" ' \
         'clean build install'
  end

  puts :sucess
end

task :auv3_ipad_wasm => :test_wasm do

  FileUtils.cp_r('./src/atomeAuv3', './tmp/atomeAuv3')
  FileUtils.cp_r('./tmp/test/src/', './tmp/atomeAuv3/')
  FileUtils.cp_r('./tmp/atomeAuv3/src/index_wasm.html', './tmp/atomeAuv3/src/index.html')

  Dir.chdir('./tmp/atomeAuv3') do
    sh 'xcodebuild -project atome.xcodeproj ' \
         '-scheme atomeauv3 ' \
         '-destination "id=00008027-000520902E31802E" ' \
         'clean build install'
  end

  puts :sucess
end


task :auv3_mac_opal => :test_opal do
  FileUtils.cp_r('./src/atomeAuv3/', './tmp/atomeAuv3/')
  FileUtils.cp_r('./tmp/test/src/', './tmp/atomeAuv3/')
  FileUtils.cp_r('./tmp/atomeAuv3/src/index_opal.html', './tmp/atomeAuv3/src/index.html')

  Dir.chdir('./tmp/atomeAuv3') do
    sh 'xcodebuild -project atome.xcodeproj -scheme atomeauv3 -destination "generic/platform=macOS,variant=Mac Catalyst" clean build install'
  end
  system("open ~/Library/Developer/Xcode/DerivedData/")
  puts :success
end

# task :auv3_mac_opal => :test_opal do
#   FileUtils.cp_r('./src/atomeAuv3/', './tmp/atomeAuv3/')
#   FileUtils.cp_r('./tmp/test/src/', './tmp/atomeAuv3/')
#   FileUtils.cp_r('./tmp/atomeAuv3/src/index_opal.html', './tmp/atomeAuv3/src/index.html')
#
#   Dir.chdir('./tmp/atomeAuv3') do
#     sh 'xcodebuild -project atome.xcodeproj ' \
#          '-scheme atomeauv3 ' \
#          '-destination "generic/platform=macOS,variant=Mac Catalyst" ' \
#          'clean build install'
#   end
#
#   puts :sucess
# end

task :auv3_mac_wasm => :test_wasm do
  # FileUtils.rm_rf('./tmp/atomeAuv3')
  # FileUtils.cp_r('./src/', './tmp/')
  # FileUtils.cp_r('./tmp/test/src/', './tmp/atomeAuv3/')
  # FileUtils.rm_rf('./tmp/atomeAuv3/src/index.html')
  # FileUtils.cp_r('./tmp/atomeAuv3/src/index_wasm.html', './tmp/atomeAuv3/src/index.html')
  #
  # Dir.chdir('./tmp/atomeAuv3') do
  #   sh 'xcodebuild -project atome.xcodeproj ' \
  #        '-scheme atomeauv3 ' \
  #        '-destination "generic/platform=macOS,variant=Mac Catalyst" ' \
  #        'clean build install'
  # end
  # puts :sucess
end

task :cleanup do

  manager = Gem::CommandManager.instance
  cleanup_command = manager['cleanup']

  begin
    cleanup_command.invoke('atome')
  rescue Gem::SystemExitException => e
    puts "Error : #{e.message}"
  end

  begin
    uninstaller = Gem::Uninstaller.new('atome', { executables: true, all: true, force: true })
    uninstaller.uninstall
  rescue Gem::InstallError => e
    puts "Error uninstalling : #{e.message}"
  end

  Dir.chdir('pkg') do
    #  treatment here
  end

end
task :reset_cache do
  FileUtils.rm_rf('./tmp')
  FileUtils.rm_rf('./pkg')
end

def resolve_requires(file_path, root_path, processed_files = Set.new, depth = 0)
  return '' unless File.exist?(file_path)
  return '' if processed_files.include?(file_path) || depth > 10 # check circular dependencies and depth

  content = File.read(file_path)
  processed_files.add(file_path)
  current_dir = File.dirname(File.expand_path(file_path)) # use the absolute pah
  content.gsub!(/^(require|require_relative)\s+['"](.*?)['"]$/) do |match|
    type = $1
    required_file_name = $2
    required_file = if type == 'require_relative'
                      File.join(current_dir, required_file_name + '.rb')
                    else
                      File.join(root_path, required_file_name + '.rb')
                    end
    if File.exist?(required_file)
      resolve_requires(required_file, root_path, processed_files, depth + 1)
    else
      match
    end
  end
  content
end

def generate_resolved_file(source_file_path)
  root_path = File.dirname(File.expand_path(source_file_path))
  resolve_requires(source_file_path, root_path)
end

def wasm_params(source, destination, project_name, wasi_file, host_mode, script_source)
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
end

task :test_wasm do
  project_name = :test
  source = '.'

  host_mode = 'web-wasm'

  file_path = "./tmp/#{project_name}/src/index_wasm.html"

  case RbConfig::CONFIG['host_os']
  when /darwin|mac os/

    cpu_type = RbConfig::CONFIG['host_cpu']
    wasi_file = if cpu_type.include?('arm') || cpu_type.include?('aarch64')
                  # Commande pour Mac ARM
                  'wasi-vfs-osx_arm'
                else
                  # Commande pour Mac Intel x86
                  'wasi-vfs-osx_x86'
                end
    destination = './tmp'
    script_source = './test/application'

    wasm_params(source, destination, project_name, wasi_file, host_mode, script_source)
    system "open", file_path
  when /linux|bsd/
    destination = './tmp'
    script_source = './test/application'
    wasi_file = 'wasi-vfs-unix pack tmp'
    wasm_params(source, destination, project_name, wasi_file, host_mode, script_source)
    system "xdg-open", file_path
  when /mswin|mingw|cygwin/
    destination = '.\\tmp'
    script_source = '.\\test\\application'
    wasi_file = 'wasi-vfs.exe pack'
    wasm_params(source, destination, project_name, wasi_file, host_mode, script_source)
    system "start", file_path
  else
    raise "Système d'exploitation non reconnu"
  end

  puts 'atome wasm is build and running!'
end

task :test_opal do
  # we clean the tmp repertory
  # FileUtils.rm_rf('./tmp/')
  # FileUtils.mkdir_p('./tmp')
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  create_application(source, destination, project_name)
  # the line below is to add addition script to the application folder (useful for test per example)
  add_to_application_folder(script_source, destination, project_name)
  # build opal
  build_opal_library(source, destination, project_name)
  # build parser
  build_opal_parser(source, destination, project_name)
  # build atome kernel
  build_atome_kernel_for_opal(source, destination, project_name)
  # build host_mode
  build_host_mode(destination, project_name, 'web-opal')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  # open the app
  if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    # code to exec for Windows
    # `start \\tmp\\#{project_name}\\src\\index_opal.html`
    `start "" "#{destination}\\#{project_name}\\src\\index_opal.html"`
  elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
    # code to exec for MacOS
    `open #{destination}/#{project_name}/src/index_opal.html`
  else
    # code to exec for Unix/Linux
    `open #{destination}/#{project_name}/src/index_opal.html`
  end

  puts 'atome opal is build and running!'
end

task :test_server_wasm do
  # FileUtils.rm_rf('./tmp/')
  # FileUtils.mkdir_p('./tmp')
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'puma-roda-wasm'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  puts 'atome wasm is build and running!'
  threads = []
  threads << Thread.new do

    sleep 1
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
      # code to exec for Windows
      `start  http://localhost:9292?date=#{timestamp}`
      # `start #{destination}\\#{project_name}\\src\\index_server.html`
    elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
      # code to exec for MacOS
      `open http://localhost:9292?date=#{timestamp}`
    else
      # code to exec for Unix/Linux
      `open http://localhost:9292?date=#{timestamp}`
    end

  end
  build_for_wasm_server(destination, project_name, 9292, :production)

end

task :test_server_opal do
  # FileUtils.rm_rf('./tmp/')
  # FileUtils.mkdir_p('./tmp')
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  create_application(source, destination, project_name)
  # the line below is to add addition script to the application folder (useful for test per example)
  add_to_application_folder(script_source, destination, project_name)
  # build opal
  build_opal_library(source, destination, project_name)
  # build parser
  build_opal_parser(source, destination, project_name)
  # build atome kernel
  build_atome_kernel_for_opal(source, destination, project_name)
  # build host_mode
  build_host_mode(destination, project_name, 'puma-roda-opal')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  # build and open the app
  threads = []
  threads << Thread.new do

    sleep 1
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")

    if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
      # code to exec for Windows
      `start  http://localhost:9292?date=#{timestamp}`

    elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
      # code to exec for MacOS
      `open http://localhost:9292?date=#{timestamp}`
    else
      # code to exec for Unix/Linux
      `open http://localhost:9292?date=#{timestamp}`
    end

  end
  build_for_opal_server(destination, project_name, 9292, :production, true)
end

task :opal_server_rebuild do
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  create_application(source, destination, project_name)
  # the line below is to add addition script to the application folder (useful for test per example)
  add_to_application_folder(script_source, destination, project_name)
  # build opal
  build_opal_library(source, destination, project_name)
  # build parser
  build_opal_parser(source, destination, project_name)
  # build atome kernel
  build_atome_kernel_for_opal(source, destination, project_name)
  # build host_mode
  build_host_mode(destination, project_name, 'puma-roda-opal')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  # build and open the app
  threads = []
  threads << Thread.new do

    sleep 1
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
      # code to exec for Windows
      `start  http://localhost:9292?date=#{timestamp}`
      # `start #{destination}\\#{project_name}\\src\\index_server.html`

    elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
      # code to exec for MacOS
      `open http://localhost:9292?date=#{timestamp}`
    else
      # code to exec for Unix/Linux
      `open http://localhost:9292?date=#{timestamp}`
    end

  end

  # build_for_opal_server(destination, project_name, 9292, :production)
end

task :test_wasm_osx do
  FileUtils.cp('./vendor/assets/src/index_native_wasm_tauri.html', './vendor/assets/src/index.html')
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'tauri-wasm'

  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  destination = './tmp'
  # build and open the app
  build_for_osx(destination, :dev)
  puts 'atome osx is running'
end

task :test_osx do
  FileUtils.cp('./vendor/assets/src/index_native_opal_tauri.html', './vendor/assets/src/index.html')
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'

  create_application(source, destination, project_name)
  # the line below is to add addition script to the application folder (useful for test per example)
  add_to_application_folder(script_source, destination, project_name)
  # build opal
  build_opal_library(source, destination, project_name)
  # build parser
  build_opal_parser(source, destination, project_name)
  # build atome kernel
  build_atome_kernel_for_opal(source, destination, project_name)
  # build host_mode
  build_host_mode(destination, project_name, 'tauri-opal')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  build_for_osx(destination, :dev)
  puts 'atome osx is running'
end
task :test_ios do
  FileUtils.cp('./vendor/assets/src/index_native_opal_tauri.html', './vendor/assets/src/index.html')
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  create_application(source, destination, project_name)
  # the line below is to add addition script to the application folder (useful for test per example)
  add_to_application_folder(script_source, destination, project_name)
  # build opal
  build_opal_library(source, destination, project_name)
  # build parser
  build_opal_parser(source, destination, project_name)
  # build atome kernel
  build_atome_kernel_for_opal(source, destination, project_name)
  # build host_mode
  build_host_mode(destination, project_name, 'web-opal')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  # build and open the app
  build_for_ios(destination, :dev)
  puts 'atome ios is running'
end

task :test_wasm_ios do
  FileUtils.cp('./vendor/assets/src/index_native_wasm_tauri.html', './vendor/assets/src/index.html')
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'tauri-wasm'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  destination = './tmp'
  # build and open the app
  build_for_ios(destination, :dev)
  puts 'atome ios is running'
end

task :build_osx do
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'tauri-wasm'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  destination = './tmp'
  # build and open the app
  build_for_osx(destination, :build)
  puts 'atome osx is running'
end

task :update_osx do
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'tauri-wasm'
  update_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  destination = './tmp'
  puts 'atome osx is updated'
end

task :osx_server do
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  create_application(source, destination, project_name)
  # the line below is to add addition script to the application folder (useful for test per example)
  add_to_application_folder(script_source, destination, project_name)
  # build opal
  build_opal_library(source, destination, project_name)
  # build parser
  build_opal_parser(source, destination, project_name)
  # build atome kernel
  build_atome_kernel_for_opal(source, destination, project_name)
  # build host_mode
  build_host_mode(destination, project_name, 'puma-roda-opal')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  # build and open the app

  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'tauri-opal'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  destination = './tmp'
  threads = []
  threads << Thread.new do
    build_for_opal_server(destination, project_name, 9292, :production)
  end
  build_for_osx(destination)

  puts 'atome osx is running'

end

task :ios_server do
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  create_application(source, destination, project_name)
  # the line below is to add addition script to the application folder (useful for test per example)
  add_to_application_folder(script_source, destination, project_name)
  # build opal
  build_opal_library(source, destination, project_name)
  # build parser
  build_opal_parser(source, destination, project_name)
  # build atome kernel
  build_atome_kernel_for_opal(source, destination, project_name)
  # build host_mode
  build_host_mode(destination, project_name, 'puma-roda-opal')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  # build and open the app

  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'tauri-opal'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  destination = './tmp'
  threads = []
  threads << Thread.new do
    build_for_opal_server(destination, project_name, 9292, :production)
  end
  build_for_ios(destination)

  puts 'atome ios is running'

end

def gem_builder
  # building the gem
  dossier = './pkg'

  # we cleanup pkg folder content
  FileUtils.rm_rf(Dir.glob("#{dossier}/*"))
  `rake build` # run build_app thru ARGV in exe atome
  # installing  the gem
  if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    # code to exec for Windows
    `cd pkg && gem install atome --local`
  elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
    # code to exec for MacOS
    `cd pkg; gem install atome --local`
    # open the app
  else
    # code to exec for Unix/Linux
    `cd pkg; gem install atome --local`
    # open the app
  end
end

task :build_gem do
  gem_builder

  puts 'atome gem built and installed'
end

task :push_gem do

  # building gem
  gem_builder

  # pushing  the gem
  dir_path = './pkg'
  entries = Dir.entries(dir_path)

  gem_files = entries.select { |file| file.end_with?('.gem') }

  sorted_versions = gem_files.map { |file|
    file.scan(/\d+\.\d+\.\d+\.\d+\.\d+/).first
  }.compact.sort_by { |version| Gem::Version.new(version) }

  latest_version = sorted_versions.last
  latest_file = gem_files.find { |file| file.include?(latest_version) }

  if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    # code to exec for Windows
    `cd pkg && gem push #{latest_file}`
  elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
    # code to exec for MacOS
    `cd pkg; gem push #{latest_file}`
    # open the app
  else
    # code to exec for Unix/Linux
    `cd pkg; gem push #{latest_file}`
  end
  puts "#{latest_file} pushed"
end

task :full_test do

  # building the gem
  `rake build` # run build_app thru ARGV in exe atome
  # installing  the gem
  if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    # code to exec for Windows
    `cd pkg && gem install atome --local`
  elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
    # code to exec for MacOS
    `cd pkg; gem install atome --local`
    # open the app
  else
    # code to exec for Unix/Linux
    `cd pkg; gem install atome --local`
    # open the app
  end

  puts 'atome gem built and installed'

  # now building new test app
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  create_application(source, destination, project_name)
  # the line below is to add addition script to the application folder (useful for test per example)
  add_to_application_folder(script_source, destination, project_name)
  # build opal
  build_opal_library(source, destination, project_name)
  # build parser
  build_opal_parser(source, destination, project_name)
  # build atome kernel
  build_atome_kernel_for_opal(source, destination, project_name)
  # build host_mode
  build_host_mode(destination, project_name, 'web-opal')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  # open the app
  if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    # code to exec for Windows
    `start "" "#{destination}\\#{project_name}\\src\\index_opal.html"`
  elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
    # code to exec for MacOS
    `open #{destination}/#{project_name}/src/index_opal.html`
  else
    # code to exec for Unix/Linux
    `open #{destination}/#{project_name}/src/index_opal.html`
  end

  puts 'atome opal is build and running!'

  # now running the app
  if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    # code to exec for Windows
    `cd #{destination} && atome run server`
  elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
    # code to exec for MacOS
    `cd #{destination}; atome run server`
    # open the app
  else
    # code to exec for Unix/Linux
    `cd #{destination}; atome run server`
    # open the app
  end

end


