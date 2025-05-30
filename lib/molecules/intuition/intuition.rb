# frozen_string_literal: true

new({ tool: :toolbox }) do
  active_code = lambda {
    toolbox({ tools: [:console], toolbox: { orientation: :ew, left: 49, bottom: 9, spacing: 9 } })
  }
  { activation: active_code }
end

new({ tool: :console }) do |params|

  active_code = lambda {
    atome_console = grab(:atome_console)
    if atome_console
      # alert :deleting
      atome_console.delete(recursive: true)
    else
      # alert :creating
      a_console
    end

    # puts :alteration_tool_code_activated
  }

  inactive_code = lambda { |param|
    # puts :alteration_tool_code_inactivated1
  }
  pre_code = lambda { |params|
    # puts "pre_creation_code,atome_touched: #{:params}"

  }
  post_code = lambda { |params|
    # puts "post_creation_code,atome_touched: #{:params}"

  }

  zone_spe = lambda { |current_tool|
    # puts "current tool is : #{:current_tool} now creating specific zone"
    # b = box({ width: 33, height: 12 })
    # b.text({ data: :all })

  }

  {
    activation: active_code,
    # alteration: { width: 22, blur: 3 },
    # pre: pre_code,
    # post: post_code,
    # zone: zone_spe,
    icon: :console,
    int8: { french: :console, english: :console, german: :console } }

end

# Universe.tools_root= {tools: [:blur, :box, :test, :toolbox1],toolbox: { orientation: :ew, left:90 , bottom: 9, spacing: 9} }
Universe.tools_root = { id: :root_tools, tools: [:toolbox], toolbox: { orientation: :ew, left: 9, bottom: 9, spacing: 9 } }
# puts "above we added an id because each tool may be in many toolbox and have an uniq ID"

# un-comment to activate tools
Atome.init_intuition
