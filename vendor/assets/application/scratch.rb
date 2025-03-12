wait 2 do
  # @basic_objects=[]
  # shadow({
  #          id: :basic_shadow,
  #          left: 0, top: 0, blur: 6,
  #          invert: false,
  #          red: 0, green: 0, blue: 0, alpha: 0.3
  #        })
  # def basic_creator(id)
  #   @basic_objects << id
  #   box({ id: id, display: false, color: :red, drag: true })
  # end
  #
  # basic_creator(:work_zone)
  # @current_matrix=:the_matrix
  #
  # matrix({ id: @current_matrix, rows: 8, columns: 8, spacing: 3, size: 333 })
  # current_matrix=grab(@current_matrix)
  # current_matrix.attach(:work_zone)
  # matrix_content = current_matrix.cells
  # matrix_content.color(:blue)
  # matrix_content.smooth(3)
  # matrix_content.apply([:basic_shadow])
  #
  #   grab(:work_zone).display(true)
  #
  # current_matrix.resize_matrix({ width: 333, height: 333 })
  # current_matrix.left(234)

  # frozen_string_literal: true

  # patch to hide native toolbox
  grab(:toolbox_tool).display(false)

  class Atome
    # # FixMe Patch below when centering a matrix
    # def x(_val = nil) end
    #
    # def y(_val = nil) end
    #
    # def dynamic(_val = nil) end

    # addition helpers methods
    def above(item)
      pos = item.to_px(:bottom) + item.height + vie_size[:margin]
      if item.display == :none
        33
      else
        pos
      end
    end

    def below(item)
      pos = item.to_px(:top) + item.to_px(:height) + vie_size[:margin]
      if item.display == :none
        0
      else
        pos
      end

    end

    def after(item_id)
      item = grab(item_id)
      unless item
        item = item_id
      end
      left_f = if item.left.instance_of?(Integer)
                 item.left
               else
                 item.to_px(:left)
               end

      width_f = if item.width.instance_of?(Integer)
                  item.width
                else
                  item.to_px(:width)
                end
      pos = left_f + width_f + vie_size[:margin]
      if item.display == :none
        0
      else
        pos
      end
    end

    def before(item)
      pos = item.to_px(:right) + item.width + vie_size[:margin]
      if item.display == :none
        0
      else
        pos
      end
    end
  end

  shadow({
           id: :basic_shadow,
           left: 0, top: 0, blur: 6,
           invert: false,
           red: 0, green: 0, blue: 0, alpha: 0.3
         })

  class Vie
    attr_accessor :current_orientation, :basic_objects, :current_matrix

    def initialize
      super
      @basic_objects = []

      height_found = grab(:view).to_px(:height)
      width_found = grab(:view).to_px(:width)

      basic_objects
      init_design(width_found, height_found)
      # update_design(width, height, main_matrix)
    end

    def basic_creator(id)
      @basic_objects << id
      box({ id: id, display: false, color: vie_colors[id], drag: true })
    end

    def basic_objects
      # element({ id: :design_mode, data: { active_mode: :mode_vertical_alt, portrait: :mode_vertical_alt, landscape: :mode_horizontal_alt } })
      element({ id: :vie, data: { current_matrix: :vie_0, context: :none, selected: [] } })
      @current_matrix = grab(:vie).data[:current_matrix]
      # alert  @current_matrix
      # Basic design
      basic_creator(:work_zone)
      basic_creator(:inspector)
      basic_creator(:title_bar)
      basic_creator(:tool_bar)
      basic_creator(:action_bar)

      # matrix
      # we attach to black to preserve size but prevent display
      main_matrix = matrix({ id: @current_matrix, rows: 8, columns: 8, spacing: 3, size: 333 })
      matrix_content = main_matrix.cells
      matrix_content.color(vie_colors[:cells])
      matrix_content.smooth(3)
      matrix_content.apply([:basic_shadow])
      # main_matrix.display(false)
      #############  test
      # current_matrix= grab(@current_matrix)
      # alert   main_matrix.id
      # alert   current_matrix.id
      # current_matrix.resize_matrix({ width: 333, height: 333 })
      # current_matrix.center(true)

      ###### end test

      # basic elements
      grab(:title_bar).input({
                               trigger: :return,
                               back: { alpha: 0 },
                               component: { size: 16 },
                               text: { color: { red: 0.7, green: 0.7, blue: 0.7 }, left: vie_size[:margin], top: 3, align: :center },
                               smooth: 3,
                               height: 23,
                               width: vie_size[:panel],
                               id: :project_title,
                               default: 'untitled',
                               center: true
                             }) do |val|
        puts "validated: #{val}"
      end
      grab(:title_bar).image({ id: :vie_logo, path: "./medias/images/logos/vie.svg", left: vie_size[:margin], top: vie_size[:margin], size: 27 })

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
      # # redo_tool = toolbox.box({width: 33, height: 33, top: 0, bottom: 0, left: after(undo_tool), center: { y: 0 }, color: { alpha: 0.18 } })
      # # grab(:black_matter).image(id: :redo, path: 'medias/images/icons/redo.svg', width: 22, height: 22, center: true, opacity: 0.6)
      # # # img=redo_tool.vector({ width: 33, height: 33, id: :my_placeholder })
      # # # A.svg_to_vector({ source: :redo, target: :my_placeholder }) do
      # # #   img.color(:orange)
      # # #   grab(:atomic_logo).delete(true)
      # # # end
      # # # img.touch(true) do
      # # #   img.alternate({color: :red, shadow: { alpha:  1 }, blur: 3 }, {color: :green,  shadow: false })
      # # # end
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
        title_height: 33,
        basic_size: 33,
        basic_width: 50,
        basic_height: 33,
        panel: 120,
        inspector: 192,
        margin: 3,
        # utils_width: 190,
        matrix_min: 192
      }
    end

    # def vie_colors
    #   {
    #     cells: { red: 0.19, green: 0.19, blue: 0.19, alpha: 1 },
    #     action_bar: { red: 0.1, green: 0.15, blue: 0.15, alpha: 0 },
    #     # work: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
    #     title_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
    #     inspector: { red: 0.12, green: 0.12, blue: 0.12, alpha: 1 },
    #     work_zone: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
    #     tool_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 0 }
    #   }
    # end

    def vie_colors
      {
        cells: { red: 0.19, green: 0.19, blue: 0.19, alpha: 1 },
        action_bar: :red,
        # work: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
        title_bar: :green,
        inspector: :blue,
        work_zone: :black,
        tool_bar: :pink
      }
    end

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
                     width: vie_size[:inspector], height: :auto, left: vie_size[:basic_size], top: vie_size[:basic_size], bottom: 0 },
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
                     height: vie_size[:inspector], left: 0, right: 0,
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
      # grab(:work_zone).set(vie_style_vertical[:work_zone])
      # grab(:inspector).set(vie_style_vertical[:inspector])
      # grab(:title_bar).set(vie_style_vertical[:title_bar])
      # grab(:tool_bar).set(vie_style_vertical[:tool_bar])
      # grab(:action_bar).set(vie_style_vertical[:action_bar])
    end

    def horizontal_design
      @basic_objects.each do |elem|
        grab(elem).set(vie_style_horizontal[elem])
      end
      # grab(:work_zone).set(vie_style_horizontal[:work_zone])
      # grab(:inspector).set(vie_style_horizontal[:inspector])
      # grab(:title_bar).set(vie_style_horizontal[:title_bar])
      # grab(:tool_bar).set(vie_style_horizontal[:tool_bar])
      # grab(:action_bar).set(vie_style_horizontal[:action_bar])
    end

    # utils

    def set_orientation(orientation)
      wait 0 do
        # FIXME find why we have  to add a wait to make it works, else the design is broken
        if orientation == :horizontal
          horizontal_design
        else
          vertical_design
        end
      end
    end

    def init_design(width_found, height_found)
      new_orientation = width_found > height_found ? :horizontal : :vertical
      @current_orientation = new_orientation
      current_matrix = grab(@current_matrix)
      if width_found < height_found
        size = width_found - 30
      else
        size = height_found - 30
      end
      set_orientation(new_orientation)
      current_matrix.attach(:work_zone)
      @basic_objects.each do |elem|
        grab(elem).display(true)
      end

      # wait 1 do
      current_matrix.display(:true)


      # wait 2 do
      #   alert size

      current_matrix.resize_matrix({ width: size, height: size })
      # current_matrix.center(true)
      #   # # current_matrix.delete(true)
      # current_matrix.left(666)
      # wait 0 do
      # puts "work_zone left; #{grab(:work_zone).left}, top; #{grab(:work_zone).top}"

      js_code =<<Javascript
// Récupérer l'élément et faire la première vérification (qui donnera probablement les dimensions incorrectes)
var element = document.getElementById('work_zone');
element.style.backgroundColor = 'green'; // Pour confirmer visuellement

console.log('-------------------');
console.log('AVANT requestAnimationFrame:');
// ... votre premier bloc de code pour afficher les propriétés ...

// Maintenant utiliser requestAnimationFrame pour obtenir les dimensions correctes
requestAnimationFrame(function() {
  // Récupérer l'élément
  var element = document.getElementById('work_zone');
  element.style.backgroundColor = 'green'; // Pour confirmer visuellement

  // Créer un objet avec toutes les informations et l'afficher en JSON
  var result = {};

  // Style inline
  result.styleTop = element.style.top;
  result.styleLeft = element.style.left;

  // Style calculé
  var style = window.getComputedStyle(element);
  result.computedDisplay = style.display;
  result.computedVisibility = style.visibility;
  result.computedOpacity = style.opacity;
  result.computedWidth = style.width;
  result.computedHeight = style.height;
  result.computedTop = style.top;
  result.computedLeft = style.left;

  // Dimensions et position
  var rect = element.getBoundingClientRect();
  result.rectWidth = rect.width;
  result.rectHeight = rect.height;
  result.rectTop = rect.top;
  result.rectLeft = rect.left;

  // Autres propriétés utiles
  result.offsetWidth = element.offsetWidth;
  result.offsetHeight = element.offsetHeight;
  result.clientWidth = element.clientWidth;
  result.clientHeight = element.clientHeight;

  // Afficher en JSON pour s'assurer que les valeurs sont visibles
  console.log('RÉSULTATS APRÈS requestAnimationFrame:');
  console.log(JSON.stringify(result, null, 2));

  // Ou afficher chaque valeur avec son nom
  for (var key in result) {
    console.log(key + ' = ' + result[key]);
  }
});
Javascript
      # alert(:poil)
      JS.eval(js_code)

      current_matrix.center(true)
      wait 2 do
        # grab('work_zone').color(:white)
        # puts "-------------->"
        # puts "work_zone width; #{grab(:work_zone).to_px(:width)}, height; #{grab(:work_zone).to_px(:height)}"
        # puts '------------->'
        current_matrix.center(true)
      end
      # end
      # end
      # end


    end

    def update_design(width, height, main_matrix)
      new_orientation = width > height ? :horizontal : :vertical
      if new_orientation != @current_orientation
        @current_orientation = new_orientation
        wait 0.1 do
          grab(:project_title).center(true)
          height_found = grab(:work_zone).to_px(:height)
          width_found = grab(:work_zone).to_px(:width)
          if width_found < height_found
            size = width_found - 30
          else
            size = height_found - 30
          end
          main_matrix.resize_matrix({ width: size, height: size })
          main_matrix.center(true)
          main_matrix.display(true)
        end
        set_orientation(new_orientation)
      end
      height_found = grab(:work_zone).to_px(:height)
      width_found = grab(:work_zone).to_px(:width)
      if width_found < height_found
        size = width_found - 30
      else
        size = height_found - 30
      end

      # now we resize the matrix
      main_matrix.resize_matrix({ width: size, height: size })
      main_matrix.center(true)
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
    #   update_design(width, height, main_matrix)
    # end
    #
    #
  end

  Vie.new


end