module Processors

  def parent_pre_processor(parent_list)
    # we have to ensure the parent list is an array if not we put it in a array
    if parent_list.instance_of?(Hash) && parent_list[:proc]
      parent_list.each do
        puts "processor hierarchy.rb to refactorise  this loop is used twice"
        @parent.read.each do |parent|
          parent = grab(parent)
          parent_list[:proc].call(parent) if parent_list[:proc].is_a?(Proc)
        end
      end
    else
      unless parent_list.instance_of?(Array)
        parent_list = [parent_list]
      end
        if @parent.nil?
        @parent = atomise(:parent, parent_list)
      else
        # we don't have to atomise as the Quark's add method add it directly to the quark
        @parent.add(parent_list)
        end
      parent_list.each do |parent_found|
        # now we inform the children they have new Parents
        # we put self.atome_id] in an array because the Quark add methods concat array
        unless grab(parent_found).child
          grab(parent_found).child=[]
        end
        grab(parent_found).child.add([self.atome_id])
        parent_html(parent_found)
      end
    end
  end

  def parent_getter_processor
    @parent
  end

  def child_pre_processor(child_list)
    # we have to ensure the child list is an array if not we put it in a array
    if child_list.instance_of?(Hash) && child_list[:proc]
      child_list.each do
        @child.read.each do |child|
          child = grab(child)
          child_list[:proc].call(child) if child_list[:proc].is_a?(Proc)
        end
      end
    else
      unless child_list.instance_of?(Array)
        child_list = [child_list]
      end

      if @child.nil?
        @child = atomise(:child, child_list)
      else
        # we don't have to atomise as the Quark's add method add it directly to the quark
        @child.add(child_list)
      end
      child_list.each do |child_found|
        # now we inform the parents they have new children
        # we get the parent an add the child atome_id directly into the
        # we put self.atome_id] in an array because the Quark add methods concat array
        unless grab(child_found).parent
          grab(child_found).parent=[]
        end
        grab(child_found).parent.add([self.atome_id])
        # we update the view
        child_html(child_found)
      end
    end
  end

  def child_getter_processor
    @child
  end
end


#values.each do |val|
#  # we check if we have a proc to allow the batch of them in the proc call
#  if val[:proc]
#    @child.read.each do |child|
#      child = grab(child)
#      val[:proc].call(child) if val[:proc].is_a?(Proc)
#    end
#  else
#    #if there's is already some children we had them to the array else we atomise the property
#    if @child.nil?
#      @child = atomise(:child, value)
#    else
#      @child << value
#    end
#    # we inform the parents they have new children
#    grab(val).add_to_instance_variable(:parent, self.atome_id)
#    child_html(@child)
#  end
#end