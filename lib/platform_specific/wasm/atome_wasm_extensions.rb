# frozen_string_literal: true

def alert(val)
  escaped_val = val.to_s.gsub("'", "\\'").gsub("\n", "\\n")
  JS.eval("alert('#{escaped_val}')")
end

# dummy object to allow code parity with Opal when using Native Object with wasm
def Native(obj)
  obj
end
