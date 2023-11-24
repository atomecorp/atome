class Black_matter
  class << self
    def encode(string)
      JS.global.sha256(string.to_s)
    end

    def check_password(input_password, stored_hash)
      input_hash = encode(input_password)
      input_hash == stored_hash
    end

    def set_password(hashed_pass)
      @password = hashed_pass
    end

    def password
      @password
    end

  end

end