# frozen_string_literal: true

class Atome
  def ping(address, my_proc: false)
    # if  RUBY_ENGINE.downcase != 'opal'
    def up?(host, my_proc)
      check = Net::Ping::External.new(host)
      if check.ping?
        puts "ping respond!! "
      end
    end

    chost = address
    puts up?(chost, my_proc) # prints "true" if ping replies
    # end
  end
end
