#  frozen_string_literal: true

raw_data = <<STR
<iframe width="560" height="315" src="https://www.youtube.com/embed/8BT4Q3UtO6Q?si=WI8RlryV8HW9Y0nz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
STR
raw({ id: :the_raw_stuff, data: raw_data })