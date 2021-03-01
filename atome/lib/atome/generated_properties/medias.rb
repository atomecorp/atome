module MediasProperties
 def content(value=nil, &proc)
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
           @content = atomise(value)
           content_html(@content)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           @content&.read
         end
 end
 def content=(value, &proc)
  content(value, &proc)
 end

 def image(value=nil, &proc)
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
           image_processor(value)
           image_html(@image)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           image_getter_processor(value)
           @image&.read
         end
 end
 def image=(value, &proc)
  image(value, &proc)
 end

 def video(value=nil, &proc)
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
           video_processor(value)
           video_html(@video)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           video_getter_processor(value)
           @video&.read
         end
 end
 def video=(value, &proc)
  video(value, &proc)
 end

 def box(value=nil, &proc)
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
           box_processor(value)
           box_html(@box)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           box_getter_processor(value)
           @box&.read
         end
 end
 def box=(value, &proc)
  box(value, &proc)
 end

 def circle(value=nil, &proc)
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
           circle_processor(value)
           circle_html(@circle)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           circle_getter_processor(value)
           @circle&.read
         end
 end
 def circle=(value, &proc)
  circle(value, &proc)
 end

 def text(value=nil, &proc)
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
           text_processor(value)
           text_html(@text)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           text_getter_processor(value)
           @text&.read
         end
 end
 def text=(value, &proc)
  text(value, &proc)
 end

 def image(value=nil, &proc)
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
           image_processor(value)
           image_html(@image)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           image_getter_processor(value)
           @image&.read
         end
 end
 def image=(value, &proc)
  image(value, &proc)
 end

 def audio(value=nil, &proc)
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
           audio_processor(value)
           audio_html(@audio)
         else
           # below this is the method getter it return the instance variable if it is define(&.rea)
           audio_getter_processor(value)
           @audio&.read
         end
 end
 def audio=(value, &proc)
  audio(value, &proc)
 end

end
