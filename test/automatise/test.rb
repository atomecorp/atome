require 'rake'
require 'capybara'
require 'capybara/cuprite'
require 'fileutils'
require 'json'
require 'date'

# Configurer Capybara avec Cuprite
Capybara.default_driver = :cuprite
Capybara.app_host = 'http://localhost:9292'
Capybara.run_server = false

# Configurer Cuprite
Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, headless: true, window_size: [1280, 1024])
end

demo_folder = '/vendor/assets/src/medias/utils/examples/tests/'

# Lancer le serveur via Rake
pid = spawn("rake test_server")
task_thread = Thread.new { Process.wait(pid) }
sleep 5
puts 'running tests now ...'

path = Dir.pwd
log_path = path + "/test/automatise/logs/"
FileUtils.mkdir_p(log_path) unless Dir.exist?(log_path)

timestamp = DateTime.now.strftime('%Y-%m-%d_%H-%M-%S')
error_log_path = log_path + "/error_#{timestamp}.log"
pass_log_path = log_path + "/pass_#{timestamp}.log"

stack = Dir.glob(path + "#{demo_folder}*.rb").sort

# Méthode pour exécuter les tests avec Capybara
def process_file(file_path, error_log_path, pass_log_path, path, timestamp, log_path)
  if File.exist?(file_path)
    ruby_code = File.read(file_path)
  else
    puts "Error: the file #{file_path} does not exist."
    return
  end

  session = Capybara::Session.new(:cuprite)
  session.visit('/')

  file_name_without_ext = File.basename(file_path, File.extname(file_path))

  # Initialiser window.consoleMessages avant d'exécuter le code JS
  session.execute_script('window.consoleMessages = [];')

  # Stocker la fonction console.log d'origine
  session.execute_script('window.originalConsoleLog = console.log;')

  # Redéfinir console.log pour capturer les messages
  session.execute_script('console.log = function(message) { window.consoleMessages.push(message); window.originalConsoleLog.apply(console, arguments); };')

  # Préparer le code JS à exécuter
  escaped_code = ruby_code.gsub('"', '\\"').gsub("\n", "\\n")
  js_command = <<~JS
    atomeJsToRuby("#{escaped_code}");
    (function() {
      console.log('salut');
      const orangeDiv = document.createElement('div');
      orangeDiv.style.backgroundColor = 'orange';
      orangeDiv.style.width = '200px';
      orangeDiv.style.height = '200px';
      orangeDiv.style.margin = '10px';
      const viewContainer = document.getElementById('view');
      viewContainer.appendChild(orangeDiv);
    })();
  JS

  errors = []
  begin
    session.execute_script(js_command)
    session.execute_script("console.log('Test completed')")

    # Gérer les alertes de manière explicite
    if session.has_selector?('.alert')
      session.accept_alert
    end
  rescue Capybara::Cuprite::MouseEventFailed, StandardError => e
    errors << "JavaScriptError in #{file_path}: #{e.message}"
    puts "Error encountered during JS evaluation in #{file_path}: #{e.message}"
  end

  # Récupérer les messages de la console
  console_logs = session.evaluate_script("get_logs()")

  # Vérifier si console_logs est nil
  if console_logs.nil?
    puts "console_logs is nil for #{file_path}"
    console_logs = []
  end

  # Afficher les messages de la console dans la sortie standard de Ruby
  puts "Console logs for #{file_path}, logs : #{console_logs}"
  console_logs.each do |log|
    puts log
  end

  if errors.any?
    puts "Writing error log to #{error_log_path}"
    File.open(error_log_path, 'a') do |file|
      file.puts("#{timestamp} - Errors detected in #{file_name_without_ext}:")
      file.puts(errors.join("\n"))
      file.puts("--- End of errors for #{file_name_without_ext} ---\n")
    end
  else
    puts "Writing pass log to #{pass_log_path}"
    File.open(pass_log_path, 'a') do |file|
      file.puts("#{timestamp} - No errors detected in #{file_path}.")
    end
  end

  # Prendre une capture d'écran
  session.save_screenshot(path + "/test/automatise/logs/#{file_name_without_ext}.png")
  session.quit
end

# Méthode pour traiter la pile de fichiers
def process_stack(stack, error_log_path, pass_log_path, path, timestamp, log_path)
  until stack.empty?
    file_path = stack.shift
    puts "Processing file: #{file_path}"

    process_file(file_path, error_log_path, pass_log_path, path, timestamp, log_path)

    puts "Finished waiting for 3 seconds"
    sleep 3
  end
end

# Lancer le traitement
process_stack(stack, error_log_path, pass_log_path, path, timestamp, log_path)

# Arrêter le serveur
if task_thread.alive?
  puts "Stopping the Rake task after 10 seconds."
  puma_processes = `pgrep -f puma`.split("\n").map(&:to_i)

  puma_processes.each { |puma_pid| Process.kill("TERM", puma_pid) }
  sleep 2
  puma_processes.each do |puma_pid|
    if system("ps -p #{puma_pid} > /dev/null")
      puts "Force stopping Puma process #{puma_pid} with KILL."
      Process.kill("KILL", puma_pid)
    end
  end
  task_thread.join
end

# Version: v9