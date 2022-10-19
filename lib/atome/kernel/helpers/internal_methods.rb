module Internal
  def self.read_ruby(file)
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
end