#  frozen_string_literal: true



new({particle: :controller}) do |msg|
  Atome.controller_sender(msg)
end



button = box({smooth: 6,left: 12,top: 120, color:{red: 0.3, green: 0.3, blue: 0.3}})
button.shadow({
                id: :s1,
                left: 3, top: 3, blur: 9,
                invert: true,
                red: 0, green: 0, blue: 0, alpha: 0.7
              })
button.touch(true) do
  button.controller(:hello)
end


slider=box({ width: 333, height: 25, top: 45, left: 12, smooth: 9,  color:{red: 0.3, green: 0.3, blue: 0.3}})
slider.shadow({
                id: :s2,
                left: 3, top: 3, blur: 9,
                invert: true,
                red: 0, green: 0, blue: 0, alpha: 0.7
              })
cursor= slider.circle({width: 30, height: 30, left: 2, top: 1, color:{red: 0.3, green: 0.3, blue: 0.3}})

cursor.left(0)
cursor.top(0)
cursor.shadow({
                id: :s4,
                left: 1, top: 1, blur: 3,
                option: :natural,
                red: 0, green: 0, blue: 0, alpha: 0.6
              })
label=text({data: 0, top: 69, left: 30, component: { size: 12 }, color: :gray})
cursor.drag({ restrict: {max:{ left: 309, top: 0}} }) do |event|
  puts cursor.left
  value = cursor.left/309*100
  label.data(value)
  cursor.controller({ action: :setModuleParameterValue,  params: { moduleId: 6456549897,parameterId: 9846546, value:  value} })

end


support=box({top: 250, left: 12, width: 300, height: 40, smooth: 9, color:{red: 0.3, green: 0.3, blue: 0.3}, id: :support })

support.shadow({
                id: :s3,
                left: 3, top: 3, blur: 9,
                invert: true,
                red: 0, green: 0, blue: 0, alpha: 0.7
              })
input_element = JS.global[:document].createElement("input")
input_element[:type] = "file"

input_element.addEventListener("change") do |native_event|
  event = Native(native_event)
  file = event[:target][:files][0]
  if file
    puts "file requested: #{file[:name]}"
    support.controller({ action: :loadProject,  params: { path: file[:name]} })
  end
end

view_div = JS.global[:document].querySelector("#support")

view_div.appendChild(input_element)


