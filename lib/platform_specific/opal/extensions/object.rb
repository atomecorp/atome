# frozen_string_literal: true

# main add on
def alert(val)
  JS.eval("alert('#{val}')")
end