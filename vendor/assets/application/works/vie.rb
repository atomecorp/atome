# frozen_string_literal: true

# def atome_common(atome_preset, params)
#   basic_params = { renderers: [] }
#   # TODO : remove Essentials.default_params[atome_preset] || {} as it is
#   # applied twice because preset is now a particle
#   preset_params = Essentials.default_params[atome_preset] || {}
#
#   basic_params[:type] = preset_params[:type] || :element
#   basic_params[:id] = params[:id] || identity_generator(atome_preset)
#   basic_params[:renderers] = @renderers || preset_params[:renderers]
#   essential_params = basic_params.merge(preset_params)
#   reordered_params = essential_params.reject { |key, _| params.has_key?(key) }
#   params = reordered_params.merge(params)
#
#   # condition to handle color/shadow/paint atomes that shouldn't be attach to view
#   # TODO : add category for atome( material/physical vs modifier : color, shadow, .. vs shape, image ..)
#   # then add condition same things fo code in genesis new_atome
#   if %i[color shadow paint].include?(atome_preset)
#     unless params[:affect]
#       params[:affect] = if @id == :view
#                           [:black_matter]
#                         else
#                           [@id]
#                         end
#     end
#   else
#     params[:attach] = params[:attach] || @id || :view
#   end
#   params
# end
#
# def preset_common(params, &bloc)
#   # if an atome with current id exist we update the ID in the params
#   params[:id] = "#{params[:id]}_#{Universe.atomes.length}" if grab(params[:id])
#   Atome.new(params, &bloc)
# end
class EVe
  def initialize
    @atomes = {}

  end

  def atome(atome_to_find)
    @atomes[atome_to_find]
  end

  def input_box(params = {}, &bloc)
    # atome_preset = :box
    # params = atome_common(atome_preset, params)
    # preset_common(params, &bloc)
    height_wanted= 15
    width_wanted= 222
    input_back = Atome.new(
      { renderers: [:html], id: :input_back, type: :shape, attach: :view, apply: [:shape_color],
        left: 120, top: 120, width: width_wanted, height: height_wanted+height_wanted*20/100, smooth: 6})

    @atomes[:input_back] = input_back

    Atome.new(
      { renderers:  [:html], id: :input_text_color, type: :color, tag: ({ system: true, persistent: true }),
        red: 0.1, green: 0.1, blue: 0.1, alpha: 1 }
    )

    text_input = Atome.new(
      { renderers: [:html], id: :input_text, type: :text, apply: [:input_text_color],component:{size: height_wanted},
        data: :input, left: height_wanted*20/100, top: 0,  edit: true, attach: :input_back , height: height_wanted, position: :absolute})

    text_input.touch(true) do
      puts text_input.data
      text_input.component({ selected: {color: 'rgba(0,0,0,0.3)', text: :orange} })
    end
    @atomes[:input_text] = text_input

    input_back
  end

end

def input_box(params = {}, &proc)
  text_color=:white
  text_size= 12
  back_color= :gray
  width= 2000
  in_b = EVe.new()
  in_b.input_box


  # grab(:view).input_box(params, &proc)
end


#######





new({particle: :controller}) do |msg|
  Atome.controller_sender(msg)
end

button = box({smooth: 6,left: 12,top: 120, color:{red: 0.3, green: 0.3, blue: 0.3},id: :my_box})
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

# new({ particle: :import })

support=box({top: 250, left: 12, width: 300, height: 40, smooth: 9, color:{red: 0.3, green: 0.3, blue: 0.3}, id: :support })

support.shadow({
                 id: :s3,
                 left: 3, top: 3, blur: 9,
                 invert: true,
                 red: 0, green: 0, blue: 0, alpha: 0.7
               })

# support.duplicate
support.import(true) do  |content|
  puts "add code here, content:  #{content}"
end


# input_element = JS.global[:document].createElement("input")
# input_element[:type] = "file"
#
# input_element.addEventListener("change") do |native_event|
#   event = Native(native_event)
#   file = event[:target][:files][0]
#   if file
#     puts "file requested: #{file[:name]}"
#     support.controller({ action: :loadProject,  params: { path: file[:name]} })
#   end
# end
#
# view_div = JS.global[:document].querySelector("#support")
#
# view_div.appendChild(input_element)

def fill_toolzone(tools_ids)

end

fill_toolzone(%i[files edition select group link copy undo settings])
# clear play paste mix


in_box=input_box














