require 'rake'
require 'capybara'
require 'capybara/cuprite'
require 'fileutils'
require 'json'
require 'date'

# choose test folder below
tests_folder = '/vendor/assets/src/medias/codes/APIs/presets'
# tests_folder = '/vendor/assets/src/medias/codes/APIs/'
# tests_folder = '/vendor/assets/src/medias/codes/unit_tests/'
# tests_folder = '/vendor/assets/application/examples/'

# Start the server via Rake
# choose type of server below
pid = spawn("rake test_server")
# pid = spawn("rake test_server_wasm")

# Configure Capybara with Cuprite
Capybara.default_driver = :cuprite
Capybara.app_host = 'http://localhost:9292'
Capybara.run_server = false

# Configure Cuprite
Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, headless: true, window_size: [1280, 1024])
end

task_thread = Thread.new { Process.wait(pid) }
sleep 7
puts 'Running tests now...'

path = Dir.pwd
log_path = path + "/test/automated/logs/"
FileUtils.mkdir_p(log_path) unless Dir.exist?(log_path)

timestamp = DateTime.now.strftime('%Y-%m-%d_%H-%M-%S')
error_log_path = log_path + "/error_#{timestamp}.log"
pass_log_path = log_path + "/pass_#{timestamp}.log"

stack = Dir.glob(File.join(path, "#{tests_folder}/**/*.rb")).sort

# Method to execute tests with Capybara
def process_file(file_path, error_log_path, pass_log_path, path, timestamp)
  if File.exist?(file_path)
    ruby_code = File.read(file_path)
  else
    puts "Error: The file #{file_path} does not exist."
    return
  end

  session = Capybara::Session.new(:cuprite)
  session.visit('/')

  file_name_without_ext = File.basename(file_path, File.extname(file_path))

  # Prepare JS code to execute
  escaped_code = ruby_code.gsub('"', '\\"').gsub("\n", "\\n")

  # below is the code to be evaluated
  js_command = <<~JS
      // Clear temporary logs
      tempLogs.length = 0;
    // remove any object inside intuition
      atomeJsToRuby("grab(:toolbox_tool).delete({ force: true })");
    //execute current test
      atomeJsToRuby("#{escaped_code}");
      // Scroll and apply color change to visible elements
      function processVisibleElements(selector) {
        var elements = document.querySelectorAll(selector);
        elements.forEach(function(el) {
          var rect = el.getBoundingClientRect();
          if (rect.width > 0 && rect.height > 0) {
            el.scrollIntoView({ behavior: 'smooth', block: 'center' });
               id_f= ':'+el.id
    console.log('-------------------')
    console.log(id_f)
    console.log('-------------------')
    atomeJsToRuby("reenact(" + id_f + ",:touch)");
            console.log('Processed element with ID:', el.id);
          }
        });
      }

      // Process elements inside objects and iframes
      var objects = document.querySelectorAll('object, iframe');
      objects.forEach(function(obj) {
        var doc = obj.contentDocument || obj.contentWindow.document;
        if (doc) {
          processVisibleElements.call(doc, '[id]');
        }
      });

      // Process elements inside the main document
      processVisibleElements('body [id]');

      // Disable pointer events on potential blockers
      document.querySelectorAll('[style*="filter"], [style*="opacity"]').forEach(function(el) {
        el.style.pointerEvents = 'none';
      });
      
  JS

  errors = []
  begin
    session.execute_script(js_command)
    session.execute_script("console.log('Test completed')")

    # Handle alerts explicitly
    if session.has_selector?('.alert')
      session.accept_alert
    end
  rescue Capybara::Cuprite::MouseEventFailed, StandardError => e
    errors << "JavaScriptError in #{file_path}: #{e.message}"
    puts "Error encountered during JS evaluation in #{file_path}: #{e.message}"
  end

  # Retrieve console messages
  console_logs = session.evaluate_script("get_logs()") || []

  if errors.any?
    File.open(error_log_path, 'a') do |file|
      file.puts("#{timestamp} - Errors detected in #{file_name_without_ext}:")
      file.puts(errors.join("\n"))
      file.puts("Console logs:")
      file.puts(console_logs.join("\n"))
      file.puts("--- End of errors for #{file_name_without_ext} ---\n")
    end
  else
    File.open(pass_log_path, 'a') do |file|
      file.puts("#{timestamp} - No errors detected in #{file_path}.")
      file.puts("Console logs:")
      file.puts(console_logs.join("\n"))
      file.puts("--- End of logs for #{file_name_without_ext} ---\n")
    end
  end

  # Take a screenshot
  # Take a screenshot with prefixed path from hierarchy
  relative_path = file_path.sub(path, '').split('/').last(3).join('_').sub('.rb', '')
  session.save_screenshot(path + "/test/automated/logs/#{relative_path}.png")
  session.quit
end

# Method to process the file stack
def process_stack(stack, error_log_path, pass_log_path, path, timestamp)
  until stack.empty?
    file_path = stack.shift
    puts "Processing file: #{file_path}"

    process_file(file_path, error_log_path, pass_log_path, path, timestamp)

    puts "Finished, waiting for 3 seconds."
    sleep 3
  end
end

# Start processing
process_stack(stack, error_log_path, pass_log_path, path, timestamp)

# Stop the server
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

# Version 1.1