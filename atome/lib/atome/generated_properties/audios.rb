module AudiosProperties
 def contour(value=nil, &proc)
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
           @contour = atomise(value)
           contour_html(@contour)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @contour&.read
         end
 end
 def contour=(value, &proc)
  contour(value, &proc)
 end

 def reverb(value=nil, &proc)
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
           @reverb = atomise(value)
           reverb_html(@reverb)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @reverb&.read
         end
 end
 def reverb=(value, &proc)
  reverb(value, &proc)
 end

 def delay(value=nil, &proc)
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
           @delay = atomise(value)
           delay_html(@delay)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @delay&.read
         end
 end
 def delay=(value, &proc)
  delay(value, &proc)
 end

 def saturation(value=nil, &proc)
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
           @saturation = atomise(value)
           saturation_html(@saturation)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @saturation&.read
         end
 end
 def saturation=(value, &proc)
  saturation(value, &proc)
 end

end
