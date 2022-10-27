module Internal
  def self.read_ruby(file)
    # TODO write a ruby script that'll list and sort all files so they can be read
    `
fetch('medias/rubies/'+#{file})
  .then(response => response.text())
  .then(text => Opal.eval(text))
`
  end

  def  self.read_text(file)
    `
fetch('medias/rubies/'+#{file})
  .then(response => response.text())
  .then(text => console.log(text))
`
  end

  def text_data(value)
    @html_object.text = value
  end

  def animator_data(value)
    puts "send params to animation engine#{value}"
  end

  def _data(value)
    #dummy method to handle atome with no type
  end

  def dragCallback(page_x, page_y, x, y, current_object,target, proc=nil)
    # puts "dragCallback is called #{current_object.id}"
    # Note this method is call from atome.js  :  AtomeDrag methods
    # target.instance_variable_set('@left', x)
    # target.instance_variable_set('@top', y)
    current_object.instance_exec({ x: page_x, y: page_y }, &proc) if proc.is_a?(Proc)
  end

end