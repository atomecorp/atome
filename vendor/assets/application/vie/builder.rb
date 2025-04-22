# frozen_string_literal: true

# main class for Vie app
class Vie
  attr_accessor :current_orientation, :basic_objects, :current_matrix, :actions, :tools, :views, :context

  def initialize
    super
    @basic_objects = []
    @current_orientation = nil
    @context={}
    height_found = grab(:view).to_px(:height)
    width_found = grab(:view).to_px(:width)

    basic_objects_builder
    basic_tool
    init_design(width_found, height_found)
    matrix_behaviors
    grab(:view).on(:resize) do |ev|
      width = ev[:width].to_i
      height = ev[:height].to_i
      update_design(width, height)
      nil
    end
  end

  def basic_tool
    @actions = %i[select_tool copy_tool paste_tool undo_tool redo_tool]
    @views = %i[edit_tool sequence_tool mixer_tool separator]
    @filer = %i[file_tool clear_tool save_tool]
    @actions_bar_content = @views.concat(@actions)
    vie_tool_builder({ attach: :tool_bar, tools: @actions_bar_content })
    vie_tool_builder({ attach: :filer_bar, tools: @filer })
  end

  def basic_creator(id)
    @basic_objects << id
    box({ id: id, display: false, color: vie_colors[id] })
  end

  def vie_tool_builder(params)
    attach_f = params[:attach]
    tools_list_f = params[:tools]
    tools_list_f.each do |tool_id|
      if tool_id == :separator
        height_wanted = vie_size[:separator_size]
        tool_shadow = nil
      else
        height_wanted = vie_size[:tool_size]
        tool_shadow = :standard_shadow
      end
      # we build the tool support
      new_tool = grab(attach_f).box({ width: vie_size[:tool_size], height: height_wanted, smooth: 6,
                                      top: 0, bottom: 0, left: 0, right: 0, color: vie_colors[:tool_support],
                                      apply: tool_shadow, id: tool_id })

      svg_name = tool_id.to_s.sub('_tool', '')
      temp_icon = "#{tool_id}_icon_tmp"
      grab(:black_matter).image(id: temp_icon, path: "medias/images/icons/#{svg_name}.svg")
      new_tool.vector({ width: 33, height: 33, id: "#{tool_id}_icon" })
      A.svg_to_vector({ source: "#{tool_id}_icon_tmp", target: "#{tool_id}_icon", normalize: true }) do |params_pass|
        new_svg = grab(params_pass[:target])
        new_svg.color(vie_colors[:inactive_tool])
        new_svg.width(vie_size[:icon])
        new_svg.height(vie_size[:icon])
        new_svg.center(true)
        if params_pass[:target] == 'separator_icon'
          new_svg.color(:red)
        else
          new_svg.color(vie_colors[:inactive_tool])
        end
      end
      next if tool_id == :separator
      tool_behavior(new_tool)
    end
  end

  def basic_objects_builder
    element({ id: :vie, data: { current_matrix: :vie_0, context: :none, selected: [] } })

    @current_matrix = grab(:vie).data[:current_matrix]

    # Basic design
    basic_creator(:work_zone)
    basic_creator(:inspector)
    basic_creator(:title_bar)
    basic_creator(:filer_bar)
    basic_creator(:tool_bar)

    # special treatment
    inspector = grab(:inspector)
    inspector.apply([:invert_shadow])
    inspector.smooth(9)
    inspector.color(vie_colors[:inspector])

    # matrix
    main_matrix = grab(:work_zone).matrix({ id: @current_matrix, rows: 8, columns: 8, spacing: 9, size: 333 })

    matrix_content = main_matrix.cells
    matrix_content.color(vie_colors[:cells])
    matrix_content.smooth(6)
    matrix_content.apply([:invert_shadow])
    matrix_content.apply([:standard_shadow])

    # basic elements
    grab(:title_bar).input({
                             trigger: :return,
                             back: { alpha: 0 },
                             component: { size: 16 },
                             text: { color: vie_colors[:titles], left: vie_size[:margin], top: 3, align: :center },
                             smooth: 3,
                             height: 23,
                             width: 120,
                             id: :project_title,
                             default: 'Untitled',
                             center: true
                           }) do |val|

      if val.length == 1
        grab(:project_title).holder.data('new project')
      end
    end
    grab(:project_title).touch(:down) do
      if  grab(:project_title).holder.data.length == 1
        grab(:project_title).holder.data('new project')
      end
    end
    grab(:title_bar).image({ id: :vie_logo, path: './medias/images/logos/vie.svg', left: :auto,
                             right: vie_size[:margin],    top: vie_size[:margin], size: 27 })
  end

end

vie = Vie.new
vie.version
