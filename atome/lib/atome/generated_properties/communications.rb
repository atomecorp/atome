module CommunicationsProperties
 def share(value=nil, &proc)
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
           @share = atomise(value)
           share_html(@share)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @share&.read
         end
 end
 def share=(value, &proc)
  share(value, &proc)
 end

end
