# example listen speech recogintion

t=text("dites ce que vous voulez")

listen do |sentence|
  t.content(sentence)
end
