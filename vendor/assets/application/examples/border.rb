# frozen_string_literal: true


col=color({red: 1, blue: 1, id: :the_col})
c=circle
b=box({left: 333})
c2=circle({top: 190, width: 99, height: 99})
c2.border({ thickness: 5, color: color(:blue), pattern: :dotted })
c.border({ thickness: 5, color: col, pattern: :dotted })
b.border({ thickness: 5, color: col, pattern: :dotted })


# # frozen_string_literal: true
#
# col=color({red: 1, blue: 1, id: :the_col})
#
#
# c=circle
# b=box({left: 333})
# # b.attached([col.id])
# c.border({ thickness: 5, pattern: :dotted })
# b.border({ thickness: 5, attached: col.id, pattern: :dotted })
