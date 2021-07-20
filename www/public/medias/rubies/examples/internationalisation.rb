# internationalisation  example

t0=text({content: lorem })
t1=text({content: lorem })
t=text({content: lorem, language: :english })
t.content({french: :salut, spanish: :hola, english: :hello, german: :hallo})
t1.content({french: :salut, spanish: :hola, english: :hello, german: :hallo})
t1.y(33)
t0.y(66)

t.content
# alert t.content.class

