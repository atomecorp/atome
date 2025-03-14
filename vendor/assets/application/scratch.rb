# frozen_string_literal: true

# patch to hide native toolbox
grab(:toolbox_tool).display(false)

class Vie
  attr_accessor :current_orientation, :basic_objects, :current_matrix, :actions, :tools

  def initialize
    super
    @basic_objects = []
    @current_orientation = nil

    height_found = grab(:view).to_px(:height)
    width_found = grab(:view).to_px(:width)

    basic_objects
    basic_tool
    init_design(width_found, height_found)
    # matrix_behaviors
    grab(:view).on(:resize) do |ev|
      width = ev[:width].to_i
      height = ev[:height].to_i
      update_design(width, height)
      nil
    end

  end

  # styles
  def vie_size
    {
      icon_size: 15,
      buttons: 25,
      basic: 18,
      title_width: 50,
      title_height: 30,
      tool_size: 30,
      basic_size: 39,
      basic_width: 39,
      basic_height: 39,
      panel: 120,
      inspector: 192,
      margin: 12,
      matrix_min: 192
    }
  end

  def vie_colors
    {
      inactive_tool: { red: 0.7, green: 0.7, blue: 0.7, alpha: 1 },
      cells: { red: 0.6, green: 0.3, blue: 0.09, alpha: 1 },
      action_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      title_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      inspector: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      work_zone: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      tool_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      titles: { red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }
    }
  end

  def vie_style_horizontal
    {
      title_bar: { depth: 1, height: vie_size[:basic_size],
                   width: '100%' },
      action_bar: { depth: 1, height: :auto, width: vie_size[:basic_size], left: :auto, right: 0,
                    top: vie_size[:basic_size] + vie_size[:margin], bottom: vie_size[:margin]
      },
      tool_bar: { depth: 1,
                  width: vie_size[:basic_size], height: :auto, left: 0, top: vie_size[:basic_size] + vie_size[:margin],
                  bottom: vie_size[:margin]
      },

      inspector: { depth: 2, overflow: :auto,
                   width: vie_size[:inspector], height: :auto, left: vie_size[:basic_size],
                   top: vie_size[:basic_size] + vie_size[:margin], bottom: vie_size[:margin] },
      work_zone: { overflow: :auto, depth: 0, width: :auto, height: :auto,
                   left: vie_size[:inspector] + vie_size[:basic_size], top: vie_size[:basic_size] + vie_size[:margin],
                   bottom: 0, right: vie_size[:basic_size] }
    }
  end

  def vie_style_vertical
    {
      title_bar: { depth: 1, height: vie_size[:basic_size],
                   width: '100%' },
      action_bar: { depth: 1, height: vie_size[:basic_size], width: '100%', left: vie_size[:margin], right: vie_size[:margin],
                    top: :auto, bottom: 0,
      },
      tool_bar: { depth: 1,
                  height: vie_size[:basic_size], width: :auto, left: vie_size[:margin], right: vie_size[:margin],
                  top: :auto, bottom: vie_size[:basic_size],
      },

      inspector: { depth: 2, overflow: :auto,
                   width: :auto,
                   height: vie_size[:inspector], left: vie_size[:margin], right: vie_size[:margin],
                   top: :auto, bottom: vie_size[:basic_size] * 2,
      },
      work_zone: { overflow: :auto, depth: 0, width: :auto, height: :auto,
                   left: 0, top: vie_size[:basic_size], bottom: vie_size[:basic_size] * 2 + vie_size[:inspector], right: 0 }
    }
  end

  def vertical_design
    @basic_objects.each do |elem|
      grab(elem).set(vie_style_vertical[elem])
    end
    @actions.each_with_index do |elem, index|
      if index == 0
        left_f = 0
        centering = { y: 0 }
      else
        left_f = after(@actions[index - 1])
        centering = { y: 0 }
      end
      grab(elem).set(left: left_f, center: centering)
    end
    @tools.each_with_index do |elem, index|
      if index == 0
        left_f = 0
        centering = { y: 0 }
      else
        left_f = after(@actions[index - 1])
        centering = { y: 0 }
      end
      grab(elem).set(left: left_f, center: centering)
    end

  end

  def horizontal_design
    @basic_objects.each do |elem|
      grab(elem).set(vie_style_horizontal[elem])
    end
    @actions.each_with_index do |elem, index|
      if index == 0
        top_f = 0
        centering = { x: 0 }
      else
        top_f = below(@actions[index - 1])
        centering = { x: 0 }
      end
      grab(elem).set(top: top_f, center: centering)
    end
    @tools.each_with_index do |elem, index|
      if index == 0
        top_f = 0
        centering = { x: 0 }
      else
        top_f = below(@actions[index - 1])
        centering = { x: 0 }
      end
      grab(elem).set(top: top_f, center: centering)
    end
  end

  def basic_tool
    @actions = [:select_tool, :copy_tool, :paste_tool, :undo_tool, :redo_tool]
    @tools = [:file_tool, :module_tool]
    vie_tool_builder({ attach: :action_bar, tools: @actions })
    vie_tool_builder({ attach: :tool_bar, tools: @tools })
  end

  def basic_creator(id)
    @basic_objects << id
    box({ id: id, display: false, color: vie_colors[id] })
  end

  def vie_tool_builder(params)

    attach_f = params[:attach]
    tools_list_f = params[:tools]
    tools_list_f.each do |tool_id|

      new_tool = grab(attach_f).box({ width: vie_size[:tool_size], height: vie_size[:tool_size],
                                      top: 0, bottom: 0, left: 0, right: 0, color: { alpha: 0 },
                                      apply: :standard_shadow, id: tool_id })

      svg_name = tool_id.to_s.sub('_tool', '')
      temp_icon = "#{tool_id}_icon_tmp"
      grab(:black_matter).image(id: temp_icon, path: "medias/images/icons/#{svg_name}.svg", width: 22, height: 22, center: true, opacity: 0.6)
      new_tool.vector({ width: 33, height: 33, id: "#{tool_id}_icon" })
      A.svg_to_vector({ source: "#{tool_id}_icon_tmp", target: "#{tool_id}_icon", normalize: true }) do |params_pass|
        new_svg = grab(params_pass[:target])
        new_svg.color(vie_colors[:inactive_tool])
        new_svg.width(21)
        new_svg.height(21)
        new_svg.center(true)
      end

      new_tool.touch(true) do
        new_tool.alternate({ color: :red, shadow: { alpha: 1 }, blur: 3 }, { color: :green, shadow: false })
      end
    end
  end

  def basic_objects
    element({ id: :vie, data: { current_matrix: :vie_0, context: :none, selected: [] } })
    shadow({
             id: :standard_shadow,
             left: 0, top: 0, blur: 9,
             invert: false,
             red: 0, green: 0, blue: 0, alpha: 0.6
           })
    shadow({
             id: :invert_shadow,
             left: -3, top: 3, blur: 9,
             invert: true,
             red: 0, green: 0, blue: 0, alpha: 0.6
           })

    @current_matrix = grab(:vie).data[:current_matrix]

    # Basic design
    basic_creator(:work_zone)
    basic_creator(:inspector)
    basic_creator(:title_bar)
    basic_creator(:tool_bar)
    basic_creator(:action_bar)

    # special treatment
    grab(:inspector).apply([:invert_shadow])

    # matrix
    main_matrix = grab(:work_zone).matrix({ id: @current_matrix, rows: 8, columns: 8, spacing: 9, size: 333 })

    matrix_content = main_matrix.cells
    matrix_content.color(vie_colors[:cells])
    matrix_content.smooth(6)
    matrix_content.apply([:standard_shadow])

    # basic elements
    grab(:title_bar).input({
                             trigger: :return,
                             back: { alpha: 0 },
                             component: { size: 16 },
                             text: { color: vie_colors[:titles], left: vie_size[:margin], top: 3, align: :center },
                             smooth: 3,
                             height: 23,
                             width: vie_size[:panel],
                             id: :project_title,
                             default: 'Untitled',
                             center: true
                           }) do |val|
      puts "validated: #{val}"
    end
    grab(:title_bar).image({ id: :vie_logo, path: "./medias/images/logos/vie.svg", left: vie_size[:margin], top: vie_size[:margin] / 3, size: 27 })
  end

  # utils

  def set_orientation(orientation)
    if orientation == :horizontal
      horizontal_design
    else
      vertical_design
    end
  end

  def init_design(width_found, height_found)
    new_orientation = width_found > height_found ? :horizontal : :vertical
    @current_orientation = new_orientation
    current_matrix = grab(@current_matrix)

    set_orientation(new_orientation)
    @basic_objects.each do |elem|
      grab(elem).display(true)
    end

    work_zone_width = grab(:work_zone).to_px(:width)
    work_zone_height = grab(:work_zone).to_px(:height)

    if work_zone_width < work_zone_height
      size = work_zone_width - 30
    else
      size = work_zone_height - 30
    end
    current_matrix.resize_matrix({ width: size, height: size })

    current_matrix.center({ x: 0 })
    grab(:project_title).center(true)
  end

  def update_design(width_found, height_found)
    new_orientation = width_found > height_found ? :horizontal : :vertical
    @current_orientation = new_orientation
    current_matrix = grab(@current_matrix)

    set_orientation(new_orientation)
    @basic_objects.each do |elem|
      grab(elem).display(true)
    end

    work_zone_width = grab(:work_zone).to_px(:width)
    work_zone_height = grab(:work_zone).to_px(:height)

    if work_zone_width < work_zone_height
      size = work_zone_width - vie_size[:basic_size]
    else
      size = work_zone_height - vie_size[:basic_size]
    end
    current_matrix.resize_matrix({ width: size, height: size })

    current_matrix.center({ x: 0 })
  end

  def matrix_behaviors
    main_matrix = grab(@current_matrix)
    matrix_content = main_matrix.cells
    matrix_content.over(:enter) do |event|
      if grab(:vie).data[:context] == :mouse_down
        current_cell = grab(event[:target][:id].to_s)
        current_cell.color(:green)
        grab(:vie).data[:selected] << current_cell
      end

    end
    matrix_content.touch(:down) do |event|
      grab(:vie).data[:context] = :mouse_down
      current_cell = grab(event[:target][:id].to_s)
      grab(:vie).data[:selected] << current_cell
      current_cell.color(:green)
    end

    matrix_content.touch(:up) do |event|
      grab(:vie).data[:context] = :none
      current_cell = grab(event[:target][:id].to_s)
      if current_cell.selected
        current_cell.color(vie_colors[:cells])
        current_cell.selected(false)
      else
        current_cell.color(:orange)
        current_cell.selected(true)
      end
    end

    matrix_content.touch(:double) do |event|
      current_cell = grab(event[:target][:id].to_s)
      current_cell.color(:red)
    end
  end

end

Vie.new


