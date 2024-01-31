# frozen_string_literal: true


b = box({ drag: true })
A.help(:left) do
  english = 'the left particle is,used to position the atome on the x axis, click me to get an example'
  french = "'la particle left est utilisée  pour positionner l'atome sur l'axe x, click moi pour obtenir un exemple"

  t = text({ int8: { english: english, french: french },  width: 666 })
  t.touch(true) do
    t.delete(true)
    example(:left)
  end
end


  b.help(:left)
