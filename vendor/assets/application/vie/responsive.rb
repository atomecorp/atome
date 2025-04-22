# frozen_string_literal: true

# used for dynamic responsive design
class Vie

  def set_orientation(orientation)
    universal_design
  end

  def universal_design
    @basic_objects.each do |elem|
      grab(elem).set(vie_style_universal[elem])
    end
    @actions_bar_content.each_with_index do |elem, index|
      if elem == 'separator'
        separator = grab(elem)
        separator.width(1)
        separator.rotate(0)
      end
      top_f = if index.zero?
                0
              else
                below(@actions_bar_content[index - 1])
              end
      centering = { x: 0 }
      grab(elem).set(top: top_f, center: centering)
    end
    @filer.each_with_index do |elem, index|
      top_f = if index.zero?
                0
              else
                below(@filer[index - 1])
              end
      centering = { x: 0 }
      grab(elem).set(top: top_f, center: centering)
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

    size = if work_zone_width < work_zone_height
             work_zone_width - 30
           else
             work_zone_height - 30
           end
    current_matrix.resize_matrix({ width: size, height: size })

    current_matrix.center({ x: 0 })
    grab(:project_title).center(true)
  end

  def update_design(width_found, height_found)
    new_orientation = width_found > height_found ? :horizontal : :vertical
    current_matrix = grab(@current_matrix)

    if @current_orientation.nil? || @current_orientation != new_orientation
      set_orientation(new_orientation)
      @current_orientation = new_orientation
    end
    work_zone_width = grab(:work_zone).to_px(:width)
    work_zone_height = grab(:work_zone).to_px(:height)

    size = if work_zone_width < work_zone_height
             work_zone_width - vie_size[:basic_size]
           else
             work_zone_height - vie_size[:basic_size]
           end
    current_matrix.resize_matrix({ width: size, height: size })

    current_matrix.center({ x: 0 })
  end

end
