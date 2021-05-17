module Processors
  def size_pre_processor(value)
    if value.instance_of?(Hash) && value[:value].nil?
      if value[:fit]
        requested_width=grab(value[:fit]).width
        requested_height=grab(value[:fit]).height
        if value[:margin].instance_of?(Hash)
          margin_x=value[:margin][:x]
          margin_y=value[:margin][:y]
        else
          margin_x=value[:margin]
          margin_y=value[:margin]
        end
        self.width=requested_width+margin_x
        self.height=requested_height+margin_y
      end
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