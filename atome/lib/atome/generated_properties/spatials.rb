module SpatialsProperties
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

 def size(value=nil, &proc)
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
           @size = atomise(value)
           size_html(@size)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @size&.read
         end
 end
 def size=(value, &proc)
  size(value, &proc)
 end

 def x(value=nil, &proc)
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
           @x = atomise(value)
           x_html(@x)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @x&.read
         end
 end
 def x=(value, &proc)
  x(value, &proc)
 end

 def xx(value=nil, &proc)
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
           @xx = atomise(value)
           xx_html(@xx)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @xx&.read
         end
 end
 def xx=(value, &proc)
  xx(value, &proc)
 end

 def y(value=nil, &proc)
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
           @y = atomise(value)
           y_html(@y)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @y&.read
         end
 end
 def y=(value, &proc)
  y(value, &proc)
 end

 def yy(value=nil, &proc)
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
           @yy = atomise(value)
           yy_html(@yy)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @yy&.read
         end
 end
 def yy=(value, &proc)
  yy(value, &proc)
 end

 def z(value=nil, &proc)
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
           @z = atomise(value)
           z_html(@z)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @z&.read
         end
 end
 def z=(value, &proc)
  z(value, &proc)
 end

 def center(value=nil, &proc)
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
           @center = atomise(value)
           center_html(@center)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @center&.read
         end
 end
 def center=(value, &proc)
  center(value, &proc)
 end

end
