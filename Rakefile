# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
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


task :test_opal do
  test_common
  # As Ruby Wasm and Opal have different require usage we must create and copy fail into a temp file
  directory_name = "tmp/test_app/temp"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "tmp/test_app/temp/opal"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  `cp ./vendor/source_files/opal/index.html ./vendor/assets/src/index.html`
  `rake build`
  `cd pkg; gem install atome --local`
  `cd tmp/test_app;atome update`
  `cd tmp/test_app;atome refresh`
  `cd tmp/test_app;atome update;atome run browser guard `
  puts 'atome browser is build and running!'
end
def wasm_initialize
  #### IMPORTANT TO REFRESH RUBY WASM TO THE LATEST VERSION, (when ruby_browser get far too large)
  #   delete the tmp dir :
  # and UNCOMMENT the line  below : ('curl -LO ....')
  directory_name = "tmp"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./vendor/assets/src/wasm/"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./vendor/assets/src/wasm/ruby"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)

  `cd tmp;curl -LO https://github.com/ruby/ruby.wasm/releases/latest/download/ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `cd tmp; tar xfz ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `mv tmp/3_2-wasm32-unknown-wasi-full-js/usr/local/bin/ruby tmp/system_ruby_browser.wasm`
  `cp ./vendor/source_files/wasm/index.html ./vendor/assets/src/index.html`
  `rm -f ./vendor/assets/src/wasm/ruby/ruby_browser.wasm`
end

task :test_wasm do
  test_common

  directory_name = "./tmp/test_app/src/wasm/"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./tmp/test_app/src/wasm/ruby"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)

  wasm_initialize

  `cp ./vendor/source_files/wasm/index.html ./tmp/test_app/src/index.html`

  `rm -f ./tmp/test_app/src/wasm/ruby/ruby_browser.wasm`
  # FIXME: we have to emebed wasi-vfs because verison 0.4.0 doesn't work
  cmd = <<STRDELIm
./vendor/source_files/wasm/wasi-vfs pack tmp/system_ruby_browser.wasm 
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

task :test_osx do
  test_common
  `cp ./vendor/source_files/opal/index.html ./vendor/assets/src/index.html`
  `rake build`
  `cd pkg; gem install atome --local`
  `cd tmp/test_app;atome update`
  `cd tmp/test_app;atome refresh`
  `cd tmp/test_app;atome update;atome run osx guard`
  puts 'atome osx is running'
end

task :cleanup do
  `gem cleanup atome;yes | gem uninstall atome;cd pkg`
end

task :test_server do
  test_common
  `cp ./vendor/source_files/opal/index.html ./vendor/assets/src/index.html`
  `gem cleanup atome;yes | gem uninstall atome ;gem build atome.gemspec;cd pkg; gem install atome --local`
  `cd tmp/test_app;atome update;atome run server guard`
end

task :refresh do
  FileUtils.copy_entry('vendor/assets/src/medias/rubies/examples/', 'tmp/test_app/src/medias/rubies/examples/')
  `cd tmp/test_app;atome build`
  puts "refreshed!"
end

task :run_example_server do
  FileUtils.copy_entry('vendor/assets/src/medias/rubies/examples/', 'tmp/test_app/src/medias/rubies/examples/')
  `cd tmp/test_app;atome run server`
end

task default: :test_opal
