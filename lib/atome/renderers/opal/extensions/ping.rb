# frozen_string_literal: true

# Add on the Atome class
class Atome
  def ping(my_proc = false)
    instance_exec(my_proc) if my_proc.is_a?(Proc)

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
