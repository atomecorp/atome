# frozen_string_literal: true

# uncomment below for a fast example

# text({data:  'hello', left: 250, top: 250  })
# text "host framework: #{Atome::host}"
# text ({top: 99, data:  "engine: #{Universe.engine}" })
# b=box({id: :my_box})
# wait 1 do
#   b.left(369)
#   b.top(368)
#   grab(:my_box).color(:red)
#   grab(:my_box).smooth(6)
# end
# # open the console in your browser ou your native app and should see the text below
# puts "hello world"

# def debug(text)
#   JS.eval("
#     var element = document.createElement('div');
#     element.textContent = '#{text}';
#     element.id = 'debug';
#     element.style.position = 'absolute';
#     element.style.left = '90px';
#     element.style.top = '90px';
#     document.getElementById('view').appendChild(element);
#   ")
# end
#
# # Call the method to display text
# debug('Hello, Ruby WASM!')

###########################

# def debug(text)
#   JS.eval("
#     var element = document.createElement('div');
#     element.textContent = '#{text}';
#     element.id = 'debug';
#     element.style.position = 'absolute';
#     element.style.left = '90px';
#     element.style.top = '90px';
#     element.style.backgroundColor = '#333333'; // Darker background color
#     element.style.color = 'lightgrey';
#     element.style.overflowY = 'scroll';
#     element.style.padding = '10px';
#     element.style.boxSizing = 'border-box';
#     element.style.fontSize = '12px'; // Set font size to 12px
#     document.getElementById('view').appendChild(element);
#
#     // Redirect console messages to the debug div
#     console.log = function(message) {
#       var messageElement = document.createElement('div');
#       messageElement.textContent = message;
#       element.appendChild(messageElement);
#       element.scrollTop = element.scrollHeight;
#     };
#
#     // Create a clear button
#     var clearButton = document.createElement('button');
#     clearButton.textContent = 'C';
#     clearButton.style.position = 'absolute';
#     clearButton.style.top = '10px';
#     clearButton.style.right = '10px';
#     clearButton.style.backgroundColor = 'yellow';
#     clearButton.style.borderRadius = '50%';
#     clearButton.style.border = 'none';
#     clearButton.style.width = '20px';
#     clearButton.style.height = '20px';
#     clearButton.style.cursor = 'pointer';
#     clearButton.style.fontSize = '10px';
#     clearButton.style.padding = '0';
#     clearButton.onclick = function() {
#       element.innerHTML = '';
#     };
#     element.appendChild(clearButton);
#   ")
# end
#
# # Call the debug method to create the debug div and redirect console messages
# debug('Debug Console')
#
# # Test the console redirection
# JS.eval("console.log('This is a test message');")
# JS.eval("console.log('This is a test message');")
# JS.eval("console.log('This is a test message');")
# JS.eval("console.log('This is a test message');")
# JS.eval("console.log('This is a test message');")
#
# wait 2 do
#   JS.eval("console.log('This is a test message');")
# end

############################
# todo : simplify drag event
# todo : undo to finish
# todo : int8 to finish
# todo : I.A. to finish (aXion)
# todo : Automatise  tools creation from particle
# todo : visual coding
# todo :GPT documentation
# # todo :Automatise html index creation
# require "./examples/blur"
# require "./examples/browser"
# require "./examples/help"
# require "./examples/int8"
# require "./examples/list"
# require "./examples/lyrics"
# require "./examples/undo"
# require "./examples/apply"
# require "./examples/aXion_with_key"
# require "./examples/draw"
require "./examples/database_handling"
# require "./examples/drag"
# require "./examples/display_bck"
# require "./examples/chrome&Webkit_messenger"
# require "./scratch"
# require "./examples/above_below_before_after"
# require "./examples/svg_vectoriser"
# require "./examples/svg_img_to_vector"
# require "./examples/vector"
# require "./examples/svg"
# require "./examples/svg"
# require "./examples/select_text"
# require "./examples/vr"

# # TODO: make delete force delete current object for consistency
# puts 'automatise tool creation from APIs'
# puts 'add params when creating apis to add doc and infos'



############



