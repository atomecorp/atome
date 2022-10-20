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
    puts "send params to naimation engine"
  end

  def _data(value)
    #dummy metho fto handle atome with no type
  end

end