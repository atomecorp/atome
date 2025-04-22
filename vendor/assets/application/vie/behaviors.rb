# frozen_string_literal: true

# used for logic behaviors
class Vie
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
    matrix_content.touch(:long) do |event|
      current_cell = grab(event[:target][:id].to_s)
      current_cell.color(:black)
    end
  end

  def tool_behavior(tool)
    tool.touch(true) do
      tool.alternate({ color: :red, shadow: { alpha: 1 }, blur: 3 }, { color: :green, shadow: false })
    end
  end
end
