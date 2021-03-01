module EffectsProperties
 def blur(value=nil, &proc)
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
           @blur = atomise(value)
           blur_html(@blur)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @blur&.read
         end
 end
 def blur=(value, &proc)
  blur(value, &proc)
 end

 def shadow(value=nil, &proc)
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
           @shadow = atomise(value)
           shadow_html(@shadow)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @shadow&.read
         end
 end
 def shadow=(value, &proc)
  shadow(value, &proc)
 end

 def smooth(value=nil, &proc)
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
           @smooth = atomise(value)
           smooth_html(@smooth)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @smooth&.read
         end
 end
 def smooth=(value, &proc)
  smooth(value, &proc)
 end

end
