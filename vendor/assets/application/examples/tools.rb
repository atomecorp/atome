# frozen_string_literal: true


new({ tool: :blur }) do |params|

  active_code = lambda {
    puts :alteration_tool_code_activated
  }

  inactive_code = lambda { |param|
    puts :alteration_tool_code_inactivated
  }
  pre_code = lambda { |params|
    puts "pre_creation_code,atome_touched: #{:params}"

  }
  post_code = lambda { |params|
    puts "post_creation_code,atome_touched: #{:params}"

  }

  zone_spe = lambda { |current_tool|
    puts "current tool is : #{:current_tool} now creating specific zone"
    # b = box({ width: 33, height: 12 })
    # b.text({ data: :all })

  }

  {
    activation: active_code,
    inactivation: inactive_code,
    alteration: { width: 22, blur: 3 },
    pre: pre_code,
    post: post_code,
    zone: zone_spe,
    int8: { french: :couleur, english: :color, german: :colorad } }

end

new({ tool: :box }) do |params|

  active_code = lambda {
    puts :creation_tool_code_activated
  }

  inactive_code = lambda { |atomes_treated|
    puts :creation_tool_code_inactivated

  }
  pre_creation_code = lambda { |params|
    puts "pre_creation_code : atome_touched : #{:params} "

  }

  post_creation_code = lambda { |params|
    puts "post_creation_code,atome_touched: #{:params}"
  }

  { creation: { box: { color: :blue, width: 66, height: 66 } },
    activation: active_code,
    inactivation: inactive_code,
    pre: pre_creation_code,
    post: post_creation_code,
    int8: { french: :formes, english: :shape, german: :jesaispas } }

end

new({ tool: :drag }) do |params|

  active_code = lambda {
    # Atome.selection.each do |atome_id_to_treat|
    #   # reinit first to avoid multiple drag event
    #   grab(atome_id_to_treat).drag(false)
    # end
    # drag_remove
    # puts :alteration_tool_code_activated
  }

  inactive_code = lambda { |param|
    # puts :alteration_tool_code_inactivated
  }
  pre_code = lambda { |params|
    atome_target = params[:atome_touched]
    # puts  "==> #{atome_target.drag}"
    if atome_target.drag
      atome_target.drag(false)
    else
      atome_target.drag(true)
    end

  }
  post_code = lambda { |params|
    # puts "post_creation_code,atome_touched: #{params}"

  }

  zone_spe = lambda { |current_tool|
    # puts "current tool is : #{current_tool} now creating specific zone"
    # b = box({ width: 33, height: 12 })
    # b.text({ data: :all })

  }

  {
    activation: active_code,
    inactivation: inactive_code,
    # alteration: { drag: true },
    pre: pre_code,
    post: post_code,
    zone: zone_spe,
    int8: { french: :drag, english: :drag, german: :drag } }

end

new({ tool: :select }) do |params|
  pre_code = lambda { |param|
    atome_touched = param[:atome_touched]
    current_tool = param[:current_tool]
    if atome_touched.selected
      atome_touched.selected(false)
      current_tool.data[:allow_alteration] = false
    else
      # alert atome_touched.selected
      # alert Atome.selection
      atome_touched.selected(true)
      # alert atome_touched.selected

      current_tool.data[:allow_alteration] = true
    end
  }
  {
    pre: pre_code,
    alteration: { selected: true },
    int8: { french: :select, english: :select, german: :select }
  }
end

new({ tool: :rotate }) do
  { alteration: { height: 150, rotate: 45 } }
end

new({ tool: :move }) do |params|
  active_code = lambda {
    # if  Atome.selection.instance_of? Array
    # end
    Atome.selection.each do |atome_id_to_treat|
      # #   # reinit first to avoid multiple drag event
      # #   grab(atome_id_to_treat).drag(false)
    end
    # drag_remove
    # puts :alteration_tool_code_activated
  }

  inactive_code = lambda { |params|
    # we remove drag
    params[:treated].each do |atome_f|
      atome_f.drag(false)
    end
    # puts :alteration_tool_code_inactivated

  }
  pre_code = lambda { |params|
    atome_target = params[:atome_touched]
    # puts  "==> #{atome_target.drag}"
    if atome_target.drag
      # atome_target.drag(false)
    else
      atome_target.drag(true)
    end

  }
  post_code = lambda { |params|

    # puts "post_creation_code,atome_touched: #{params}"

  }

  zone_spe = lambda { |current_tool|
    # puts "current tool is : #{current_tool} now creating specific zone"
    # b = box({ width: 33, height: 12 })
    # b.text({ data: :all })

  }

  {
    activation: active_code,
    inactivation: inactive_code,
    # alteration: { drag: true },
    pre: pre_code,
    post: post_code,
    zone: zone_spe,
    int8: { french: :drag, english: :drag, german: :drag } }

end

new({ tool: :project }) do
  active_code = lambda {

    alert :get_projects_now
    # if  Atome.selection.instance_of? Array
    # end
    # Atome.selection.each do |atome_id_to_treat|
    #   # #   # reinit first to avoid multiple drag event
    #   # #   grab(atome_id_to_treat).drag(false)
    # end
    # drag_remove
    # puts :alteration_tool_code_activated
  }
  { activation: active_code }
end

new({tool: :test}) do
  active_code = lambda {
    b=grab(:view).box({})
    b.touch(true) do
      alert :kool
    end
  }
  # active_code=:tito
  { activation: active_code }
end


Universe.tools_root=[:box, :blur, :drag, :rotate, :select, :move,:project]
# Universe.tools_root=[:test]
Atome.init_intuition



# ################### check below

# b = box({ left: 123, top: 66, selected: false, id: :the_box, color: :green })
# b.touch(:down) do
#   puts " on touch : #{Universe.allow_localstorage}"
# end
# b.resize(true) do
#   puts :good!
# end
# the_circ = circle({ left: 123, top: 120, selected: false, id: :the_circle })
#
# the_circ.touch(:down) do |params|
#   puts " down : params: #{params}, id: #{the_circ.id}"
# end
#
# the_circ.touch(:up) do
#   puts "up :kool"
# end
# the_circ.drag(true) do
#   puts "drag : now"
# end
#
# bb = box({ left: 333, width: 120, selected: false, id: :big_box })
#
# b = box({ id: :the_big_boxy })

#################@
# text({ data: :hello, selected: true, left: 120, id: :texting, blur: 12 })
# text({data: :hello, left: 120, id: :texting})
# Universe.tools.each_with_index do |(tool_name, bloc), index|
#  Atome.instance_exec(&bloc) if bloc.is_a?(Proc)
#   # alert "#{tool_name} : #{tool_content}"
#   # alert b.id
# end

# wait 2 do
#   # c.preset( {:box=>{:width=>39, :height=>39, :apply=>[:box_color], :left=>0, :top=>0}} )
#   c.preset( :box )
# end
# b=box({left: 333, top: 333})
# b.touch(true) do
#   alert Atome.selection
# end
# grab(:the_texting).color(:white)
# grab(:the_texting).left(33)
# grab(:the_texting).top(133)
# grab(:the_texting).width(133)
# grab(:the_texting).top(133)
# grab(:the_texting).data(:kool)
# grab(:the_texting).type(:text)
# grab(:the_texting).rotate(:text)

# b=box
# b.touch(true) do
#   puts :ok
#   # alert b.instance_variable_get('@touch')
#   # alert b.instance_variable_get('@touch_code')
#   b.touch(false)
#   wait 3 do
#     puts :ready
#     b.touch(true) do
#       puts :kool
#     end
#     # alert b.touch
#     # alert b.instance_variable_get('@touch')
#     # alert b.instance_variable_get('@touch_code')
#   end
# end

# A.html.record

# A.html.record



