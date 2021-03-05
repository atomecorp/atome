module Processors
  def size_processor(value)
    size = 0
    if width && height
      size = value[:value]
      if width > height
        ratio = size / width
        self.width = size
        self.height = height * ratio
      else
        ratio = size / height
        self.height = size
        self.width = width * ratio
      end
    else
      self.height = size
      self.width = size
    end
  end
end