# frozen_string_literal: true
require 'fileutils'
require 'securerandom'
require 'digest/sha2'
require 'bundler/gem_tasks'
load 'exe/atome'

task :cleanup do
  `gem cleanup atome;yes | gem uninstall atome;cd pkg`
end
task :reset_cache do
  `rm  -r -f ./tmp`
  `rm  -r -f ./pkg`
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

task :test_wasm do
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'pure_wasm'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  `open ./tmp/#{project_name}/src/index.html`
  puts 'atome wasm is build and running!'
end

task :test_wasm_osx_x86 do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_x86'
  host_mode = 'pure_wasm'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, script_source, host_mode, script_source)
  `open ./tmp/#{project_name}/src/index.html`
  puts 'atome wasm is build and running!'
end
task :test_wasm_windows do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs.exe pack'
  host_mode = 'pure_wasm'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  `open ./tmp/#{project_name}/src/index.html`
  puts 'atome wasm is build and running!'
end
task :test_wasm_unix do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-unix pack tmp'
  host_mode = 'pure_wasm'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  `open ./tmp/#{project_name}/src/index.html`
  puts 'atome wasm is build and running!'
end

task :test_opal do
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
  `open #{destination}/#{project_name}/src/index_opal.html`
  puts 'atome opal is build and running!'
end

task :test_server do
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
  build_host_mode(destination, project_name, 'puma-roda')
  # build Opal extensions
  build_opal_extensions(source, destination, project_name)
  # build application
  build_opal_application(source, destination, project_name)
  # build and open the app
  threads = []
  threads << Thread.new do
    sleep 1
    `open http://localhost:9292`
  end
  build_for_server(destination, project_name, 9292, :production)
end

task :test_osx do
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'tauri'
  create_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  destination = './tmp'
  # build and open the app
  build_for_osx(destination)
  puts 'atome osx is running'
end

task :update_osx do
  project_name = :test
  source = '.'
  destination = './tmp'
  script_source = './test/application'
  wasi_file = 'wasi-vfs-osx_arm'
  host_mode = 'tauri'
  update_application(source, destination, project_name)
  wasm_common(source, destination, project_name, wasi_file, host_mode, script_source)
  destination = './tmp'
  puts 'atome osx is updated'
end

task :build_gem do
  # building the gem
  `rake build` # run build_app thru ARGV in exe atome
  # installing  the gem
  `cd pkg; gem install atome --local`
  # open the app
  puts 'atome gem built and installed'
end

# task :run_wasm_client_code do
#   app_name = :test
#   dest_path = './tmp/'
#   user_code = './test/application'
#   # user_code = './vendor/assets/application'
#   # user_code = './test/client/delices_de_vezelin'
#   application_location = "#{dest_path}#{app_name}"
#   source_file = "#{user_code}/index.rb"
#   new_file_content = generate_resolved_file(source_file)
#   index_html = File.read('vendor/assets/src/index.html')
#   index_html = index_html.sub('</html>', "<script type='text/ruby' >#{new_file_content}</script>\n</html>")
#   File.write("#{application_location}/src/index.html", index_html)
#   `open #{application_location}/src/index.html`
#   puts 'atome wasm user code executed'
# end
