# frozen_string_literal: true

# addon for the Atome class
class Atome
  def calculate_sha(string)
    if RUBY_ENGINE.downcase == 'opal' || 'wasm32-wasi'
      # `sha256(#{string})`
      js_code = "sha256('#{string}')"
      JS.eval(js_code)
    else
      Digest::SHA256.hexdigest(string)
    end
  end
end
