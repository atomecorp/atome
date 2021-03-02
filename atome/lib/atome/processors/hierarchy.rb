module Processors

  def parent_pre_processor(value)
    if value.instance_of?(Array)
      values = value
    else
      values = [value]
    end
    # we set the parent into the parent_instance variable
    values.each do |val|
      if val[:value]
        @parent.read.each do |parent|
          parent=grab(parent)
          val[:value].call(parent) if val[:value].is_a?(Proc)
        end
      else
        @parent = atomise(:parent, value)
        grab(val).update_instance_variable(:child, self.atome_id)
        parent_html(@parent)
      end
    end
  end

  def parent_getter_processor
    @parent
  end

  def child_pre_processor(value)
    if value.instance_of?(Array)
      values = value
    else
      values = [value]
    end
    # we set the parent into the parent_instance variable
    values.each do |val|
      if val[:value]
        @child.read.each do |child|
          child=grab(child)
          val[:value].call(child) if val[:value].is_a?(Proc)
        end
      else
        @child = atomise(:child, value)
        grab(val).update_instance_variable(:parent, self.atome_id)
        child_html(@child)
      end
    end
  end

  def child_getter_processor
    @child
  end
end