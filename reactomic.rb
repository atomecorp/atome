require "filewatcher"
File.delete("cache/app_status") if File.exist?("cache/app_status")
File.write("cache/app_status", "")
Filewatcher.new(['/Users/jean-ericgodard/Desktop/atome/eVe/', '/Users/jean-ericgodard/Desktop/atome/atome/']).watch do |changes|
  pid=File.read("cache/app_status")
  if pid!=""
    pid=pid.to_i
    Process.kill(:TERM, pid)
    Process.wait(pid)
    system("bundle exec rake run::atomic_reaction")
    pid = Process.spawn("cordova run browser")
    File.write("cache/app_status", pid)
  else
    system("bundle exec rake run::atomic_reaction")
    pid = Process.spawn("cordova run browser")
    File.write("cache/app_status", pid)
  end
end