require 'rake'
require 'ferrum'
require 'fileutils'
require 'json'
require 'date'
# demo_folder='/vendor/assets/application/examples/'
demo_folder='/vendor/assets/src/medias/utils/examples/tests/'
###### run serve
# Launch the Rake task with spawn and retrieve the PID
pid = spawn("rake test_server")

# Start a thread to monitor execution
task_thread = Thread.new do
  Process.wait(pid) # Wait for the process to finish
end

# Wait 5 seconds before executing the rest of the code
sleep 5
puts 'running tests now ...'

path = Dir.pwd
log_path = path + "/test/automatise/logs/"
FileUtils.mkdir_p(log_path) unless Dir.exist?(log_path)

timestamp = DateTime.now.strftime('%Y-%m-%d_%H-%M-%S')
error_log_path = log_path + "/error_#{timestamp}.log"
pass_log_path = log_path + "/pass_#{timestamp}.log"

# Define the stack of files to process
stack = Dir.glob(path + "#{demo_folder}*.rb").sort

# Method to process a file
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
  add_on=<<STR
    atomeJsToRuby('box({id: :the_box})')
    	(function() {
    	  // Crée une div avec un fond bleu
    	  const blueDiv = document.createElement('div');
    	  blueDiv.style.backgroundColor = 'blue';
    	  blueDiv.style.width = '200px';
    	  blueDiv.style.height = '200px';
    	  blueDiv.style.margin = '10px';

    	  // Attache la div bleue à la div avec l'ID 'view'
    	  const viewContainer = document.getElementById('view');
    	  viewContainer.appendChild(blueDiv);
    	})();
STR

  # puts "*******************************************************************"
  # add_on=add_on.gsub("\\n", ";")
  # puts add_on
  # puts "*******************************************************************"
#   add_on=<<STR
#     \n atomeJsToRuby('box({id: :the_box})')
# STR
  # ruby_code=ruby_code+add_on
  escaped_code = ruby_code.gsub('"', '\\"').gsub("\n", "\\n")

  bloc=<<STR
box({id: :the_box})
box({id: :the_bobox, left: 123, color: :red})
STR
  escaped_code=escaped_code+"\\nbox({id: :the_box})"+"\\nbox({id: :the_bobox, left: 123, color: :red})"
  # escaped_code=escaped_code+bloc
  escaped_code=escaped_code.gsub("\\n", ";")
  puts "###################################################################"
  puts escaped_code
  puts "###################################################################"

  # js_command = "atomeJsToRuby(\"#{escaped_code}\")"
  # js_command = "atomeJsToRuby(\"#{escaped_code}\");document.getElementById('the_box').style.backgroundColor = 'blue';"
  # js_command = sprintf('atomeJsToRuby("%s");document.getElementById("the_box").style.backgroundColor = "blue";', escaped_code)
  #####################

  js_command = <<~JS
    atomeJsToRuby("#{escaped_code}");
(function() {
  // Créer une div avec un fond orange
  const orangeDiv = document.createElement('div');
  orangeDiv.style.backgroundColor = 'orange';
  orangeDiv.style.width = '200px';
  orangeDiv.style.height = '200px';
  orangeDiv.style.margin = '10px';

  // Attacher la div à l'élément avec l'ID 'view'
  const viewContainer = document.getElementById('view');
  if (viewContainer) {
    viewContainer.appendChild(orangeDiv);
  } else {
    console.error("L'élément avec l'ID 'view' est introuvable.");
  }
})();
JS

  errors = []
  console_messages = []
  browser.on(:console) do |message|
    if message[:type] == 'error'
      errors << message[:text]
    end
    puts "LOG : #{message[:text]}"
  end
  #########################
  begin
    browser.evaluate("console.log('hello')")

    ############################
    browser.evaluate(js_command)
    #   browser.evaluate(%q{
    #   atomeJsToRuby('box({id: :the_box})')
    # 	(function() {
    # 	  // Crée une div avec un fond bleu
    # 	  const blueDiv = document.createElement('div');
    # 	  blueDiv.style.backgroundColor = 'blue';
    # 	  blueDiv.style.width = '200px';
    # 	  blueDiv.style.height = '200px';
    # 	  blueDiv.style.margin = '10px';
    #
    # 	  // Attache la div bleue à la div avec l'ID 'view'
    # 	  const viewContainer = document.getElementById('view');
    # 	  viewContainer.appendChild(blueDiv);
    # 	})();
    #
    # })
    ##############################
    browser.evaluate("console.log('kool')")
  rescue Ferrum::JavaScriptError => e
    errors << "JavaScriptError in #{file_path}: #{e.message}"
    puts "Error encountered during JS evaluation in #{file_path}: #{e.message}"
  end



  # browser.evaluate("atomeJsToRuby('box({id: :the_box})')")

  # Click on all elements on the page
  browser.css('body *').each do |element|
    begin
      element.click
      puts "Clicked on element: #{element.tag_name}, id: #{element[:id]}"
    rescue Ferrum::Error, Ferrum::CoordinatesNotFoundError => e
      puts "Failed to click element: #{element.tag_name}, id: #{element[:id]} - #{e.message}"
    end
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

  # Take a screenshot after the 3-second wait
  sleep 3 # Wait before taking the screenshot
  browser.screenshot(path: path + "/test/automatise/logs/#{file_name_without_ext}.png")

  # Write console messages to the respective log
  if errors.any?
    File.open(error_log_path, 'a') do |file|
      file.puts("--- Console log for #{file_name_without_ext} ---")
      file.puts(console_messages.join(""))
      file.puts("--- End of console log for #{file_name_without_ext} ---")
    end
  else
    File.open(pass_log_path, 'a') do |file|
      file.puts("--- Console log for #{file_name_without_ext} ---")
      file.puts(console_messages.join(""))
      file.puts("--- End of console log for #{file_name_without_ext} ---")
    end
  end

  browser.quit
end

# Method to process files in the stack with a synchronized pause
def process_stack(stack, error_log_path, pass_log_path, path, timestamp)
  until stack.empty?
    file_path = stack.shift # Retrieve the file at the top of the stack
    puts "Processing file: #{file_path}"

    process_file(file_path, error_log_path, pass_log_path, path, timestamp)

    puts "Finished waiting for 3 seconds"
  end
end

# Start processing
process_stack(stack, error_log_path, pass_log_path, path, timestamp)


###### kill server

# sleep 35
if task_thread.alive?
  puts "Stopping the Rake task after 10 seconds."

  # Find all processes related to Puma
  puma_processes = `pgrep -f puma`.split("\n").map(&:to_i)

  # Send a TERM signal to all Puma processes
  puma_processes.each do |puma_pid|
    Process.kill("TERM", puma_pid)
  end

  # Wait a few seconds to check if the processes have stopped
  sleep 2

  # Force stop if any processes are still active
  puma_processes.each do |puma_pid|
    if system("ps -p #{puma_pid} > /dev/null")
      puts "Force stopping Puma process #{puma_pid} with KILL."
      Process.kill("KILL", puma_pid)
    end
  end

  task_thread.join # Wait for the thread to finish
end