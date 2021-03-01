module EventsProperties
 def touch(value=nil, &proc)
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
           @touch = atomise(value)
           touch_html(@touch)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @touch&.read
         end
 end
 def touch=(value, &proc)
  touch(value, &proc)
 end

 def drag(value=nil, &proc)
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
           @drag = atomise(value)
           drag_html(@drag)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @drag&.read
         end
 end
 def drag=(value, &proc)
  drag(value, &proc)
 end

 def over(value=nil, &proc)
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
           @over = atomise(value)
           over_html(@over)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @over&.read
         end
 end
 def over=(value, &proc)
  over(value, &proc)
 end

end
