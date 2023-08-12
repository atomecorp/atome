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


task :test_build_browser do

  # def require_sanitizer(file)
  #   file= file.gsub('  ',' ')
  #   file= file.gsub(' require','require')
  #   file.gsub(/^require (['"])(?!\.\/)/, 'require \1./')
  # end
  # `cp -r ./application_tests/application ./test/test_app`
  # ############@
  # source_path = './application_tests/application/index.rb'
  #
  # File.open(source_path, 'r') do |file|
  #   content = file.read
  #   content=require_sanitizer(content)
  #   dest_path = './test/test_app/application/index.rb'
  #   File.write(dest_path, content)
  # end
  # #################
  # source_path = './application_tests/application/index.rb'
  # file_content = File.read(source_path)
  # new_content = file_content.gsub(/(require\s+['"])\.\//, '\1')
  # dest_path = './test/test_app/application/index.rb'
  # File.write(dest_path, new_content)
  # `cp -r ./application_tests/application ./test/test_app`
  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
  `cp ./vendor/source_files/opal/index.html ./vendor/assets/src/index.html`
  `rake build`
  `cd pkg; gem install atome --local`
  `cd test/test_app;atome update`
  `cd test/test_app;atome refresh`
  `cd test/test_app;atome update;atome run browser guard `
  puts 'atome browser is build and running!'
end

task :test_build_wasm do
  #### IMPORTANT TO REFRESH RUBY WASM TO THE LATEST VERSION,  delete:
  # - ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz,
  # - system_ruby_browser.wasm
  # - 3_2-wasm32-unknown-wasi-full-js
  # and finally UNCOMMENT the lines  below

  # `curl -LO https://github.com/ruby/ruby.wasm/releases/latest/download/ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `tar xfz ruby-3_2-wasm32-unknown-wasi-full-js.tar.gz`
  `mv 3_2-wasm32-unknown-wasi-full-js/usr/local/bin/ruby system_ruby_browser.wasm`

  FileUtils.copy_entry('vendor/assets/src/js/', 'test/test_app/src/js/')
  FileUtils.copy_entry('vendor/assets/src/css/', 'test/test_app/src/css/')
  FileUtils.copy_entry('vendor/assets/src/medias/', 'test/test_app/src/medias/')
  `cp ./vendor/source_files/wasm/index.html ./vendor/assets/src/index.html`
  `cp ./vendor/source_files/wasm/index.html ./test/test_app/src/index.html`
  `rm -f ./vendor/assets/src/wasm/ruby/ruby_browser.wasm`
  `rm -f ./test/test_app/src/wasm/ruby/ruby_browser.wasm`

  cmd=<<STRDELIm
wasi-vfs pack system_ruby_browser.wasm 
--mapdir usr::./3_2-wasm32-unknown-wasi-full-js/usr 
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


# task :run_server do
#   `cd test/test_app;atome run server guard`
# end

task :refresh do
  FileUtils.copy_entry('vendor/assets/src/medias/rubies/examples/', 'test/test_app/src/medias/rubies/examples/')
  `cd test/test_app;atome build`
  puts "refreshed!"
end

# task :open_server do
# `open http://127.0.0.1:1430/`
# end

task :run_example_server do
  FileUtils.copy_entry('vendor/assets/src/medias/rubies/examples/', 'test/test_app/src/medias/rubies/examples/')
  `cd test/test_app;atome run server`
end


# task :taurification do
#   `cd test/test_app;cargo tauri dev`
# end

task :test_osx do
  `cd test/test_app;atome run osx guard`
end


task default: :test
