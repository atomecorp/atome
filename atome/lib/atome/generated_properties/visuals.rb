module VisualsProperties
 def color(value=nil, &proc)
   if proc && value.instance_of?(Hash)
           value[:value] = proc
         elsif proc && (value.instance_of?(String) || value.instance_of?(Symbol))
           property = {}
           property[:value] = proc
           property[:options] = value
           value = property
         elsif proc
           value = {value: proc}
         end
         if value || value == false
           @color = atomise(value)
           color_html(@color)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @color&.read
         end
 end
 def color=(value, &proc)
  color(value, &proc)
 end

 def opacity(value=nil, &proc)
   if proc && value.instance_of?(Hash)
           value[:value] = proc
         elsif proc && (value.instance_of?(String) || value.instance_of?(Symbol))
           property = {}
           property[:value] = proc
           property[:options] = value
           value = property
         elsif proc
           value = {value: proc}
         end
         if value || value == false
           @opacity = atomise(value)
           opacity_html(@opacity)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @opacity&.read
         end
 end
 def opacity=(value, &proc)
  opacity(value, &proc)
 end

 def border(value=nil, &proc)
   if proc && value.instance_of?(Hash)
           value[:value] = proc
         elsif proc && (value.instance_of?(String) || value.instance_of?(Symbol))
           property = {}
           property[:value] = proc
           property[:options] = value
           value = property
         elsif proc
           value = {value: proc}
         end
         if value || value == false
           @border = atomise(value)
           border_html(@border)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @border&.read
         end
 end
 def border=(value, &proc)
  border(value, &proc)
 end

 def overflow(value=nil, &proc)
   if proc && value.instance_of?(Hash)
           value[:value] = proc
         elsif proc && (value.instance_of?(String) || value.instance_of?(Symbol))
           property = {}
           property[:value] = proc
           property[:options] = value
           value = property
         elsif proc
           value = {value: proc}
         end
         if value || value == false
           @overflow = atomise(value)
           overflow_html(@overflow)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @overflow&.read
         end
 end
 def overflow=(value, &proc)
  overflow(value, &proc)
 end

end
