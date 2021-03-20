module Processors

#  def parent_pre_processor(value)
#    # first we force the value to be an array as hierarchies methods holds many parents or children
#    if value.instance_of?(Array)
#      values = value
#    else
#      values = [value]
#    end
#    # we set the parent into the parent_instance variable
#    values.each do |val|
#      # we check if we have a proc to allow the batch of them in the proc call
#      if val[:proc]
#        @parent.read.each do |parent|
#          parent = grab(parent)
#          val[:proc].call(parent) if val[:proc].is_a?(Proc)
#        end
#      else
##if there's is already some parents we had them to the array else we atomise the property
#        if @parent.nil?
#          @parent = atomise(:parent, value)
#        elsif @parent.read.instance_of?(Array)
#          @parent << atomise(value)
#        else
#          @parent = atomise([value])
#        end
#        # we inform the children they have new parents
#        grab(val).add_to_instance_variable(:child, self.atome_id)
#        if atome_id == :toto
#          puts ":: #{@parent.read} #{@parent} #{@parent.class} ::"
#        else
#          puts "#{@parent.read} #{@parent} #{@parent.class}"
#          parent_html(@parent)
#        end
#
#      end
#    end
#  end

  def parent_pre_processor(value)
    # first we force the value to be an array as hierarchies methods holds many parents or children
    if value.instance_of?(Array)
      values = value
    else
      values = [value]
    end
    # we set the parent into the parent_instance variable
    values.each do |val|
      # we check if we have a proc to allow the batch of them in the proc call
      if val[:proc]
        @parent.read.each do |parent|
          parent = grab(parent)
          val[:proc].call(parent) if val[:proc].is_a?(Proc)
        end
      else
        #if there's is already some parents we had them to the array else we atomise the property
        if @parent.nil?
          @parent = atomise(:parent, value)
        else
          @parent= @parent.read
          @parent << value
          @parent = atomise(:parent, @parent)
        end
        # we inform the children they have new parents
        grab(val).add_to_instance_variable(:child, self.atome_id)
        parent_html(@parent)
      end
    end
  end

  def parent_getter_processor
    @parent
  end

  def child_pre_processor(value)
    # first we force the value to be an array as hierarchies methods holds many parents or children
    if value.instance_of?(Array)
      values = value
    else
      values = [value]
    end
    # we set the child into the child_instance variable
    values.each do |val|
      # we check if we have a proc to allow the batch of them in the proc call
      if val[:proc]
        @child.read.each do |child|
          child = grab(child)
          val[:proc].call(child) if val[:proc].is_a?(Proc)
        end
      else
        #if there's is already some children we had them to the array else we atomise the property
        if @child.nil?
          @child = atomise(:child, value)
        else
          @child << value
        end
        # we inform the parents they have new children
        grab(val).add_to_instance_variable(:parent, self.atome_id)
        child_html(@child)
      end
    end
  end

  def child_getter_processor
    @child
  end
end