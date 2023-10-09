# frozen_string_literal: true

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
  return "" unless File.exist?(file_path)
  return "" if processed_files.include?(file_path) || depth > 10 # check circular dependencies and depth

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

def test_common(app_folder)
  directory_name = "./tmp"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./tmp/#{app_folder}"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  `cp -r ./vendor/assets/ ./tmp/#{app_folder}/`
  FileUtils.copy_entry('vendor/assets/src/js/', "tmp/#{app_folder}/src/js/")
  FileUtils.copy_entry('vendor/assets/src/css/', "tmp/#{app_folder}/src/css/")
  FileUtils.copy_entry('vendor/assets/src/medias/', "tmp/#{app_folder}/src/medias/")
  `cp -r ./test/application/ ./tmp/#{app_folder}/application/`
  FileUtils.copy_entry('vendor/assets/src/js/', "tmp/#{app_folder}/src/js/")
  FileUtils.copy_entry('vendor/assets/src/css/', "tmp/#{app_folder}/src/css/")
  FileUtils.copy_entry('vendor/assets/src/medias/', "tmp/#{app_folder}/src/medias/")
end
def wasm_initialize

  directory_name = "tmp"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./vendor/assets/src/wasm/"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./vendor/assets/src/wasm/ruby"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  #### IMPORTANT TO REFRESH RUBY WASM TO THE LATEST VERSION, (when ruby_browser get far too large)
  #  run task : reset_cache or  delete the tmp dir :
  # and UNCOMMENT the line  below : ('curl -LO ....')
  #
  # `cd tmp;curl -LO https://github.com/ruby/ruby.wasm/releases/latest/download/ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `cd tmp; tar xfz ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `mv tmp/3_2-wasm32-unknown-wasi-full-js/usr/local/bin/ruby tmp/system_ruby_browser.wasm`
  `rm -f ./vendor/assets/src/wasm/ruby/ruby_browser.wasm`
end
task :test_opal do
  test_common('test_app')
  # As Ruby Wasm and Opal have different require usage we must create and copy fail into a temp file
  test_temp_dir = "tmp/test_app/temp"
  Dir.mkdir(test_temp_dir) unless Dir.exist?(test_temp_dir)
  test_opal_dir = "tmp/test_app/temp/opal"
  Dir.mkdir(test_opal_dir) unless Dir.exist?(test_opal_dir)

  `cd tmp/test_app;atome update;atome run browser  `
  `open tmp/test_app/src/index_opal.html`
  puts 'atome opal is build and running!'
end
task :test_wasm do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs-osx_arm'
  wasm_location = "./tmp/test_app/src/wasm/"
  dest_wasm_location = "./tmp/test_app/src/wasm/ruby"
  application_location = './tmp/test_app'
  test_common('test_app')
  Dir.mkdir(wasm_location) unless Dir.exist?(wasm_location)
  Dir.mkdir(dest_wasm_location) unless Dir.exist?(dest_wasm_location)
  wasm_initialize
  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/#{wasi_source} pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir utilities::./vendor/assets/src/utilities/ 
--mapdir /::#{application_location}/application/
-o #{application_location}/src/wasm/ruby/ruby_browser.wasm
STRDELIm
  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)
  `open tmp/test_app/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_osx_x86 do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs-osx_x86'
  wasm_location = "./tmp/test_app/src/wasm/"
  dest_wasm_location = "./tmp/test_app/src/wasm/ruby"
  application_location = './tmp/test_app'
  test_common('test_app')
  Dir.mkdir(wasm_location) unless Dir.exist?(wasm_location)
  Dir.mkdir(dest_wasm_location) unless Dir.exist?(dest_wasm_location)
  wasm_initialize
  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/#{wasi_source} pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir utilities::./vendor/assets/src/utilities/ 
--mapdir /::#{application_location}/application/
-o #{application_location}/src/wasm/ruby/ruby_browser.wasm
STRDELIm
  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)
  # `cp ./vendor/assets/src/wasm/ruby/ruby_browser.wasm ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  `open tmp/test_app/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_windows do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs.exe pack'
  wasm_location = "./tmp/test_app/src/wasm/"
  dest_wasm_location = "./tmp/test_app/src/wasm/ruby"
  application_location = './tmp/test_app'
  test_common('test_app')
  Dir.mkdir(wasm_location) unless Dir.exist?(wasm_location)
  Dir.mkdir(dest_wasm_location) unless Dir.exist?(dest_wasm_location)
  wasm_initialize
  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/#{wasi_source} pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir utilities::./vendor/assets/src/utilities/ 
--mapdir /::#{application_location}/application/
-o #{application_location}/src/wasm/ruby/ruby_browser.wasm
STRDELIm
  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)
  # `cp ./vendor/assets/src/wasm/ruby/ruby_browser.wasm ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  `open tmp/test_app/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_unix do
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs-unix pack tmp'
  wasm_location = "./tmp/test_app/src/wasm/"
  dest_wasm_location = "./tmp/test_app/src/wasm/ruby"
  application_location = './tmp/test_app'
  test_common('test_app')
  Dir.mkdir(wasm_location) unless Dir.exist?(wasm_location)
  Dir.mkdir(dest_wasm_location) unless Dir.exist?(dest_wasm_location)
  wasm_initialize
  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/#{wasi_source} pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir utilities::./vendor/assets/src/utilities/ 
--mapdir /::#{application_location}/application/
-o #{application_location}/src/wasm/ruby/ruby_browser.wasm
STRDELIm
  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)
  # `cp ./vendor/assets/src/wasm/ruby/ruby_browser.wasm ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  `open tmp/test_app/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_osx do
  #  TODO: exec : test wasm first
  # wasi Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
  wasi_source = 'wasi-vfs-osx_arm'
  wasm_location = "./tmp/test_app/src/wasm/"
  dest_wasm_location = "./tmp/test_app/src/wasm/ruby"
  application_location = './tmp/test_app'
  test_common('test_app')
  Dir.mkdir(wasm_location) unless Dir.exist?(wasm_location)
  Dir.mkdir(dest_wasm_location) unless Dir.exist?(dest_wasm_location)
  wasm_initialize
  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/#{wasi_source} pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir utilities::./vendor/assets/src/utilities/ 
--mapdir /::#{application_location}/application/
-o #{application_location}/src/wasm/ruby/ruby_browser.wasm
STRDELIm
  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)
  `cd tmp/test_app;atome update;atome run osx`
  puts 'atome osx is running'
end

task :test_server do
  test_common('test_app')
  # As Ruby Wasm and Opal have different require usage we must create and copy fail into a temp file
  test_temp_dir = "tmp/test_app/temp"
  Dir.mkdir(test_temp_dir) unless Dir.exist?(test_temp_dir)
  test_opal_dir = "tmp/test_app/temp/opal"
  Dir.mkdir(test_opal_dir) unless Dir.exist?(test_opal_dir)
  `cd tmp/test_app;atome update;atome run server guard production`
end

task :run_wasm_client_code do
  source_file = "vendor/assets/application/index.rb"
  source_file = "test/application/index.rb"
  new_file_content = generate_resolved_file(source_file)
  index_html = File.read("vendor/assets/src/index.html")
  index_html = index_html.sub('</html>', "<script type='text/ruby' >#{new_file_content}</script>\n</html>")
  File.write('tmp/test_app/src/index.html', index_html)
  `open tmp/test_app/src/index.html`
  puts 'atome wasm user code executed'
end

task :build_gem do
  test_common('production')
  # As Ruby Wasm and Opal have different require usage we must create and copy fail into a temp file
  test_temp_dir = "tmp/production/temp"
  Dir.mkdir(test_temp_dir) unless Dir.exist?(test_temp_dir)
  test_opal_dir = "tmp/production/temp/opal"
  Dir.mkdir(test_opal_dir) unless Dir.exist?(test_opal_dir)
  `cd tmp/production;atome update;atome run browser guard `
  `rake build`
  `cd pkg; gem install atome --local`
  `open tmp/production/src/index_opal.html`
  puts 'atome opal production is build and running!'
end

# task :build_gem do
#   # TODO we may have to use a new temp dir to build app for the gem deployment
#    test_common('test_app')
#   # As Ruby Wasm and Opal have different require usage we must create and copy fail into a temp file
#   test_temp_dir = "tmp/test_app/temp"
#   Dir.mkdir(test_temp_dir) unless Dir.exist?(test_temp_dir)
#   test_opal_dir = "tmp/test_app/temp/opal"
#   Dir.mkdir(test_opal_dir) unless Dir.exist?(test_opal_dir)
#   `rake build`
#   `cd pkg; gem install atome --local`
#   puts 'gem build'
# end




