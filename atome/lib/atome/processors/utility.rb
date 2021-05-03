module Processors
  def monitor_processor(value)
    # we only call the proc when there's a value to monitor empty event that is send  applying monitor methods onto
    # the atome
    if value[:value]
      proc = value[:proc]
      proc.call(value) if proc.is_a?(Proc)
    end
  end

  def condition_pre_processor(value)
    alert "utility.rb line 12 #{value}"
    ## @condition = atomise(:condition,value)
    #     content = find(value[:condition])
    #     Atome.new({ type: :find, render: false, name: value[:name], content: content, condition: value[:condition], dynamic: value[:dynamic] })
    #     value = properties_common(value, &proc)
    #     @group = atomise(:content, value)
    #     self
  end

end
