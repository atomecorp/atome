module HelpersProperties
 def tactile(value=nil, &proc)
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
           @tactile = atomise(value)
           tactile_html(@tactile)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @tactile&.read
         end
 end
 def tactile=(value, &proc)
  tactile(value, &proc)
 end

 def display(value=nil, &proc)
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
           @display = atomise(value)
           display_html(@display)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @display&.read
         end
 end
 def display=(value, &proc)
  display(value, &proc)
 end

end
