# frozen_string_literal: true

def alert(val)
  JS.eval("alert('#{val}')")
end