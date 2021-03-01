module IdentitiesProperties
 def atome_id(value=nil, &proc)
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
           atome_id_processor(value)
           atome_id_html(@atome_id)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @atome_id&.read
         end
 end
 def atome_id=(value, &proc)
  atome_id(value, &proc)
 end

 def id(value=nil, &proc)
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
           @id = atomise(value)
           id_html(@id)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @id&.read
         end
 end
 def id=(value, &proc)
  id(value, &proc)
 end

 def type(value=nil, &proc)
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
           @type = atomise(value)
           type_html(@type)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @type&.read
         end
 end
 def type=(value, &proc)
  type(value, &proc)
 end

 def language(value=nil, &proc)
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
           @language = atomise(value)
           language_html(@language)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @language&.read
         end
 end
 def language=(value, &proc)
  language(value, &proc)
 end

 def private(value=nil, &proc)
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
           private_processor(value)
           private_html(@private)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           private_getter_processor(value)
           @private&.read
         end
 end
 def private=(value, &proc)
  private(value, &proc)
 end

 def can(value=nil, &proc)
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
           can_processor(value)
           can_html(@can)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           can_getter_processor(value)
           @can&.read
         end
 end
 def can=(value, &proc)
  can(value, &proc)
 end

end
