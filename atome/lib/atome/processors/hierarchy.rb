module Processors
  def parent_pre_processor(parent_list)
    # we have to ensure the parent list is an array if not we put it in a array
    if parent_list.instance_of?(Hash) && parent_list[:proc]
      parent_list.each do
        #fixme processor hierarchy.rb to factorise:  this loop is used twice!
        @parent.q_read.each do |parent|
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
          grab(parent_found).child = []
        end
        grab(parent_found).child.add([self.atome_id])
        parent_html(parent_found)
      end
    end
    # below if current object have child we refresh them all
    if child
      child.each do |child_found|
        child_found.render(true)
      end
    end
  end

  def parent_getter_processor
    @parent
  end

  def child_pre_processor(child_list)
    # we have to ensure the child list is an array if not we put it in a array
    if child_list.instance_of?(Hash) && child_list[:proc]
      # if  a proc is found we yield each child so they can be treated , ex :
      child_list.each do
        @child.q_read.each do |child|
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
        puts "************#{child_found}***************"
        unless grab(child_found).parent
          grab(child_found).parent = []
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

  def remove_child child_to_remove
    remove_instance_variable_content(:child, child_to_remove)
  end

  def remove_parent parent_to_remove
    remove_instance_variable_content(:parent, parent_to_remove)
  end

end

# module Processors
#   def parent_pre_processor(parent_list)
#     # we have to ensure the parent list is an array if not we put it in a array
#     if parent_list.instance_of?(Hash) && parent_list[:proc]
#       parent_list.each do
#         #fixme processor hierarchy.rb to factorise:  this loop is used twice!
#         @parent.q_read.each do |parent|
#           parent = grab(parent)
#           parent_list[:proc].call(parent) if parent_list[:proc].is_a?(Proc)
#         end
#       end
#     else
#       unless parent_list.instance_of?(Array)
#         parent_list = [parent_list]
#       end
#       if @parent.nil?
#         @parent = atomise(:parent, parent_list)
#       else
#         # we don't have to atomise as the Quark's add method add it directly to the quark
#         @parent=parent_list
#       end
#       parent_list.each do |parent_found|
#         # now we inform the children they have new Parents
#         # we put self.atome_id] in an array because the Quark add methods concat array
#         # puts " msg from hierachy.rb parent_pre_proc.. : #{parent_found} : #{parent_found.class}"
#         # parent_found=parent_found[:value]
#         unless grab(parent_found).child
#           grab(parent_found).child = []
#         end
#         # Fixme : Important ugly patch below please
#         # #test to erase
#         # alert grab(parent_found).child
#         # grab(parent_found).child.add(:totoxr)
#         # #test to erase
#
#         grab(parent_found).child(atome_id)
#         parent_html(parent_found)
#       end
#     end
#     # below if current object have child we refresh them all
#     if child
#       child.each do |child_found|
#         child_found.render(true)
#       end
#     end
#   end
#
#   def parent_getter_processor
#     @parent
#   end
#
#   def child_pre_processor(child_list)
#     # we have to ensure the child list is an array if not we put it in a array
#     if child_list.instance_of?(Hash) && child_list[:proc]
#       # if  a proc is found we yield each child so they can be treated , ex :
#       child_list.each do
#         @child.q_read.each do |child|
#           child = grab(child)
#           child_list[:proc].call(child) if child_list[:proc].is_a?(Proc)
#         end
#       end
#     else
#
#       unless child_list.instance_of?(Array)
#         child_list = [child_list]
#       end
#
#       if @child.nil?
#         # if atome_id == :the_circle
#         #   alert child_list
#         # end
#         @child = atomise(:child, child_list)
#       else
#         # if atome_id == :the_circle
#         #   alert :poueti
#         # end
#         # we don't have to atomise as the Quark's add method add it directly to the quark
#         @child=child_list
#       end
#       child_list.each do |child_found|
#         # now we inform the parents they have new children
#         # we get the parent an add the child atome_id directly into the
#         # we put self.atome_id] in an array because the Quark add methods concat array
#         # child_found = child_found[:value]
#         unless grab(child_found).parent
#           grab(child_found).parent = []
#         end
#
#         # grab(child_found).parent.add([atome_id])
#         grab(child_found).parent(atome_id)
#         # we update the view
#         child_html(child_found)
#       end
#     end
#   end
#
#   def child_getter_processor
#     @child
#   end
#
#   def remove_child child_to_remove
#     remove_instance_variable_content(:child, child_to_remove)
#   end
#
#   def remove_parent parent_to_remove
#     remove_instance_variable_content(:parent, parent_to_remove)
#   end
#
# end

