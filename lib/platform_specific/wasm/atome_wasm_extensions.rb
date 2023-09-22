# frozen_string_literal: true

def alert(val)
  JS.eval("alert('#{val}')")
end


# dummy object to allow code parity with Opal when using Native Object with wasm
def Native(obj)
  obj
end