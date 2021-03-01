module GeometriesProperties
 def width(value=nil, &proc)
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
           @width = atomise(value)
           width_html(@width)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @width&.read
         end
 end
 def width=(value, &proc)
  width(value, &proc)
 end

 def height(value=nil, &proc)
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
           @height = atomise(value)
           height_html(@height)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @height&.read
         end
 end
 def height=(value, &proc)
  height(value, &proc)
 end

 def rotation(value=nil, &proc)
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
           @rotation = atomise(value)
           rotation_html(@rotation)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @rotation&.read
         end
 end
 def rotation=(value, &proc)
  rotation(value, &proc)
 end

end
