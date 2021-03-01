module HierarchiesProperties
 def parent(value=nil, &proc)
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
           @parent = atomise(value)
           parent_html(@parent)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @parent&.read
         end
 end
 def parent=(value, &proc)
  parent(value, &proc)
 end

 def child(value=nil, &proc)
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
           @child = atomise(value)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @child&.read
         end
 end
 def child=(value, &proc)
  child(value, &proc)
 end

 def insert(value=nil, &proc)
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
           @insert = atomise(value)
           insert_html(@insert)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @insert&.read
         end
 end
 def insert=(value, &proc)
  insert(value, &proc)
 end

end
