module UtilitiesProperties
 def edit(value=nil, &proc)
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
           @edit = atomise(value)
           edit_html(@edit)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @edit&.read
         end
 end
 def edit=(value, &proc)
  edit(value, &proc)
 end

 def record(value=nil, &proc)
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
           @record = atomise(value)
           record_html(@record)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @record&.read
         end
 end
 def record=(value, &proc)
  record(value, &proc)
 end

 def enliven(value=nil, &proc)
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
           @enliven = atomise(value)
           enliven_html(@enliven)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @enliven&.read
         end
 end
 def enliven=(value, &proc)
  enliven(value, &proc)
 end

 def selector(value=nil, &proc)
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
           @selector = atomise(value)
           selector_html(@selector)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @selector&.read
         end
 end
 def selector=(value, &proc)
  selector(value, &proc)
 end

 def render(value=nil, &proc)
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
           @render = atomise(value)
           render_html(@render)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @render&.read
         end
 end
 def render=(value, &proc)
  render(value, &proc)
 end

 def preset(value=nil, &proc)
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
           @preset = atomise(value)
           preset_html(@preset)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @preset&.read
         end
 end
 def preset=(value, &proc)
  preset(value, &proc)
 end

end
