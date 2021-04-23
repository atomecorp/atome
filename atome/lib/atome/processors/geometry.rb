module Processors
  def size_pre_processor(value)
    if value.instance_of?(Hash) && value[:value].nil?
    else
      if value.instance_of?(Number) || value.instance_of?(Integer)
        value = { value: value }
      elsif value.instance_of?(String) || value.instance_of?(Symbol)
        value = { fit: value }
      end
      size = value[:value]
      if width && height && width != :auto && height != :auto
        if width > height
          if size
            ratio = size / width
            self.width = size
            self.height = height * ratio
          end
        else
          if size
            ratio = size / height
            self.height = size
            self.width = width * ratio
          end
        end
      else
        self.height = size
        self.width = size
      end
    end
    if self.size
      value = self.size.merge(value)
    end
    @size = atomise(:size, value)
    size_html(value)
  end
end