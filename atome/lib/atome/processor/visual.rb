module VisualsProcessors
  def color_processor(value)
    [red: value.sub("green", "1"), green: 0, blue: 0, alpha: 1]
  end
end
