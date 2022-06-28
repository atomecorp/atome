def ping(address, my_proc)
  # if  RUBY_ENGINE.downcase != 'opal'
  #   puts RUBY_ENGINE.downcase
  #   # def up?(host,  my_proc)
  #   #   check = Net::Ping::External.new(host)
  #   #   if check.ping?
  #   #     puts my_proc
  #   #   end
  #   # end
  #   # chost = address
  #   # puts up?(chost, my_proc) # prints "true" if ping replies
  # else
  #   alert :kool
    ` var p = new Ping();
        p.ping('https://'+#{address}+'', function (err, data) {
            if (err) {
               return false;
            } else {
 console.log("ping result is :"+ #{my_proc});
            }
        });
`
  # end
end