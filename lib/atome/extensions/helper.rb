def grab(val)
  Atome.grab(val)
end


def read_ruby(file)
  `
fetch('medias/rubies/'+#{file})
  .then(response => response.text())
  .then(text => Opal.eval(text))
`
end

def read_text(file)
  `
fetch('medias/rubies/'+#{file})
  .then(response => response.text())
  .then(text => console.log(text))
`
end


def read(file, action=:text)
  send("read_#{action}", file)
end