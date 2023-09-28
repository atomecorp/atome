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
def test_common

  directory_name = "./tmp"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./tmp/test_app"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  `cp -r ./vendor/assets/ ./tmp/test_app/`

  FileUtils.copy_entry('vendor/assets/src/js/', 'tmp/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'tmp/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'tmp/test_app/src/medias/')
  `cp -r ./test/application/ ./tmp/test_app/application/`
  FileUtils.copy_entry('vendor/assets/src/js/', 'tmp/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'tmp/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'tmp/test_app/src/medias/')
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
  `cd tmp;curl -LO https://github.com/ruby/ruby.wasm/releases/latest/download/ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `cd tmp; tar xfz ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `mv tmp/3_2-wasm32-unknown-wasi-full-js/usr/local/bin/ruby tmp/system_ruby_browser.wasm`
  `rm -f ./vendor/assets/src/wasm/ruby/ruby_browser.wasm`
end

task :test_opal do
  test_common
  # As Ruby Wasm and Opal have different require usage we must create and copy fail into a temp file
  directory_name = "tmp/test_app/temp"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "tmp/test_app/temp/opal"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  `rake build`
  `cd pkg; gem install atome --local`
  `cd tmp/test_app;atome update`
  `cd tmp/test_app;atome update;atome run browser guard `
  `open tmp/test_app/src/index_opal.html`
  puts 'atome browser is build and running!'
end
# FIXME: we have to embed wasi-vfs because version 0.4.0 doesn't work
# TODO: Source here : https://github.com/kateinoigakukun/wasi-vfs/releases
task :test_wasm do
  test_common

  directory_name = "./tmp/test_app/src/wasm/"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./tmp/test_app/src/wasm/ruby"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  wasm_initialize
  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/wasi-vfs-osx_arm pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir /::./tmp/test_app/application/ 
-o vendor/assets/src/wasm/ruby/ruby_browser.wasm
STRDELIm
  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)
  `cp ./vendor/assets/src/wasm/ruby/ruby_browser.wasm ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  `open tmp/test_app/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_osx_x86 do
  test_common

  directory_name = "./tmp/test_app/src/wasm/"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./tmp/test_app/src/wasm/ruby"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)

  wasm_initialize

  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/wasi-vfs-osx_x86 pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir /::./tmp/test_app/application/ 
-o vendor/assets/src/wasm/ruby/ruby_browser.wasm
STRDELIm

  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)

  `cp ./vendor/assets/src/wasm/ruby/ruby_browser.wasm ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`

  `open tmp/test_app/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_windows do
  test_common

  directory_name = "./tmp/test_app/src/wasm/"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./tmp/test_app/src/wasm/ruby"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)

  wasm_initialize

  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/wasi-vfs.exe pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir /::./tmp/test_app/application/ 
-o vendor/assets/src/wasm/ruby/ruby_browser.wasm
STRDELIm

  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)

  `cp ./vendor/assets/src/wasm/ruby/ruby_browser.wasm ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`

  `open tmp/test_app/src/index.html`
  puts 'atome wasm is build and running'
end
task :test_wasm_unix do
  test_common

  directory_name = "./tmp/test_app/src/wasm/"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./tmp/test_app/src/wasm/ruby"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)

  wasm_initialize

  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  cmd = <<STRDELIm
./vendor/source_files/wasm/wasi-vfs-unix pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir /::./tmp/test_app/application/ 
-o vendor/assets/src/wasm/ruby/ruby_browser.wasm
STRDELIm

  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", " ")
  system(command)

  `cp ./vendor/assets/src/wasm/ruby/ruby_browser.wasm ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`

  puts 'atome wasm is build and running'
end
task :test_osx do
  test_common
  `rake build`
  `cd pkg; gem install atome --local`
  `cd tmp/test_app;atome update;atome run osx`
  puts 'atome osx is running'
end
task :test_server do
  test_common
  `gem cleanup atome;yes | gem uninstall atome ;gem build atome.gemspec;cd pkg; gem install atome --local`
  `cd tmp/test_app;atome update;atome run server guard`
end

task default: :test_opal

