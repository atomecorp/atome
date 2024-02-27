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
# class EVe < Atome
class EVe < Atome
  def initialize
    @atomes = {}
  end

  def atome(atome_to_find)
    @atomes[atome_to_find]
  end

  def input_box(params = {}, &bloc)
    height_wanted = 15
    width_wanted = 222
    input_back = Atome.new(
      { renderers: [:html], id: :input_back, type: :shape, attach: :view, apply: [:shape_color],
        left: 120, top: 120,data: '', width: width_wanted, height: height_wanted + height_wanted * 20 / 100, smooth: 6 })

    @atomes[:input_back] = input_back

    Atome.new(
      { renderers: [:html], id: :input_text_color, type: :color, tag: ({ system: true, persistent: true }),
        red: 0.1, green: 0.1, blue: 0.1, alpha: 1 }
    )

    text_input = Atome.new(
      { renderers: [:html], id: :input_text, type: :text, apply: [:input_text_color], component: { size: height_wanted },
        data: :input, left: height_wanted * 20 / 100, top: 0, edit: true, attach: :input_back, height: height_wanted, position: :absolute })

    text_input.touch(true) do
      text_input.component({ selected: { color: 'rgba(0,0,0,0.3)', text: :orange } })
    end

    text_input.keyboard(:down) do |native_event|
      event = Native(native_event)
      if event[:keyCode].to_s == '13'
        # we prevent the input
        event.preventDefault()
      end

    end

    text_input.keyboard(:up) do |native_event|
      input_back.data=text_input.data
    end
    @atomes[:input_text] = text_input

    input_back
  end

end

def input(params = {}, &proc)
  text_color = :white
  text_size = 12
  back_color = :gray
  width = 2000
  in_b = EVe.new()
  in_b.input_box
end

i= input

b=box({top: 0, left: 0, width: 33, height: 33})
b.touch(true) do
  puts "i.data : #{i.data}"
end
i.left(66)
i.color(:white)
i.text.left(55)





