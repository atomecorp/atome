# frozen_string_literal: true
class Atome
  def calculate_sha(string)
    # if RUBY_ENGINE.downcase == 'opal'
    `sha256(#{string})`
    # else
    #   Digest::SHA256.hexdigest(string)
    # end
  end
end

