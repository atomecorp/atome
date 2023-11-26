# frozen_string_literal: true

# ping method
class Atome
  def up?(host, _my_proc)
    check = Net::Ping::External.new(host)
    return unless check.ping?
    'ping respond!!'
  end

  def ping(address, my_proc: false)
    up(address, my_proc) # prints "true" if ping replies
  end
end
