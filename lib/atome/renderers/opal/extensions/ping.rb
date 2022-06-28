class Atome
  def ping(address, my_proc)
    ` var p = new Ping();
        p.ping('https://'+#{address}+'', function (err, data) {
            if (err) {
               return false;
            } else {
 console.log("the site "+#{address}+" is up!");
            }
        });
`
  end
end
