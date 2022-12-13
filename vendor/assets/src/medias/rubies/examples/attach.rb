# frozen_string_literal: true



# TODO : debug the attach method it color the view by default
# box({id: :my_box})
# c=color(:red)
# grab(:view).color(:black)
# c.attach([:my_box])

box({id: :my_box})
color({red: 1, blue: 1, attach: [:my_box]})