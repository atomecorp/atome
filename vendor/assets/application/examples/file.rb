#  frozen_string_literal: true

new({ particle: :import })

class Atome
  def file_for_opal(parent, &bloc)
    JS.eval("fileForOpal('#{parent}', #{bloc})")
  end
end

new({ renderer: :html, method: :import, type: :blob }) do |params|
  if Atome::host == 'web-opal'
    file_for_opal(@id) do |file_content|
      puts "opal ===>#{file_content}"
    end

  else
    # Wasm version
    def create_file_browser(_options = '', &bloc)
      div_element = JS.global[:document].getElementById(@id.to_s)
      input_element = JS.global[:document].createElement("input")
      input_element[:type] = "file"
      input_element[:style][:position] = "absolute"
      input_element[:style][:display] = "none"
      input_element[:style][:width] = "0px"
      input_element[:style][:height] = "0px"

      input_element.addEventListener("change") do |native_event|
        event = Native(native_event)
        file = event[:target][:files][0]
        if file
          puts "file requested: #{file[:name]}"
          file_reader = JS.global[:FileReader].new
          file_reader.addEventListener("load") do |load_event|
            file_content = load_event[:target][:result]
            Atome.file_handler(@id, file_content, bloc)
          end
          file_reader.readAsText(file)
        end
      end

      div_element.addEventListener("mousedown") do |event|
        input_element.click
      end
      div_element.appendChild(input_element)
    end
    create_file_browser(:options) do |file_content|
      puts "wasm ===>#{file_content}"
    end
  end

end

b = box({ drag: true })
b.import(true)









