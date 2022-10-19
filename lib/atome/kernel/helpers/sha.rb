class Atome
  def calculate_sha(string)
    Digest::SHA256.hexdigest(string)
  end
end

