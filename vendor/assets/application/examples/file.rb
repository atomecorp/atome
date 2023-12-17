#  frozen_string_literal: true

new({ particle: :import })
class Atome
  def file_for_opal(parent, &bloc)
    JS.eval("fileForOpal('#{parent}', #{bloc})")
  end
end
new({ renderer: :html, method: :import, type: :blob }) do |params|
  if Atome::host == 'web-opal'
    file_for_opal(:view) do |file_content|
      puts "opal ===>#{file_content}"
    end

  else
    # Wasm version
    def create_file_browser(parent, &bloc)
      div_element = JS.global[:document].createElement("div")
      div_element[:style][:width] = "33px"
      div_element[:style][:height] = "33px"
      div_element[:style][:backgroundColor] = "rgba(255,0,0,0.3)"
      div_element[:style][:position] = "absolute"
      div_element[:style][:top] = "0px"
      div_element[:style][:left] = "0px"
      # div_element=JS.global[:document].getElementById(parent.to_s)
      # alert div_element2.class

      input_element = JS.global[:document].createElement("input")
      input_element[:type] = "file"
      input_element[:style][:position] = "absolute"
      # input_element[:style][:display] = "none"
      # input_element[:style][:width] = "0px"
      # input_element[:style][:height] = "0px"

      input_element.addEventListener("change") do |native_event|
        event = Native(native_event)
        file = event[:target][:files][0]
        if file
          puts "file requested: #{file[:name]}"
          file_reader = JS.global[:FileReader].new
          file_reader.addEventListener("load") do |load_event|
            file_content = load_event[:target][:result]
            Atome.file_handler(parent, file_content, bloc)
          end
          file_reader.readAsText(file)
        end
      end

      div_element.addEventListener("mousedown") do |event|
        input_element.click
      end
      view_div = JS.global[:document].querySelector("##{parent}")
      view_div.appendChild(input_element)
      view_div.appendChild(div_element)
    end

    create_file_browser(:view) do |file_content|
      puts "wasm ===>#{file_content}"
    end
  end

end

b = box({drag: true})
b.import(true)









