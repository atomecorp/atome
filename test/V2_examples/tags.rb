# frozen_string_literal: true
a=box({color: :orange})

a.tag({ color: :red })
a.tag({ star: 3 })
a.add({ tag: { quality: 9 } })

tags_found= a.tag.to_s

text({data: "Orange box tags are #{tags_found}" , width: :auto})