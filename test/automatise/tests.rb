require 'rake'
require 'ferrum'
require 'fileutils'
require 'json'
require 'date'

path = Dir.pwd
log_path = path + "/test/automatise/logs/"
FileUtils.mkdir_p(log_path) unless Dir.exist?(log_path)

timestamp = DateTime.now.strftime('%Y-%m-%d_%H-%M-%S')
error_log_path = log_path + "/error_#{timestamp}.log"
pass_log_path = log_path + "/pass_#{timestamp}.log"

# Définir la stack des fichiers à traiter
stack = Dir.glob(path + '/vendor/assets/application/examples/*.rb')

# Méthode pour traiter un fichier
def process_file(file_path, error_log_path, pass_log_path, path, timestamp)
  if File.exist?(file_path)
    ruby_code = File.read(file_path)
  else
    puts "Error: the file #{file_path} does not exist."
    return
  end

  browser = Ferrum::Browser.new
  browser.goto("http://localhost:9292")
  file_name_without_ext = File.basename(file_path, File.extname(file_path))

  escaped_code = ruby_code.gsub('"', '\\"').gsub("\n", "\\n")
  js_command = "atomeJsToRuby(\"#{escaped_code}\")"

  errors = []
  browser.on(:console) do |message|
    if message[:type] == 'error'
      errors << message[:text]
    end
    puts "LOG : #{message[:text]}"
  end

  begin
    browser.evaluate(js_command)
  rescue Ferrum::JavaScriptError => e
    errors << "JavaScriptError in #{file_path}: #{e.message}"
    puts "Error encountered during JS evaluation in #{file_path}: #{e.message}"
  end

  browser.evaluate("atomeJsToRuby('box({id: :the_box})')")

  # Click all elements on the page
  browser.css('body *').each do |element|
    begin
      element.click
      puts "Clicked on element: \#{element.node_name}, id: \#{element[:id]}"
    rescue Ferrum::Error, Ferrum::CoordinatesNotFoundError => e
      puts "Failed to click element: \#{element.node_name}, id: \#{element[:id]} - \#{e.message}"
    end
  end

  if errors.any?
    puts "Writing error log to #{error_log_path}"
    File.open(error_log_path, 'a') do |file|
      file.puts("#{timestamp} - Errors detected in #{file_name_without_ext}:")
      file.puts(errors.join("
"))
      file.puts("--- End of errors for #{file_name_without_ext} ---
")

      file.puts("--- End of errors for #{file_name_without_ext} ---
")
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

# Méthode pour traiter les fichiers de la stack avec une pause synchrone
def process_stack(stack, error_log_path, pass_log_path, path, timestamp)
  until stack.empty?
    file_path = stack.shift # Récupère le fichier en haut de la stack
    puts "Processing file: #{file_path}"

    process_file(file_path, error_log_path, pass_log_path, path, timestamp)

    # Pause synchronisée entre chaque fichier
    sleep 3 # Temps d’attente avant de passer au fichier suivant
    puts "Finished waiting for 3 seconds"
  end
end

# Lancer le traitement
process_stack(stack, error_log_path, pass_log_path, path, timestamp)
