# frozen_string_literal: true

support = box({ top: 250, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 }, id: :support })

support.shadow({
                 id: :s3,
                 left: 3, top: 3, blur: 9,
                 invert: true,
                 red: 0, green: 0, blue: 0, alpha: 0.7
               })

# support.duplicate
support.import(true) do |content|
  puts "add code here, content:  #{content}"
end


def importer(&proc)
  JS.global[:document][:body].addEventListener('dragover') do |native_event|
    event = Native(native_event)
    event.preventDefault()
  end

  JS.global[:document][:body].addEventListener('drop') do |native_event|
    event = Native(native_event)
    event.preventDefault()
    files = event[:dataTransfer][:files]

    if files[:length].to_i > 0
      (0...files[:length].to_i).each do |i|
        file = files[i]
        reader = JS.eval('let a= new FileReader(); return a')
        reader.readAsText(file)
        reader.addEventListener('load') do
          proc.call({ content: reader[:result].to_s, name: file[:name].to_s, type: file[:type].to_s, size: file[:size].to_s })
        end
        reader.addEventListener('error') do
          puts 'Error: ' + file[:name].to_s
        end
      end
    end
  end
end

def exception_import(atome_id, &proc)
  special_div = JS.global[:document].getElementById(atome_id)
  special_div.addEventListener('dragover') do |native_event|
    event = Native(native_event)
    special_div[:style][:backgroundColor] = 'red'
    event.preventDefault()
    event.stopPropagation()
  end

  special_div.addEventListener('dragleave') do |native_event|
    event = Native(native_event)
    special_div[:style][:backgroundColor] = 'yellow'
    event.stopPropagation()
  end

  special_div.addEventListener('drop') do |native_event|
    event = Native(native_event)
    event.preventDefault()
    files = event[:dataTransfer][:files]

    if files[:length].to_i > 0
      (0...files[:length].to_i).each do |i|
        file = files[i]
        reader = JS.eval('let a= new FileReader(); return a')
        reader.readAsText(file)
        reader.addEventListener('load') do
          proc.call({ content: reader[:result].to_s, name: file[:name].to_s, type: file[:type].to_s, size: file[:size].to_s })
        end
        reader.addEventListener('error') do
          puts 'Error: ' + file[:name].to_s
        end
      end
    end
  end

  JS.global[:document][:body].addEventListener('drop') do |native_event|
    event = Native(native_event)
    event.preventDefault()
    puts 'Fichier déposé hors de la zone spéciale'
  end
end



box({ id: :the_boxy })
importer do |val|
  alert "case 21 #{val}"
end
exception_import('the_boxy') do |ev|
  alert "yes !!! exepetion found : #{ev}"
end


# TODO: must test if id exist for expetion ,
# merge the two methods
# exeption method should prevent default method
