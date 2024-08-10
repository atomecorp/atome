# frozen_string_literal: true

# main add on
def alert(val)
  val = val.to_s
  escaped_val = val.gsub("'", "\\\\'")
  JS.eval("alert('#{escaped_val}')")
end