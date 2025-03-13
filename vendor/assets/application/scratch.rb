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

    grab(:view).on(:resize) do |ev|
      width = ev[:width].to_i
      height = ev[:height].to_i
      update_design(width, height)
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
    parent_f = grab(attach_f)
    width_found = parent_f.to_px(:width)
    height_found = parent_f.to_px(:height)
    parent_orientation = width_found > height_found ? :horizontal : :vertical

    tools_list_f.each_with_index do |tool_id, index|

      new_tool = grab(attach_f).box({ width: vie_size[:tool_size], height: vie_size[:tool_size],
                                      top: 0, bottom: 0, left: 0, right: 0, color: { alpha: 0 },
                                      apply: :standard_shadow, id: tool_id })

      svg_name = tool_id.to_s.sub('_tool', '')
      temp_icon = "#{tool_id}_icon_tmp"
      grab(:black_matter).image(id: temp_icon, path: "medias/images/icons/#{svg_name}.svg", width: 22, height: 22, center: true, opacity: 0.6)
      new_tool.vector({ width: 33, height: 33, id: "#{tool_id}_icon" })
      A.svg_to_vector({ source: "#{tool_id}_icon_tmp", target: "#{tool_id}_icon", normalize: true }) do |params|
        new_svg = grab(params[:target])
        new_svg.color(:orange)
        new_svg.width(21)
        new_svg.height(21)
        new_svg.center(true)
      end

      new_tool.touch(true) do
        new_tool.alternate({ color: :red, shadow: { alpha: 1 }, blur: 3 }, { color: :green, shadow: false })
      end
    end
    # grab(:black_matter).clear(true)

    # grab(:black_matter).image(id: id_f, path: "medias/images/icons/#{id_f}.svg", width: 22, height: 22, center: true, opacity: 0.6)
    # new_svg=new_tool.vector({ width: 33, height: 33, id: :my_placeholder })
    # A.svg_to_vector({ source: :redo, target: :my_placeholder }) do
    #   new_svg.color(:orange)
    #   grab(:atomic_logo).delete(true)
    # end
    # img.touch(true) do
    #   img.alternate({color: :red, shadow: { alpha:  1 }, blur: 3 }, {color: :green,  shadow: false })
    # end
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

    # menu.image({ path: 'medias/images/icons/menu.svg', id: :menu_icon, width: vie_size[:icon_size],
    #              height: vie_size[:icon_size], center: true })
    # edit = title_bar.box({ id: :edit, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: :auto,
    #                      }.merge(vie_style[:buttons]))
    # edit.image({ path: 'medias/images/icons/edit.svg', id: :edit_icon, width: vie_size[:icon_size],
    #              height: vie_size[:icon_size], center: true })
    # perform = title_bar.box({ id: :perform, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: :auto,
    #                         }.merge(vie_style[:buttons]))
    # perform.image({ path: 'medias/images/icons/play.svg', id: :perform_icon, width: vie_size[:icon_size],
    #                 height: vie_size[:icon_size], center: true })
    #
    # sequence = title_bar.box({ id: :sequence, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: :auto,
    #                          }.merge(vie_style[:buttons]))
    # sequence.image({ path: 'medias/images/icons/sequence.svg', id: :sequence_icon, width: vie_size[:icon_size],
    #                  height: vie_size[:icon_size], center: true })
    # mix = title_bar.box({ id: :mix, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: :auto,
    #                     }.merge(vie_style[:buttons]))
    # mix.image({ path: 'medias/images/icons/mixer.svg', id: :mix_icon, width: vie_size[:icon_size],
    #             height: vie_size[:icon_size], center: true })
    #
    # toolbox = title_bar.box({ id: :toolbox, width: :auto, height: 33, top: 0, bottom: 0, left: after(:menu),
    #                           right: before(mix), overflow: :auto, color: { alpha: 0 } })
    #
    # # module_tool = toolbox.box({id: :module_tool,  width: 33, height: 33, top: 0, bottom: 0, left: vie_size[:margin], center: { y: 0 }, color: { alpha: 0.18 } })
    # # module_tool.image(path: 'medias/images/icons/module.svg', width: 22, height: 22, center: true, opacity: 0.6)
    # #
    # # select_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(:module_tool), center: { y: 0 }, color: { alpha: 0.18 } })
    # # select_tool.image(path: 'medias/images/icons/select.svg', width: 22, height: 22, center: true, opacity: 0.6)
    # #
    # # link_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(select_tool), center: { y: 0 }, color: { alpha: 0.18 } })
    # # link_tool.image(path: 'medias/images/icons/link.svg', width: 22, height: 22, center: true, opacity: 0.6)
    # #
    # # delete_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(link_tool), center: { y: 0 }, color: { alpha: 0.18 } })
    # # delete_tool.image(path: 'medias/images/icons/delete.svg', width: 22, height: 22, center: true, opacity: 0.6)
    # #
    # # copy_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(delete_tool), center: { y: 0 }, color: { alpha: 0.18 } })
    # # copy_tool.image(path: 'medias/images/icons/copy.svg', width: 22, height: 22, center: true, opacity: 0.6)
    # #
    # # paste_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(copy_tool), center: { y: 0 }, color: { alpha: 0.18 } })
    # # paste_tool.image(path: 'medias/images/icons/paste.svg', width: 22, height: 22, center: true, opacity: 0.6)
    # #
    # # undo_tool = toolbox.box({id: :undo_support, width: 33, height: 33, top: 0, bottom: 0, left: after(paste_tool), center: { y: 0 }, color: { alpha: 0.18 } })
    # # undo_tool.image(path: 'medias/images/icons/undo.svg', width: 22, height: 22, center: true, opacity: 0.6)

    #
    # file_tool = title_bar.box({ id: :file_tool, width: :auto, height: 33, top: 0, bottom: 0, left: after(menu),
    #                             right: before(mix), overflow: :auto, color: { alpha: 0 } })
    # file_tool.display(false)
    #
    # # load = file_tool.box({ id: :load, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: vie_size[:margin],
    # #                        top: vie_size[:margin] }.merge(vie_style[:buttons]))
    # # load.image({ path: 'medias/images/icons/load.svg', id: :load_icon, width: vie_size[:icon_size],
    # #              height: vie_size[:icon_size], center: true })
    # #
    # # new = file_tool.box({ id: :new, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: after(load),
    # #                       top: vie_size[:margin] }.merge(vie_style[:buttons]))
    # # new.image({ path: 'medias/images/icons/new.svg', id: :new_icon, width: vie_size[:icon_size],
    # #             height: vie_size[:icon_size], center: true })
    # #
    # # import = file_tool.box({ id: :import, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons],
    # #                          left: after(new), top: vie_size[:margin] }.merge(vie_style[:buttons]))
    # # import.image({ path: 'medias/images/icons/save.svg', id: :import_icon, width: vie_size[:icon_size],
    # #                height: vie_size[:icon_size], center: true })
    # #
    # # export = file_tool.box({ id: :export, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons],
    # #                          left: after(import), top: vie_size[:margin] }.merge(vie_style[:buttons]))
    # # export.image({ path: 'medias/images/icons/save.svg', id: :export_icon, width: vie_size[:icon_size],
    # #                height: vie_size[:icon_size], center: true, rotate: 180 })
  end

  def list_project(listing, projects)
    projects.each_with_index do |project_name, index|
      project = listing.text({ data: project_name, top: index })
      project.touch(true) do
        grab(:inspector).text(project_name)
      end
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
      # utils_width: 190,
      matrix_min: 192
    }
  end

  def vie_colors
    {
      cells: { red: 0.6, green: 0.3, blue: 0.09, alpha: 1 },
      action_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      title_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      inspector: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      work_zone: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      tool_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      titles: { red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }
    }
  end

  # def vie_colors
  #   {
  #     cells: { red: 0.19, green: 0.19, blue: 0.19, alpha: 1 },
  #     action_bar: :red,
  #     # work: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
  #     title_bar: :green,
  #     inspector: :blue,
  #     work_zone: :black,
  #     tool_bar: :pink
  #   }
  # end

  def vie_style_horizontal
    {
      title_bar: { depth: 1, height: vie_size[:basic_size],
                   # color: vie_colors[:background],
                   # color: :red,
                   width: '100%' },
      action_bar: { depth: 1, height: :auto, width: vie_size[:basic_size], left: :auto, right: 0,
                    top: vie_size[:basic_size], bottom: 0,
                    # color: vie_colors[:background],
                    # color: :pink,
      },
      tool_bar: { depth: 1,
                  # color: vie_colors[:background],
                  width: vie_size[:basic_size], height: :auto, left: 0, top: vie_size[:basic_size], bottom: 0,
                  # color: :yellow,

      },

      inspector: { depth: 2, overflow: :auto,
                   # color: vie_colors[:background],
                   # color: {alpha: 0.2},
                   width: vie_size[:inspector], height: :auto, left: vie_size[:basic_size], top: vie_size[:basic_size],
                   bottom: vie_size[:margin] },
      work_zone: { overflow: :auto, depth: 0, width: :auto, height: :auto,
                   # color: vie_colors[:background],
                   # color: :blue,
                   left: vie_size[:inspector] + vie_size[:basic_size], top: vie_size[:basic_size], bottom: 0, right: vie_size[:basic_size] }
    }
  end

  def vie_style_vertical
    {
      title_bar: { depth: 1, height: vie_size[:basic_size],
                   # color: vie_colors[:background],
                   # color: :red,
                   width: '100%' },
      action_bar: { depth: 1, height: vie_size[:basic_size], width: '100%', left: 0, right: 0,
                    top: :auto, bottom: 0,
                    # color: vie_colors[:background],
                    # color: :pink,
      },
      tool_bar: { depth: 1,
                  # color: vie_colors[:background],
                  height: vie_size[:basic_size], width: :auto, left: 0, right: 0,
                  top: :auto, bottom: vie_size[:basic_size],
                  # color: :yellow,
      },

      inspector: { depth: 2, overflow: :auto,
                   # color: vie_colors[:background],
                   # color: :green,
                   width: :auto,
                   height: vie_size[:inspector], left: vie_size[:margin], right: vie_size[:margin],
                   top: :auto, bottom: vie_size[:basic_size] * 2,
      },
      work_zone: { overflow: :auto, depth: 0, width: :auto, height: :auto,
                   # color: vie_colors[:background],
                   # color: :blue,
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
      grab(elem).set(left: left_f,  center: centering)
    end
    @tools.each_with_index do |elem, index|
      if index == 0
        left_f = 0
        centering = { y: 0 }
      else
        left_f = after(@actions[index - 1])
        centering = { y: 0 }
      end
      grab(elem).set(left: left_f,  center: centering)
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
    current_matrix_background = grab(@current_matrix)

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
    current_matrix_background.resize_matrix({ width: size, height: size })

    current_matrix_background.center(true)
    grab(:project_title).center(true)

    # if index == 0 && parent_orientation == :vertical
    #   top_f = 0
    #   centering = { x: 0 }
    # elsif index == 0 && parent_orientation == :horizontal
    #   left_f = 0
    #   centering = { y: 0 }
    # end
    # new_tool = grab(attach_f).box({ width: vie_size[:tool_size], height: vie_size[:tool_size],
    #                                 top: top_f, bottom: 0, left: left_f, right: 0, center: centering, color: { alpha: 0 },
    #                                 apply: :standard_shadow, id: tool_id })

  end

  def update_design(width_found, height_found)
    new_orientation = width_found > height_found ? :horizontal : :vertical
    @current_orientation = new_orientation
    current_matrix_background = grab(@current_matrix)

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
    current_matrix_background.resize_matrix({ width: size, height: size })

    # current_matrix_background.center(true)
    # grab(:project_title).center(true)

  end

  #
  # # def refresh_design
  # #   title_bar = grab(:title_bar)
  # #   panel = grab(:panel)
  # #   inspector = grab(:inspector)
  # #   work_zone = grab(:work_zone)
  # #   menu = grab(:menu)
  # #   project_title = grab(:project_title)
  # #   edit = grab(:edit)
  # #   perform = grab(:perform)
  # #   sequence = grab(:sequence)
  # #   mix = grab(:mix)
  # #   toolbox = grab(:toolbox)
  # #   file_tool = grab(:file_tool)
  # #   case grab(:design_mode).data[:active_mode]
  # #   when :mode_vertical_alt
  # #     title_bar.set({ width: :auto, height: (vie_size[:title_height] * 2), top: 0, bottom: 0, left: 0,
  # #                     right: 0, depth: 3 })
  # #
  # #     panel.set({ width: :auto, height: vie_size[:panel], top: :auto, left: 0, bottom: 0, right: 0, depth: 3 })
  # #     inspector.set({ width: :auto, height: vie_size[:inspector], bottom: above(panel),
  # #                     top: :auto, left: 0, right: 0, depth: 7 })
  # #
  # #     work_zone.set({ width: :auto, height: :auto, top: below(title_bar), bottom: above(inspector),
  # #                     left: 0, right: 0, depth: 3 })
  # #
  # #     project_title.set({ left: 0, top: 0 })
  # #
  # #     menu.set({ top: vie_size[:margin], left: 0 })
  # #
  # #     edit.set({ top: vie_size[:margin], left: :auto, right: vie_size[:margin] })
  # #     perform.set({ top: vie_size[:margin], right: before(edit) })
  # #     sequence.set({ top: vie_size[:margin], right: before(perform) })
  # #     mix.set({ top: vie_size[:margin], right: before(sequence) })
  # #     toolbox.set({ top: :auto, bottom: vie_size[:margin], left: 0, right: vie_size[:margin] })
  # #     file_tool.set({ top: :auto, bottom: vie_size[:margin], left: 0, right: vie_size[:margin] })
  # #   when :mode_horizontal_alt
  # #
  # #     title_bar.set({ width: :auto, height: vie_size[:title_height], top: 0, bottom: 0, left: 0,
  # #                     right: 0, depth: 3 })
  # #     inspector.set({ width: :auto, height: vie_size[:inspector], bottom: 0,
  # #                     top: :auto, left: 0, right: 0, depth: 7 })
  # #
  # #     panel.set({ width: vie_size[:panel], height: :auto, top: below(title_bar), bottom: above(inspector), left: 0, depth: 3 })
  # #
  # #     work_zone.set({ width: :auto, height: :auto, top: below(title_bar), bottom: above(inspector),
  # #                     left: after(:panel), right: 0, depth: 3 })
  # #
  # #     project_title.set({ left: 0, top: 0 })
  # #
  # #     menu.set({ center: { y: 0 }, left: 0 })
  # #
  # #     edit.set({ center: { y: 0 }, left: :auto, right: vie_size[:margin] })
  # #
  # #     perform.set({ center: { y: 0 }, right: before(edit) })
  # #     sequence.set({ center: { y: 0 }, right: before(perform) })
  # #     mix.set({ center: { y: 0 }, right: before(sequence) })
  # #     toolbox.set({ top: 0, left: after(:menu), right: before(mix) })
  # #     file_tool.set({ top: 0, left: after(:menu), right: before(mix) })
  # #   else
  # #     # nothing for now
  # #   end
  # #
  # # end
  #

  #
  # # # logo
  # #
  # # # events
  # # class Atome
  # #   def flash(values)
  # #
  # #     duration = values[:duration]
  # #     duration ||= 1
  # #
  # #     color(:orange)
  # #     wait duration do
  # #       color(vie_colors[:buttons])
  # #     end
  # #   end
  # #
  # #   def vie_toggle(value = true, &proc)
  # #     touch(value) do
  # #       proc.call if proc.instance_of? Proc
  # #       flash({ apply: [:action_color], blur: 3, duration: 0.1 })
  # #     end
  # #   end
  # #
  # #   def vie_momentary(value = true, &proc)
  # #     touch(value) do
  # #       proc.call if proc.instance_of? Proc
  # #       alternate({ color: :red, shadow: { alpha: 1, id: :toto }, blur: 3 }, { color: :green })
  # #     end
  # #   end
  # # end
  # #
  # # # menu action
  # # color({ red: 1, id: :color1 })
  # # menu.vie_toggle(:down) do
  # #   a = menu.tick(:menu)
  # #   if a.%(2) == 1
  # #     grab(:title_bar).color({ alpha: 0.3 })
  # #     file_tool.display(true)
  # #     toolbox.display(false)
  # #     menu.opacity(1)
  # #     grab(:menu_icon).path('medias/images/icons/menu.svg')
  # #     menu.rotate(90)
  # #   else
  # #     grab(:menu_icon).path('medias/images/icons/open_menu.svg')
  # #     grab(:title_bar).color({ alpha: 0 })
  # #     # menu.rotate(0)
  # #     menu.opacity(0.5)
  # #     toolbox.display(true)
  # #     file_tool.display(false)
  # #   end
  # # end
  # #
  # # # view action
  # # edit.vie_toggle do
  # #   current_matrix = grab(:vie).data[:current_matrix]
  # #   current_matrix.display(true)
  # # end
  # # perform.vie_toggle do
  # #   current_matrix = grab(:vie).data[:current_matrix]
  # #   current_matrix.display(false)
  # # end
  # # sequence.vie_toggle do
  # #   current_matrix = grab(:vie).data[:current_matrix]
  # #   current_matrix.display(false)
  # # end
  # # mix.vie_toggle do
  # #   current_matrix = grab(:vie).data[:current_matrix]
  # #   current_matrix.display(false)
  # # end
  # #
  # # # tool action
  # #
  # # # module_tool.vie_toggle
  # # # select_tool.vie_toggle
  # # # link_tool.vie_toggle
  # # # delete_tool.vie_toggle
  # # # copy_tool.vie_toggle
  # # # paste_tool.vie_toggle
  # # # undo_tool.vie_toggle
  # #
  # # #################
  # # def build_tool(params, &proc)
  # #   left_f = params[:left] ||= 0
  # #   top_f = params[:top] ||= 0
  # #   parent = grab(params[:parent] ||= :view)
  # #   tool_name = params[:name] || :new
  # #   temp_image="#{tool_name}_temp"
  # #   new_tool_support = parent.box({ id: "#{tool_name}_support", width: 33, height: 33, top: top_f, bottom: 0, left: left_f, center: { y: 0 }, color: { alpha: 0.18 } })
  # #   grab(:black_matter).image(id: temp_image, path: "medias/images/icons/#{tool_name}.svg", width: 22, height: 22, center: true, opacity: 0.6)
  # #   new_tool = new_tool_support.vector({ width: 33, height: 33, id: tool_name})
  # #   A.svg_to_vector({ source: temp_image, target: tool_name }) do
  # #     new_tool.color(:orange)
  # #     grab(temp_image).delete(true)
  # #   end
  # #   if params[:toggle]
  # #     new_tool_support.vie_toggle(true, &proc)
  # #
  # #   else
  # #     new_tool_support.vie_momentary(true, &proc)
  # #   end
  # # end
  # #
  # # build_tool({ name: :clear, parent: :toolbox, left: after(:undo_support), toggle: true }) do
  # #   puts 'message send : hello!'
  # # end
  # #
  # # #################
  # matrix_content.over(:enter) do |event|
  #   if grab(:vie).data[:context] == :mouse_down
  #     current_cell = grab(event[:target][:id].to_s)
  #     current_cell.color(:green)
  #     grab(:vie).data[:selected] << current_cell
  #   end
  #
  # end
  # matrix_content.touch(:down) do |event|
  #   grab(:vie).data[:context] = :mouse_down
  #   current_cell = grab(event[:target][:id].to_s)
  #   grab(:vie).data[:selected] << current_cell
  #   current_cell.color(:green)
  # end
  #
  # matrix_content.touch(:up) do |event|
  #   grab(:vie).data[:context] = :none
  #   current_cell = grab(event[:target][:id].to_s)
  #   if current_cell.selected
  #     current_cell.color(vie_colors[:cells])
  #     current_cell.selected(false)
  #   else
  #     current_cell.color(:orange)
  #     current_cell.selected(true)
  #   end
  # end
  #
  # matrix_content.touch(:double) do |event|
  #   current_cell = grab(event[:target][:id].to_s)
  #   current_cell.color(:red)
  # end
  #
  #
  #
  #
  # #
  # # # initialise the design
  # # initial_width = grab(:view).to_px(:width)
  # # initial_height = grab(:view).to_px(:height)
  # # grab(:design_mode).data[:active_mode] = if initial_width > initial_height
  # #                                           grab(:design_mode).data[:landscape]
  # #                                         else
  # #                                           grab(:design_mode).data[:portrait]
  # #                                         end
  # #
  # # height_found = work_zone.to_px(:height)
  # # min_matrix_size = vie_size[:matrix_min]
  # # height_found = if height_found > min_matrix_size
  # #                  height_found
  # #                else
  # #                  min_matrix_size
  # #                end
  # # main_matrix.resize_matrix({ width: height_found, height: height_found })
  # #
  # # module_tool.touch(true) do
  # #   if grab(:projects_list)
  # #     grab(:projects_list).delete(true)
  # #   else
  # #     choices = grab(:choices)
  # #     listing = choices.box({ id: :projects_list, left: 6, top: 0, color: { alpha: 0 } })
  # #
  # #     projects = %i[demo1 my_project other_1 demo1 my_project other_1 demo1 my_project other_1 demo1
  # #                 my_project other_1 demo1 my_project other_1]
  # #     list_project(listing, projects)
  # #   end
  # #
  # # end
  # #
  # # def init_design
  # #   view = grab(:view)
  # #   height_found = view.to_px(:height)
  # #   main_matrix = grab(:vie).data[:current_matrix]
  # #   refresh_design
  # #   main_matrix.resize_matrix({ width: height_found, height: height_found })
  # # end
  # #
  # # init_design
  # # refresh_design
  #
  # # def design_chooser
  # #
  # # end
  #
  # # grab(:view).on(:resize) do |ev|
  # #   # mode_found =
  # #   if ev[:width].to_i > ev[:height].to_i
  # #     horizontal_design
  # #     # grab(:design_mode).data[:landscape]
  # #   else
  # #     vertical_design
  # #     # grab(:design_mode).data[:portrait]
  # #   end
  # #   #
  # #   # if mode_found != grab(:design_mode).data[:active_mode]
  # #   #   grab(:design_mode).data[:active_mode] = mode_found
  # #   #   refresh_design
  # #   # end
  # #   # height_found = work_zone.to_px(:height)
  # #   # min_matrix_size = vie_size[:matrix_min]
  # #   # height_found = if height_found > min_matrix_size
  # #   #                  height_found
  # #   #                else
  # #   #                  min_matrix_size
  # #   #                end
  # #   # main_matrix.resize_matrix({ width: height_found, height: height_found })
  # # end
  #
  #
  # height= grab(:view).to_px(:height)
  # width=grab(:view).to_px(:width)
  #
  # grab(:view).on(:resize) do |ev|
  #   width = ev[:width].to_i
  #   height = ev[:height].to_i
  #   update_design(width, height)
  # end
  #
  #
end

Vie.new

# svg_content = <<SVG
# <svg class="svg-icon" style="width: 1em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;"
# 	 viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg">
#   <path id="path" fill="rgb(206, 206, 206)" d="M281.6 137.813333a128 128 0 0 0-128 128v469.333334a128 128 0 0 0 128 128h213.333333a42.666667 42.666667 0 1 0 0-85.333334h-213.333333a42.666667 42.666667 0 0 1-42.666667-42.666666v-469.333334a42.666667 42.666667 0 0 1 42.666667-42.666666h469.333333a42.666667 42.666667 0 0 1 42.666667 42.666666v213.333334a42.666667 42.666667 0 1 0 85.333333 0v-213.333334a128 128 0 0 0-128-128h-469.333333z m294.613333 380.544l42.154667 365.184a21.333333 21.333333 0 0 0 38.357333 10.24l80.213334-108.629333 114.048 169.941333a42.666667 42.666667 0 1 0 70.826666-47.573333l-114.048-169.941333 124.416-36.693334a21.333333 21.333333 0 0 0 3.498667-39.552l-328.746667-164.522666a21.333333 21.333333 0 0 0-30.72 21.546666z"/>
# </svg>
# SVG
# normalized_svg = A.normalise_svg(svg_content)
# puts normalized_svg# # frozen_string_literal: true
#
# # patch to hide native toolbox
# grab(:toolbox_tool).display(false)
#
# class Vie
#   attr_accessor :current_orientation, :basic_objects, :current_matrix
#
#   def initialize
#     super
#     @basic_objects = []
#     @current_orientation = nil
#
#     height_found = grab(:view).to_px(:height)
#     width_found = grab(:view).to_px(:width)
#
#
#     basic_objects
#     init_design(width_found, height_found)
#     basic_tool
#
#
#     grab(:view).on(:resize) do |ev|
#       width = ev[:width].to_i
#       height = ev[:height].to_i
#       update_design(width, height)
#     end
#   end
#
#   def basic_tool
#     vie_tool_builder({ attach: :action_bar, tools: [:select_tool, :copy_tool, :paste_tool, :undo_tool, :redo_tool] })
#     vie_tool_builder({ attach: :tool_bar, tools: [:file_tool, :module_tool] })
#   end
#
#   def basic_creator(id)
#     @basic_objects << id
#     box({ id: id, display: false, color: vie_colors[id] })
#   end
#
#   def basic_objects
#     element({ id: :vie, data: { current_matrix: :vie_0, context: :none, selected: [] } })
#     shadow({
#              id: :standard_shadow,
#              left: 0, top: 0, blur: 9,
#              invert: false,
#              red: 0, green: 0, blue: 0, alpha: 0.6
#            })
#     shadow({
#              id: :invert_shadow,
#              left: -3, top: 3, blur: 9,
#              invert: true,
#              red: 0, green: 0, blue: 0, alpha: 0.6
#            })
#
#     @current_matrix = grab(:vie).data[:current_matrix]
#
#     # Basic design
#     basic_creator(:work_zone)
#     basic_creator(:inspector)
#     basic_creator(:title_bar)
#     basic_creator(:tool_bar)
#     basic_creator(:action_bar)
#
#     # special treatment
#     grab(:inspector).apply([:invert_shadow])
#
#     # matrix
#     main_matrix = grab(:work_zone).matrix({ id: @current_matrix, rows: 8, columns: 8, spacing: 9, size: 333 })
#
#     matrix_content = main_matrix.cells
#     matrix_content.color(vie_colors[:cells])
#     matrix_content.smooth(6)
#     matrix_content.apply([:standard_shadow])
#
#     # basic elements
#     grab(:title_bar).input({
#                              trigger: :return,
#                              back: { alpha: 0 },
#                              component: { size: 16 },
#                              text: { color: vie_colors[:titles], left: vie_size[:margin], top: 3, align: :center },
#                              smooth: 3,
#                              height: 23,
#                              width: vie_size[:panel],
#                              id: :project_title,
#                              default: 'Untitled',
#                              center: true
#                            }) do |val|
#       puts "validated: #{val}"
#     end
#     grab(:title_bar).image({ id: :vie_logo, path: "./medias/images/logos/vie.svg", left: vie_size[:margin], top: vie_size[:margin] / 3, size: 27 })
#
#     # menu.image({ path: 'medias/images/icons/menu.svg', id: :menu_icon, width: vie_size[:icon_size],
#     #              height: vie_size[:icon_size], center: true })
#     # edit = title_bar.box({ id: :edit, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: :auto,
#     #                      }.merge(vie_style[:buttons]))
#     # edit.image({ path: 'medias/images/icons/edit.svg', id: :edit_icon, width: vie_size[:icon_size],
#     #              height: vie_size[:icon_size], center: true })
#     # perform = title_bar.box({ id: :perform, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: :auto,
#     #                         }.merge(vie_style[:buttons]))
#     # perform.image({ path: 'medias/images/icons/play.svg', id: :perform_icon, width: vie_size[:icon_size],
#     #                 height: vie_size[:icon_size], center: true })
#     #
#     # sequence = title_bar.box({ id: :sequence, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: :auto,
#     #                          }.merge(vie_style[:buttons]))
#     # sequence.image({ path: 'medias/images/icons/sequence.svg', id: :sequence_icon, width: vie_size[:icon_size],
#     #                  height: vie_size[:icon_size], center: true })
#     # mix = title_bar.box({ id: :mix, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: :auto,
#     #                     }.merge(vie_style[:buttons]))
#     # mix.image({ path: 'medias/images/icons/mixer.svg', id: :mix_icon, width: vie_size[:icon_size],
#     #             height: vie_size[:icon_size], center: true })
#     #
#     # toolbox = title_bar.box({ id: :toolbox, width: :auto, height: 33, top: 0, bottom: 0, left: after(:menu),
#     #                           right: before(mix), overflow: :auto, color: { alpha: 0 } })
#     #
#     # # module_tool = toolbox.box({id: :module_tool,  width: 33, height: 33, top: 0, bottom: 0, left: vie_size[:margin], center: { y: 0 }, color: { alpha: 0.18 } })
#     # # module_tool.image(path: 'medias/images/icons/module.svg', width: 22, height: 22, center: true, opacity: 0.6)
#     # #
#     # # select_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(:module_tool), center: { y: 0 }, color: { alpha: 0.18 } })
#     # # select_tool.image(path: 'medias/images/icons/select.svg', width: 22, height: 22, center: true, opacity: 0.6)
#     # #
#     # # link_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(select_tool), center: { y: 0 }, color: { alpha: 0.18 } })
#     # # link_tool.image(path: 'medias/images/icons/link.svg', width: 22, height: 22, center: true, opacity: 0.6)
#     # #
#     # # delete_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(link_tool), center: { y: 0 }, color: { alpha: 0.18 } })
#     # # delete_tool.image(path: 'medias/images/icons/delete.svg', width: 22, height: 22, center: true, opacity: 0.6)
#     # #
#     # # copy_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(delete_tool), center: { y: 0 }, color: { alpha: 0.18 } })
#     # # copy_tool.image(path: 'medias/images/icons/copy.svg', width: 22, height: 22, center: true, opacity: 0.6)
#     # #
#     # # paste_tool = toolbox.box({ width: 33, height: 33, top: 0, bottom: 0, left: after(copy_tool), center: { y: 0 }, color: { alpha: 0.18 } })
#     # # paste_tool.image(path: 'medias/images/icons/paste.svg', width: 22, height: 22, center: true, opacity: 0.6)
#     # #
#     # # undo_tool = toolbox.box({id: :undo_support, width: 33, height: 33, top: 0, bottom: 0, left: after(paste_tool), center: { y: 0 }, color: { alpha: 0.18 } })
#     # # undo_tool.image(path: 'medias/images/icons/undo.svg', width: 22, height: 22, center: true, opacity: 0.6)
#
#     def vie_tool_builder(params)
#
#       attach_f = params[:attach]
#       tools_list_f = params[:tools]
#       centering = {}
#       parent_f = grab(attach_f)
#       width_found = parent_f.to_px(:width)
#       height_found = parent_f.to_px(:height)
#       parent_orientation = width_found > height_found ? :horizontal : :vertical
#
#       tools_list_f.each_with_index do |tool_id, index|
#         if index == 0 && parent_orientation == :vertical
#           top_f = 0
#           centering = { x: 0 }
#         elsif index == 0 && parent_orientation == :horizontal
#           left_f = 0
#           centering = { y: 0 }
#         elsif parent_orientation == :vertical
#           top_f = below(tools_list_f[index - 1])
#           centering = { x: 0 }
#         elsif parent_orientation == :horizontal
#           centering = { y: 0 }
#         end
#         new_tool = grab(attach_f).box({ width: vie_size[:tool_size], height: vie_size[:tool_size],
#                                         top: top_f, bottom: 0, left: left_f, right: 0, center: centering, color: { alpha: 0 },
#                                         apply: :standard_shadow, id: tool_id })
#         svg_name = tool_id.to_s.sub('_tool', '')
#         temp_icon = "#{tool_id}_icon_tmp"
#         grab(:black_matter).image(id: temp_icon, path: "medias/images/icons/#{svg_name}.svg", width: 22, height: 22, center: true, opacity: 0.6)
#         new_tool.vector({ width: 33, height: 33, id: "#{tool_id}_icon" })
#         A.svg_to_vector({ source: "#{tool_id}_icon_tmp", target: "#{tool_id}_icon", normalize: true }) do |params|
#
#           new_svg = grab(params[:target])
#           new_svg.color(:orange)
#           new_svg.width(21)
#           new_svg.height(21)
#           new_svg.center(true)
#
#         end
#
#         # img.touch(true) do
#         #   img.alternate({color: :red, shadow: { alpha:  1 }, blur: 3 }, {color: :green,  shadow: false })
#         # end
#       end
#       # grab(:black_matter).clear(true)
#
#       # grab(:black_matter).image(id: id_f, path: "medias/images/icons/#{id_f}.svg", width: 22, height: 22, center: true, opacity: 0.6)
#       # new_svg=new_tool.vector({ width: 33, height: 33, id: :my_placeholder })
#       # A.svg_to_vector({ source: :redo, target: :my_placeholder }) do
#       #   new_svg.color(:orange)
#       #   grab(:atomic_logo).delete(true)
#       # end
#       # img.touch(true) do
#       #   img.alternate({color: :red, shadow: { alpha:  1 }, blur: 3 }, {color: :green,  shadow: false })
#       # end
#     end
#
#     #
#     # file_tool = title_bar.box({ id: :file_tool, width: :auto, height: 33, top: 0, bottom: 0, left: after(menu),
#     #                             right: before(mix), overflow: :auto, color: { alpha: 0 } })
#     # file_tool.display(false)
#     #
#     # # load = file_tool.box({ id: :load, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: vie_size[:margin],
#     # #                        top: vie_size[:margin] }.merge(vie_style[:buttons]))
#     # # load.image({ path: 'medias/images/icons/load.svg', id: :load_icon, width: vie_size[:icon_size],
#     # #              height: vie_size[:icon_size], center: true })
#     # #
#     # # new = file_tool.box({ id: :new, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons], left: after(load),
#     # #                       top: vie_size[:margin] }.merge(vie_style[:buttons]))
#     # # new.image({ path: 'medias/images/icons/new.svg', id: :new_icon, width: vie_size[:icon_size],
#     # #             height: vie_size[:icon_size], center: true })
#     # #
#     # # import = file_tool.box({ id: :import, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons],
#     # #                          left: after(new), top: vie_size[:margin] }.merge(vie_style[:buttons]))
#     # # import.image({ path: 'medias/images/icons/save.svg', id: :import_icon, width: vie_size[:icon_size],
#     # #                height: vie_size[:icon_size], center: true })
#     # #
#     # # export = file_tool.box({ id: :export, smooth: 3, height: vie_size[:buttons], width: vie_size[:buttons],
#     # #                          left: after(import), top: vie_size[:margin] }.merge(vie_style[:buttons]))
#     # # export.image({ path: 'medias/images/icons/save.svg', id: :export_icon, width: vie_size[:icon_size],
#     # #                height: vie_size[:icon_size], center: true, rotate: 180 })
#   end
#
#   def list_project(listing, projects)
#     projects.each_with_index do |project_name, index|
#       project = listing.text({ data: project_name, top: index })
#       project.touch(true) do
#         grab(:inspector).text(project_name)
#       end
#     end
#   end
#
#   # styles
#   def vie_size
#     {
#       icon_size: 15,
#       buttons: 25,
#       basic: 18,
#       title_width: 50,
#       title_height: 30,
#       tool_size: 30,
#       basic_size: 39,
#       basic_width: 39,
#       basic_height: 39,
#       panel: 120,
#       inspector: 192,
#       margin: 12,
#       # utils_width: 190,
#       matrix_min: 192
#     }
#   end
#
#   def vie_colors
#     {
#       cells: { red: 0.6, green: 0.3, blue: 0.09, alpha: 1 },
#       action_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
#       title_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
#       inspector: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
#       work_zone: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
#       tool_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
#       titles: { red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }
#     }
#   end
#
#   # def vie_colors
#   #   {
#   #     cells: { red: 0.19, green: 0.19, blue: 0.19, alpha: 1 },
#   #     action_bar: :red,
#   #     # work: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
#   #     title_bar: :green,
#   #     inspector: :blue,
#   #     work_zone: :black,
#   #     tool_bar: :pink
#   #   }
#   # end
#
#   def vie_style_horizontal
#     {
#       title_bar: { depth: 1, height: vie_size[:basic_size],
#                    # color: vie_colors[:background],
#                    # color: :red,
#                    width: '100%' },
#       action_bar: { depth: 1, height: :auto, width: vie_size[:basic_size], left: :auto, right: 0,
#                     top: vie_size[:basic_size], bottom: 0,
#                     # color: vie_colors[:background],
#                     # color: :pink,
#       },
#       tool_bar: { depth: 1,
#                   # color: vie_colors[:background],
#                   width: vie_size[:basic_size], height: :auto, left: 0, top: vie_size[:basic_size], bottom: 0,
#                   # color: :yellow,
#
#       },
#
#       inspector: { depth: 2, overflow: :auto,
#                    # color: vie_colors[:background],
#                    # color: {alpha: 0.2},
#                    width: vie_size[:inspector], height: :auto, left: vie_size[:basic_size], top: vie_size[:basic_size],
#                    bottom: vie_size[:margin] },
#       work_zone: { overflow: :auto, depth: 0, width: :auto, height: :auto,
#                    # color: vie_colors[:background],
#                    # color: :blue,
#                    left: vie_size[:inspector] + vie_size[:basic_size], top: vie_size[:basic_size], bottom: 0, right: vie_size[:basic_size] }
#     }
#   end
#
#   def vie_style_vertical
#     {
#       title_bar: { depth: 1, height: vie_size[:basic_size],
#                    # color: vie_colors[:background],
#                    # color: :red,
#                    width: '100%' },
#       action_bar: { depth: 1, height: vie_size[:basic_size], width: '100%', left: 0, right: 0,
#                     top: :auto, bottom: 0,
#                     # color: vie_colors[:background],
#                     # color: :pink,
#       },
#       tool_bar: { depth: 1,
#                   # color: vie_colors[:background],
#                   height: vie_size[:basic_size], width: :auto, left: 0, right: 0,
#                   top: :auto, bottom: vie_size[:basic_size],
#                   # color: :yellow,
#       },
#
#       inspector: { depth: 2, overflow: :auto,
#                    # color: vie_colors[:background],
#                    # color: :green,
#                    width: :auto,
#                    height: vie_size[:inspector], left: vie_size[:margin], right: vie_size[:margin],
#                    top: :auto, bottom: vie_size[:basic_size] * 2,
#       },
#       work_zone: { overflow: :auto, depth: 0, width: :auto, height: :auto,
#                    # color: vie_colors[:background],
#                    # color: :blue,
#                    left: 0, top: vie_size[:basic_size], bottom: vie_size[:basic_size] * 2 + vie_size[:inspector], right: 0 }
#     }
#   end
#
#   def vertical_design
#     @basic_objects.each do |elem|
#       grab(elem).set(vie_style_vertical[elem])
#
#     end
#     # grab(:work_zone).set(vie_style_vertical[:work_zone])
#     # grab(:inspector).set(vie_style_vertical[:inspector])
#     # grab(:title_bar).set(vie_style_vertical[:title_bar])
#     # grab(:tool_bar).set(vie_style_vertical[:tool_bar])
#     # grab(:action_bar).set(vie_style_vertical[:action_bar])
#   end
#
#   def horizontal_design
#     @basic_objects.each do |elem|
#       grab(elem).set(vie_style_horizontal[elem])
#     end
#     # grab(:work_zone).set(vie_style_horizontal[:work_zone])
#     # grab(:inspector).set(vie_style_horizontal[:inspector])
#     # grab(:title_bar).set(vie_style_horizontal[:title_bar])
#     # grab(:tool_bar).set(vie_style_horizontal[:tool_bar])
#     # grab(:action_bar).set(vie_style_horizontal[:action_bar])
#   end
#
#   # utils
#
#   def set_orientation(orientation)
#     if orientation == :horizontal
#       horizontal_design
#     else
#       vertical_design
#     end
#   end
#
#   def init_design(width_found, height_found)
#     new_orientation = width_found > height_found ? :horizontal : :vertical
#     @current_orientation = new_orientation
#     current_matrix_background = grab(@current_matrix)
#
#     set_orientation(new_orientation)
#     @basic_objects.each do |elem|
#       grab(elem).display(true)
#     end
#
#     work_zone_width = grab(:work_zone).to_px(:width)
#     work_zone_height = grab(:work_zone).to_px(:height)
#
#     if work_zone_width < work_zone_height
#       size = work_zone_width - 30
#     else
#       size = work_zone_height - 30
#     end
#     current_matrix_background.resize_matrix({ width: size, height: size })
#
#     current_matrix_background.center(true)
#     grab(:project_title).center(true)
#
#   end
#
#   def update_design(width_found, height_found)
#     new_orientation = width_found > height_found ? :horizontal : :vertical
#     @current_orientation = new_orientation
#     current_matrix_background = grab(@current_matrix)
#
#     set_orientation(new_orientation)
#     @basic_objects.each do |elem|
#       grab(elem).display(true)
#     end
#
#     work_zone_width = grab(:work_zone).to_px(:width)
#     work_zone_height = grab(:work_zone).to_px(:height)
#
#     if work_zone_width < work_zone_height
#       size = work_zone_width - vie_size[:basic_size]
#     else
#       size = work_zone_height - vie_size[:basic_size]
#     end
#     current_matrix_background.resize_matrix({ width: size, height: size })
#
#     # current_matrix_background.center(true)
#     # grab(:project_title).center(true)
#
#   end
#
#   #
#   # # def refresh_design
#   # #   title_bar = grab(:title_bar)
#   # #   panel = grab(:panel)
#   # #   inspector = grab(:inspector)
#   # #   work_zone = grab(:work_zone)
#   # #   menu = grab(:menu)
#   # #   project_title = grab(:project_title)
#   # #   edit = grab(:edit)
#   # #   perform = grab(:perform)
#   # #   sequence = grab(:sequence)
#   # #   mix = grab(:mix)
#   # #   toolbox = grab(:toolbox)
#   # #   file_tool = grab(:file_tool)
#   # #   case grab(:design_mode).data[:active_mode]
#   # #   when :mode_vertical_alt
#   # #     title_bar.set({ width: :auto, height: (vie_size[:title_height] * 2), top: 0, bottom: 0, left: 0,
#   # #                     right: 0, depth: 3 })
#   # #
#   # #     panel.set({ width: :auto, height: vie_size[:panel], top: :auto, left: 0, bottom: 0, right: 0, depth: 3 })
#   # #     inspector.set({ width: :auto, height: vie_size[:inspector], bottom: above(panel),
#   # #                     top: :auto, left: 0, right: 0, depth: 7 })
#   # #
#   # #     work_zone.set({ width: :auto, height: :auto, top: below(title_bar), bottom: above(inspector),
#   # #                     left: 0, right: 0, depth: 3 })
#   # #
#   # #     project_title.set({ left: 0, top: 0 })
#   # #
#   # #     menu.set({ top: vie_size[:margin], left: 0 })
#   # #
#   # #     edit.set({ top: vie_size[:margin], left: :auto, right: vie_size[:margin] })
#   # #     perform.set({ top: vie_size[:margin], right: before(edit) })
#   # #     sequence.set({ top: vie_size[:margin], right: before(perform) })
#   # #     mix.set({ top: vie_size[:margin], right: before(sequence) })
#   # #     toolbox.set({ top: :auto, bottom: vie_size[:margin], left: 0, right: vie_size[:margin] })
#   # #     file_tool.set({ top: :auto, bottom: vie_size[:margin], left: 0, right: vie_size[:margin] })
#   # #   when :mode_horizontal_alt
#   # #
#   # #     title_bar.set({ width: :auto, height: vie_size[:title_height], top: 0, bottom: 0, left: 0,
#   # #                     right: 0, depth: 3 })
#   # #     inspector.set({ width: :auto, height: vie_size[:inspector], bottom: 0,
#   # #                     top: :auto, left: 0, right: 0, depth: 7 })
#   # #
#   # #     panel.set({ width: vie_size[:panel], height: :auto, top: below(title_bar), bottom: above(inspector), left: 0, depth: 3 })
#   # #
#   # #     work_zone.set({ width: :auto, height: :auto, top: below(title_bar), bottom: above(inspector),
#   # #                     left: after(:panel), right: 0, depth: 3 })
#   # #
#   # #     project_title.set({ left: 0, top: 0 })
#   # #
#   # #     menu.set({ center: { y: 0 }, left: 0 })
#   # #
#   # #     edit.set({ center: { y: 0 }, left: :auto, right: vie_size[:margin] })
#   # #
#   # #     perform.set({ center: { y: 0 }, right: before(edit) })
#   # #     sequence.set({ center: { y: 0 }, right: before(perform) })
#   # #     mix.set({ center: { y: 0 }, right: before(sequence) })
#   # #     toolbox.set({ top: 0, left: after(:menu), right: before(mix) })
#   # #     file_tool.set({ top: 0, left: after(:menu), right: before(mix) })
#   # #   else
#   # #     # nothing for now
#   # #   end
#   # #
#   # # end
#   #
#
#   #
#   # # # logo
#   # #
#   # # # events
#   # # class Atome
#   # #   def flash(values)
#   # #
#   # #     duration = values[:duration]
#   # #     duration ||= 1
#   # #
#   # #     color(:orange)
#   # #     wait duration do
#   # #       color(vie_colors[:buttons])
#   # #     end
#   # #   end
#   # #
#   # #   def vie_toggle(value = true, &proc)
#   # #     touch(value) do
#   # #       proc.call if proc.instance_of? Proc
#   # #       flash({ apply: [:action_color], blur: 3, duration: 0.1 })
#   # #     end
#   # #   end
#   # #
#   # #   def vie_momentary(value = true, &proc)
#   # #     touch(value) do
#   # #       proc.call if proc.instance_of? Proc
#   # #       alternate({ color: :red, shadow: { alpha: 1, id: :toto }, blur: 3 }, { color: :green })
#   # #     end
#   # #   end
#   # # end
#   # #
#   # # # menu action
#   # # color({ red: 1, id: :color1 })
#   # # menu.vie_toggle(:down) do
#   # #   a = menu.tick(:menu)
#   # #   if a.%(2) == 1
#   # #     grab(:title_bar).color({ alpha: 0.3 })
#   # #     file_tool.display(true)
#   # #     toolbox.display(false)
#   # #     menu.opacity(1)
#   # #     grab(:menu_icon).path('medias/images/icons/menu.svg')
#   # #     menu.rotate(90)
#   # #   else
#   # #     grab(:menu_icon).path('medias/images/icons/open_menu.svg')
#   # #     grab(:title_bar).color({ alpha: 0 })
#   # #     # menu.rotate(0)
#   # #     menu.opacity(0.5)
#   # #     toolbox.display(true)
#   # #     file_tool.display(false)
#   # #   end
#   # # end
#   # #
#   # # # view action
#   # # edit.vie_toggle do
#   # #   current_matrix = grab(:vie).data[:current_matrix]
#   # #   current_matrix.display(true)
#   # # end
#   # # perform.vie_toggle do
#   # #   current_matrix = grab(:vie).data[:current_matrix]
#   # #   current_matrix.display(false)
#   # # end
#   # # sequence.vie_toggle do
#   # #   current_matrix = grab(:vie).data[:current_matrix]
#   # #   current_matrix.display(false)
#   # # end
#   # # mix.vie_toggle do
#   # #   current_matrix = grab(:vie).data[:current_matrix]
#   # #   current_matrix.display(false)
#   # # end
#   # #
#   # # # tool action
#   # #
#   # # # module_tool.vie_toggle
#   # # # select_tool.vie_toggle
#   # # # link_tool.vie_toggle
#   # # # delete_tool.vie_toggle
#   # # # copy_tool.vie_toggle
#   # # # paste_tool.vie_toggle
#   # # # undo_tool.vie_toggle
#   # #
#   # # #################
#   # # def build_tool(params, &proc)
#   # #   left_f = params[:left] ||= 0
#   # #   top_f = params[:top] ||= 0
#   # #   parent = grab(params[:parent] ||= :view)
#   # #   tool_name = params[:name] || :new
#   # #   temp_image="#{tool_name}_temp"
#   # #   new_tool_support = parent.box({ id: "#{tool_name}_support", width: 33, height: 33, top: top_f, bottom: 0, left: left_f, center: { y: 0 }, color: { alpha: 0.18 } })
#   # #   grab(:black_matter).image(id: temp_image, path: "medias/images/icons/#{tool_name}.svg", width: 22, height: 22, center: true, opacity: 0.6)
#   # #   new_tool = new_tool_support.vector({ width: 33, height: 33, id: tool_name})
#   # #   A.svg_to_vector({ source: temp_image, target: tool_name }) do
#   # #     new_tool.color(:orange)
#   # #     grab(temp_image).delete(true)
#   # #   end
#   # #   if params[:toggle]
#   # #     new_tool_support.vie_toggle(true, &proc)
#   # #
#   # #   else
#   # #     new_tool_support.vie_momentary(true, &proc)
#   # #   end
#   # # end
#   # #
#   # # build_tool({ name: :clear, parent: :toolbox, left: after(:undo_support), toggle: true }) do
#   # #   puts 'message send : hello!'
#   # # end
#   # #
#   # # #################
#   # matrix_content.over(:enter) do |event|
#   #   if grab(:vie).data[:context] == :mouse_down
#   #     current_cell = grab(event[:target][:id].to_s)
#   #     current_cell.color(:green)
#   #     grab(:vie).data[:selected] << current_cell
#   #   end
#   #
#   # end
#   # matrix_content.touch(:down) do |event|
#   #   grab(:vie).data[:context] = :mouse_down
#   #   current_cell = grab(event[:target][:id].to_s)
#   #   grab(:vie).data[:selected] << current_cell
#   #   current_cell.color(:green)
#   # end
#   #
#   # matrix_content.touch(:up) do |event|
#   #   grab(:vie).data[:context] = :none
#   #   current_cell = grab(event[:target][:id].to_s)
#   #   if current_cell.selected
#   #     current_cell.color(vie_colors[:cells])
#   #     current_cell.selected(false)
#   #   else
#   #     current_cell.color(:orange)
#   #     current_cell.selected(true)
#   #   end
#   # end
#   #
#   # matrix_content.touch(:double) do |event|
#   #   current_cell = grab(event[:target][:id].to_s)
#   #   current_cell.color(:red)
#   # end
#   #
#   #
#   #
#   #
#   # #
#   # # # initialise the design
#   # # initial_width = grab(:view).to_px(:width)
#   # # initial_height = grab(:view).to_px(:height)
#   # # grab(:design_mode).data[:active_mode] = if initial_width > initial_height
#   # #                                           grab(:design_mode).data[:landscape]
#   # #                                         else
#   # #                                           grab(:design_mode).data[:portrait]
#   # #                                         end
#   # #
#   # # height_found = work_zone.to_px(:height)
#   # # min_matrix_size = vie_size[:matrix_min]
#   # # height_found = if height_found > min_matrix_size
#   # #                  height_found
#   # #                else
#   # #                  min_matrix_size
#   # #                end
#   # # main_matrix.resize_matrix({ width: height_found, height: height_found })
#   # #
#   # # module_tool.touch(true) do
#   # #   if grab(:projects_list)
#   # #     grab(:projects_list).delete(true)
#   # #   else
#   # #     choices = grab(:choices)
#   # #     listing = choices.box({ id: :projects_list, left: 6, top: 0, color: { alpha: 0 } })
#   # #
#   # #     projects = %i[demo1 my_project other_1 demo1 my_project other_1 demo1 my_project other_1 demo1
#   # #                 my_project other_1 demo1 my_project other_1]
#   # #     list_project(listing, projects)
#   # #   end
#   # #
#   # # end
#   # #
#   # # def init_design
#   # #   view = grab(:view)
#   # #   height_found = view.to_px(:height)
#   # #   main_matrix = grab(:vie).data[:current_matrix]
#   # #   refresh_design
#   # #   main_matrix.resize_matrix({ width: height_found, height: height_found })
#   # # end
#   # #
#   # # init_design
#   # # refresh_design
#   #
#   # # def design_chooser
#   # #
#   # # end
#   #
#   # # grab(:view).on(:resize) do |ev|
#   # #   # mode_found =
#   # #   if ev[:width].to_i > ev[:height].to_i
#   # #     horizontal_design
#   # #     # grab(:design_mode).data[:landscape]
#   # #   else
#   # #     vertical_design
#   # #     # grab(:design_mode).data[:portrait]
#   # #   end
#   # #   #
#   # #   # if mode_found != grab(:design_mode).data[:active_mode]
#   # #   #   grab(:design_mode).data[:active_mode] = mode_found
#   # #   #   refresh_design
#   # #   # end
#   # #   # height_found = work_zone.to_px(:height)
#   # #   # min_matrix_size = vie_size[:matrix_min]
#   # #   # height_found = if height_found > min_matrix_size
#   # #   #                  height_found
#   # #   #                else
#   # #   #                  min_matrix_size
#   # #   #                end
#   # #   # main_matrix.resize_matrix({ width: height_found, height: height_found })
#   # # end
#   #
#   #
#   # height= grab(:view).to_px(:height)
#   # width=grab(:view).to_px(:width)
#   #
#   # grab(:view).on(:resize) do |ev|
#   #   width = ev[:width].to_i
#   #   height = ev[:height].to_i
#   #   update_design(width, height)
#   # end
#   #
#   #
# end
#
# Vie.new
#
# svg_content = <<SVG
# <svg class="svg-icon" style="width: 1em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;"
#      viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><g transform="translate(0, 0) scale(1)">
#   <path id="path" fill="rgb(206, 206, 206)" d="M281.6 137.813333a128 128 0 0 0-128 128v469.333334a128 128 0 0 0 128 128h213.333333a42.666667 42.666667 0 1 0 0-85.333334h-213.333333a42.666667 42.666667 0 0 1-42.666667-42.666666v-469.333334a42.666667 42.666667 0 0 1 42.666667-42.666666h469.333333a42.666667 42.666667 0 0 1 42.666667 42.666666v213.333334a42.666667 42.666667 0 1 0 85.333333 0v-213.333334a128 128 0 0 0-128-128h-469.333333z m294.613333 380.544l42.154667 365.184a21.333333 21.333333 0 0 0 38.357333 10.24l80.213334-108.629333 114.048 169.941333a42.666667 42.666667 0 1 0 70.826666-47.573333l-114.048-169.941333 124.416-36.693334a21.333333 21.333333 0 0 0 3.498667-39.552l-328.746667-164.522666a21.333333 21.333333 0 0 0-30.72 21.546666z"/>
# </g></svg>
# SVG
# normalized_svg = A.normalise_svg(svg_content)
# puts normalized_svg
