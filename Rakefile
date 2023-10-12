# frozen_string_literal: true
require 'fileutils'
require 'securerandom'
require 'digest/sha2'
require 'bundler/gem_tasks'
require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end
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
    required_file = if type == "require_relative"
                      File.join(current_dir, required_file_name + ".rb")
                    else
                      File.join(root_path, required_file_name + ".rb")
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

def build_aui(path)
  uuid = SecureRandom.uuid
  sha = Digest::SHA256.hexdigest(uuid)
  coded_id = sha.gsub('-', '_')
  aui_file = <<~STR
    class Atome
      def self.aui
        "#{coded_id}"
      end
    end
  STR
  File.new(path, "w")
  File.open(path, 'w') do |f|
    f.puts aui_file
  end
end

def build_host_type(path, host_mode)
  host_type = <<~STR
    class Atome
      def self.host
        "#{host_mode}"
      end
    end
  STR
  File.new(path, "w")
  File.open(path, 'w') do |f|
    f.puts host_type
  end
end

def build_common(application_location, host_type, user_code)
  user_code ||= './vendor/assets/application'
  FileUtils.mkdir_p(application_location) unless Dir.exist?(application_location)
  `cp -r ./vendor/assets/ #{application_location}/`
  build_aui("#{application_location}/src/utilities/aui.rb")
  build_host_type("#{application_location}/src/utilities/mode.rb", host_type)
  `cp -r #{user_code} #{application_location}`
end

def wasm_initialize(path, app_name, wasi_source)
  application_location = "#{path}#{app_name}"
  wasm_location = "#{application_location}/src/wasm/"
  Dir.mkdir(wasm_location) unless Dir.exist?(wasm_location)
  Dir.mkdir(application_location) unless Dir.exist?(application_location)
  wasm_temp_folder = "#{application_location}/tmp"
  Dir.mkdir(wasm_temp_folder) unless Dir.exist?(wasm_temp_folder)
  #### IMPORTANT TO REFRESH RUBY WASM TO THE LATEST VERSION, (when ruby_browser get far too large)
  #  run task : reset_cache or  delete the tmp dir :
  # and UNCOMMENT the line  below : ('curl -LO ....')
  # `cd #{wasm_temp_folder};curl -LO https://github.com/ruby/ruby.wasm/releases/latest/download/ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `cd #{wasm_temp_folder}; tar xfz ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `mv #{wasm_temp_folder}/3_2-wasm32-unknown-wasi-full-js/usr/local/bin/ruby #{wasm_temp_folder}/system_ruby_browser.wasm`
  `rm -f #{application_location}/src/wasm/ruby_browser.wasm`
  cmd = <<~STRDELIM
    ./vendor/source_files/wasm/#{wasi_source} pack #{wasm_temp_folder}/system_ruby_browser.wasm
    --mapdir usr::#{wasm_temp_folder}/3_2-wasm32-unknown-wasi-full-js/usr
    --mapdir lib::./lib/
    --mapdir /::#{application_location}/application/
    --mapdir utilities::#{application_location}/src/utilities/
    -o #{application_location}/src/wasm/ruby_browser.wasm
  STRDELIM
  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)
end

task :test_opal do
  app_name = :test
  dest_path = './tmp/'
  user_code = './test/application'
  application_location = "#{dest_path}#{app_name}"
  build_common(application_location, :server, user_code)
  # As Ruby Wasm and Opal have different require usage we must create and copy files into a temp folder
  # test_temp_dir = "tmp/test_app/temp"
  # Dir.mkdir(test_temp_dir) unless Dir.exist?(test_temp_dir)
  # test_opal_dir = "tmp/test_app/temp/opal"
  # Dir.mkdir(test_opal_dir) unless Dir.exist?(test_opal_dir)

  `cd #{application_location} ;atome update;atome run browser`
  `open #{application_location}/src/index_opal.html`
  puts 'atome opal is build and running!'
end

task :test_wasm do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs-osx_arm'
  app_name = :test
  dest_path = './tmp/'
  user_code = './test/application'
  application_location = "#{dest_path}#{app_name}"
  build_common(application_location, :wasm, user_code)
  wasm_initialize(dest_path, app_name, wasi_source)
  `open #{application_location}/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_osx_x86 do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs-osx_x86'
  app_name = :test
  dest_path = './tmp/'
  user_code = './test/application'
  application_location = "#{dest_path}#{app_name}"
  build_common(application_location, :wasm, user_code)
  wasm_initialize(dest_path, app_name, wasi_source)
  `open #{application_location}/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_windows do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs.exe pack'
  app_name = :test
  dest_path = './tmp/'
  user_code = './test/application'
  application_location = "#{dest_path}#{app_name}"
  build_common(application_location, :wasm, user_code)
  wasm_initialize(dest_path, app_name, wasi_source)
  `open #{application_location}/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_unix do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs-unix pack tmp'
  app_name = :test
  dest_path = './tmp/'
  user_code = './test/application'
  application_location = "#{dest_path}#{app_name}"
  build_common(application_location, :wasm, user_code)
  wasm_initialize(dest_path, app_name, wasi_source)
  `open #{application_location}/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_osx do
  #  TODO: exec : test wasm first
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs-osx_arm'
  app_name = :test
  dest_path = './tmp/'
  user_code = './test/application'
  application_location = "#{dest_path}#{app_name}"
  build_common(application_location, :osx, user_code)
  wasm_initialize(dest_path, app_name, wasi_source)
  `cd #{application_location};atome update;atome run osx`
  puts 'atome osx is running'
end

task :test_server do
  app_name = :test
  dest_path = './tmp/'
  user_code = './test/application'
  application_location = "#{dest_path}#{app_name}"
  build_common(application_location, :server, user_code)
  # As Ruby Wasm and Opal have different require usage we must create and copy fail into a temp file
  # test_temp_dir = "tmp/test_app/temp"
  # Dir.mkdir(test_temp_dir) unless Dir.exist?(test_temp_dir)
  # test_opal_dir = "tmp/test_app/temp/opal"
  # Dir.mkdir(test_opal_dir) unless Dir.exist?(test_opal_dir)
  `cd #{application_location};atome update;atome run server guard production`
  # `cd #{application_location};atome update;atome run server guard production`

end

# task :run_wasm_client_code do
#   source_file = "vendor/assets/application/index.rb"
#   # source_file = "test/application/index.rb"
#   source_file = "test/client/delices_de_vezelin/index.rb"
#   new_file_content = generate_resolved_file(source_file)
#   index_html = File.read("vendor/assets/src/index.html")
#   index_html = index_html.sub('</html>', "<script type='text/ruby' >#{new_file_content}</script>\n</html>")
#   File.write('tmp/test_app/src/index.html', index_html)
#   `open tmp/test_app/src/index.html`
#   puts 'atome wasm user code executed'
# end

# task :build_gem do
#   build_common('production', :universal)
#
#   # As Ruby Wasm and Opal have different require usage we must create and copy fail into a temp file
#   test_temp_dir = "tmp/production/temp"
#   Dir.mkdir(test_temp_dir) unless Dir.exist?(test_temp_dir)
#   test_opal_dir = "tmp/production/temp/opal"
#   Dir.mkdir(test_opal_dir) unless Dir.exist?(test_opal_dir)
#   `cd tmp/production;atome update`
#   `rake build`
#   `cd pkg; gem install atome --local`
#   `open tmp/production/src/index.html`
#
#   puts 'atome opal production is build'
# end






