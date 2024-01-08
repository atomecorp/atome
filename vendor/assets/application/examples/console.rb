# frozen_string_literal: true

def console(debug)
  if debug
    console=box({id: :console,  width: :auto, height:225, bottom: 0,top: :auto, left: 0,right: 0,depth: 30, color: {alpha: 0, red: 0.1, green: 0.3 , blue:0.3}})
    console_back=console.box({id: :console_back,blur: { value: 10, affect: :back}, overflow: :auto, width: :auto, height: :auto, top: 25, bottom: 0,left: 0,right: 0, depth: 30, color: {alpha: 0.3, red: 1, green: 1 , blue: 1}})
    console_top=console.box({id: :console_top,overflow: :auto, width: :auto, height:25, top: 0, bottom: 0,left: 0,right: 0, depth: 30, color: {alpha: 1, red: 0.3, green: 0.3 , blue: 0.3}})

    console_top.shadow({
                         id: :s1,
                         # affect: [:the_circle],
                         left: 0, top: 3, blur: 9,
                         invert: false,
                         red: 0, green: 0, blue: 0, alpha: 1
                       })
    console.drag(:locked) do |event|
      dy = event[:dy]
      y =  console.to_px(:top)+dy.to_f
      console.top(y)
      console.height(:auto)
      total_height=grab(:view).to_px(:height)
      console_back.height(total_height-console.top)
    end

    console_output=console_back.text({data: '', id: :console_output, component: {size: 12}})

    JS.eval <<~JS
    (function() {
      var oldLog = console.log;
      var consoleDiv = document.getElementById("console_output");
      console.log = function(message) {
        if (consoleDiv) {
          consoleDiv.innerHTML += '<p>' + message + '</p>';
        }
        oldLog.apply(console, arguments);
      };

      // Répétez pour console.error, console.warn, etc. si nécessaire
    }());
  JS

    console_clear=console_top.circle({id: :console_clear, color: :red, top: 3, left: 3, width: 19, height:19})
    console_clear.touch(true) do
      console_output.data("")
    end
    # below reactivate right click menu
    JS.global[:document].addEventListener("contextmenu") do |event|
    end


    # element[:style][:WebkitUserSelect] = 'none'
    # element[:style][:MozUserSelect] = 'none'
  else
    grab(:console_back).delete(true)
    JS.global[:document].addEventListener("contextmenu") do |native_event|
      event = Native(native_event)
      event.preventDefault
    end
  end
end
console(true)