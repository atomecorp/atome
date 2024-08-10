# frozen_string_literal: true

def alert(val)
  val = val.to_s
  escaped_val = val.gsub("'", "\\\\'").gsub("\n", "\\n")
  JS.eval("alert('#{escaped_val}')")
end

# dummy object to allow code parity with Opal when using Native Object with wasm
def Native(obj)
  obj
end
