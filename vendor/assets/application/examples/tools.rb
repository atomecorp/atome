# frozen_string_literal: true



new({ tool: :combined }) do |params|

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
    # puts "current tool is : #{:current_tool} now creating specific zone"
    # b = box({ width: 33, height: 12 })
    # b.text({ data: :all })

  }

  {
    activation: active_code,
    inactivation: inactive_code,
    # alteration: { width: 22, blur: 3 },
    alteration: { width: 22, blur: 3 },
    pre: pre_code,
    post: post_code,
    zone: zone_spe,
    icon: :color,
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

new({ tool: :move }) do
  move_active_code = lambda {
    all=grab(:view).fasten
    @previous_selected_atomes=[]
    @previous_draggable_atomes=[]
    all.each do |at_f|
      if grab(at_f).drag
        @previous_draggable_atomes << at_f
      end
      if grab(at_f).selected
        @previous_selected_atomes << at_f
      else
        grab(at_f).selected(true)
      end
    end
  }
  move_code = lambda {
    drag(true)
  }
  move_inactive_code = lambda { |data|
    all=grab(:view).fasten
    all.each do |at_f|
      unless @previous_selected_atomes.include?(at_f)
        grab(at_f).selected(false)
      end
    end
    data[:treated].each do |atome_f|
      unless @previous_draggable_atomes.include?(atome_f.id)
        atome_f.drag(false)
      end

    end
  }

  { activation: move_active_code,
    alteration: { event: move_code },
    inactivation: move_inactive_code}
end

new({ tool: :drag }) do
  drag_active_code = lambda {
    all=grab(:view).fasten
    @previous_selected_atomes=[]
    all.each do |at_f|
      if grab(at_f).selected
        @previous_selected_atomes << at_f
      else
        grab(at_f).selected(true)
      end
    end
  }

  drag_inactive_code = lambda { |_data|
    all=grab(:view).fasten
    all.each do |at_f|
      unless @previous_selected_atomes.include?(at_f)
        grab(at_f).selected(false)
      end
    end
  }
  move_code = lambda {
    drag(true) do
      puts left
    end
  }

  { activation: drag_active_code, alteration: { event: move_code },   inactivation: drag_inactive_code }
end

new({ tool: :touch }) do
  move_code = lambda {
    touch(:down) do
      color(:red)
    end
  }
  { alteration: { event: move_code } }
end

select_code=lambda{

  if selected
    selected(false)
  else
    selected(true)
  end
  # alternate({ selected: true}, {selected: false})

}
new({ tool: :select }) do

  # { alteration: { selected: true }}
  { alteration: { event: select_code }}


end

new({ tool: :toolbox1 }) do
  active_code = lambda {
    toolbox({ tools: [:combined], toolbox: { orientation: :ew, left: 90, bottom: 9, spacing: 9 } })
  }
  { activation: active_code }
end

new({ tool: :color }) do
  active_code = lambda {
    puts 'color activated1'
  }
  color_code = lambda {
    # color(:green)
    # tools_values
  }
  inactive_code = lambda { |data|
    data[:treated].each do |atome_f|
      # atome_f.drag(false)
      # atome_f.color(:green)
    end
  }

  { activation: active_code,
    alteration: { event: color_code },
    inactivation: inactive_code,
    target: :color,
    particles: { red: 0, green: 0.5, blue: 1, alpha: 1 }}
end

new({ tool: :crash_test }) do
  active_code = lambda {
    puts 'color activated1'
  }
  color_code = lambda {
    # color(:green)
    # tools_values
  }
  inactive_code = lambda { |data|
    data[:treated].each do |atome_f|
      # atome_f.drag(false)
      # atome_f.color(:green)
    end
  }

  {
    # activation: active_code,
    alteration: { width: 22},
    # inactivation: inactive_code,
    # target: :color,
    # particles: { red: 0, green: 0.5, blue: 1, alpha: 1 }
    }
end

# Universe.tools_root= {tools: [:blur, :box, :test, :toolbox1],toolbox: { orientation: :ew, left:90 , bottom: 9, spacing: 9} }
Universe.tools_root = {id: :root_tools, tools: [:select,:crash_test, :box, :drag, :touch,:color, :move, :toolbox1], toolbox: { orientation: :ew, left: 9, bottom: 9, spacing: 9 } }
puts "above we added an id because each tool may be in many toolbox and have an uniq ID"
Atome.init_intuition

b = box({ id: :the_test__box, selected: true })
c=circle({ left: 90, id: :the_test_circle, selected: false })
c.drag(true) do
  puts "moving"
end
b.touch(true) do
  if b.width == 170
    b.width(55)
  else
    b.width(170)
  end

end

