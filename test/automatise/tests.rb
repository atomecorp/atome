require 'ferrum'
require 'fileutils'
require 'json'
require 'date'

path = Dir.pwd
# FileUtils.mkdir_p(path + "/test/automatise/logs") # Création du dossier logs
# puts path+ "test/automatise/logs"

log_path = path + "/test/automatise/logs/"
FileUtils.mkdir_p(File.dirname(log_path)) unless Dir.exist?(File.dirname(log_path))
timestamp = DateTime.now.strftime('%Y-%m-%d_%H-%M-%S')
error_log_path = log_path + "/error_#{timestamp}.log"
pass_log_path =  log_path + "/pass_#{timestamp}.log"

examples = Dir.glob(path + '/vendor/assets/application/examples/*.rb')

examples.each do |file_path|
  if File.exist?(file_path)
    ruby_code = File.read(file_path)
  else
    puts "Error: the file #{file_path} does not exist."
    next
  end

  browser = Ferrum::Browser.new
  browser.goto("http://localhost:9292")

  escaped_code = ruby_code.gsub('"', '\"').gsub("\n", "\\n")
  js_command = "atomeJsToRuby(\"#{escaped_code}\")"

  errors = []
  browser.on(:console) do |message|
    if message[:type] == 'error'
      errors << message[:text]
    end
    puts "LOG : #{message[:text]}"
  end

  browser.evaluate(js_command)
  browser.evaluate("atomeJsToRuby('box({id: :the_box})')")

  if errors.any?
    puts "Writing error log to #{error_log_path}"
    File.open(error_log_path, 'a') do |file|
      file.puts(errors.join("\n"))
    end
  else
    puts "Writing pass log to #{pass_log_path}"
    File.open(pass_log_path, 'a') do |file|
      file.puts("#{timestamp} - No errors detected in #{file_path}.")
    end
  end

  file_name_without_ext = File.basename(file_path, File.extname(file_path))
  browser.screenshot(path: path + "/test/automatise/logs/#{file_name_without_ext}.png")

  browser.quit
end