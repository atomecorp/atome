# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

task default: :test

task :test_build do
  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')

  `rake build`
  `cd pkg; gem install atome --local`
  `cd test/test_app;atome update`
  `cd test/test_app;atome refresh`
  puts 'solution re-build!'

end

task :test_browser do
  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
  `cd test/test_app;atome update;atome run compile`
  `open test/test_app/src/index.html`
  puts 'atome browser is running'
end

def test_common
  directory_name = "./test/test_app"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  `cp -r ./vendor/assets/ ./test/test_app/`
  `cp -r ./test/application/ ./test/test_app`
  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
  `cp -r ./test/application/ ./test/test_app/application/`

  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
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

task :test_build_opal do
  test_common

  `cp ./vendor/source_files/opal/index.html ./vendor/assets/src/index.html`
  `rake build`
  `cd pkg; gem install atome --local`
  `cd test/test_app;atome update`
  `cd test/test_app;atome refresh`
  `cd test/test_app;atome update;atome run browser guard `
  puts 'atome browser is build and running!'
end

task :test_build_wasm do
  test_common

  directory_name = "./test/test_app/src/wasm/"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
  directory_name = "./test/test_app/src/wasm/ruby"
  Dir.mkdir(directory_name) unless Dir.exist?(directory_name)

  wasm_initialize

  `cp ./vendor/source_files/wasm/index.html ./test/test_app/src/index.html`

  `rm -f ./test/test_app/src/wasm/ruby/ruby_browser.wasm`

  cmd = <<STRDELIm
wasi-vfs pack tmp/system_ruby_browser.wasm 
--mapdir usr::./tmp/3_2-wasm32-unknown-wasi-full-js/usr 
--mapdir lib::./lib/ 
--mapdir /::./test/test_app/application/ 
-o vendor/assets/src/wasm/ruby/ruby_browser.wasm
STRDELIm

  cleaned_cmd = cmd.lines.reject { |line| line.start_with?("#") }.join
  command = cleaned_cmd.chomp.gsub("\n", "")
  system(command)

  `cp ./vendor/assets/src/wasm/ruby/ruby_browser.wasm ./test/test_app/src/wasm/ruby/ruby_browser.wasm`

  `open test/test_app/src/index.html`
  puts 'atome wasm is build and running'
end

task :test_build_osx do
  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')

  `rake build`
  `cd pkg; gem install atome --local`
  `cd test/test_app;atome update`
  `cd test/test_app;atome refresh`
  `cd test/test_app;atome update;atome run osx guard`
  # `cd test/test_app;atome run osx guard`
  puts 'atome osx is running'
end

task :cleanup do
  `gem cleanup atome;yes | gem uninstall atome;cd pkg`
end

task :test_server do
  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
  `gem cleanup atome;yes | gem uninstall atome ;gem build atome.gemspec;cd pkg; gem install atome --local`
  `cd test/test_app;atome update;atome run server guard`
end

task :refresh do
  FileUtils.copy_entry('vendor/assets/src/medias/rubies/examples/', 'test/test_app/src/medias/rubies/examples/')
  `cd test/test_app;atome build`
  puts "refreshed!"
end

task :run_example_server do
  FileUtils.copy_entry('vendor/assets/src/medias/rubies/examples/', 'test/test_app/src/medias/rubies/examples/')
  `cd test/test_app;atome run server`
end

task :test_osx do
  `cd test/test_app;atome run osx guard`
end

task default: :test
