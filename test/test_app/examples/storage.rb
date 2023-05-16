# Storage example
require 'browser/storage'

$storage = $window.storage
$storage[:hello] = { jeezs: { data: :kool } }

# alert($storage[:hello][:jeezs])
$storage[:hello][:jeezs][:toto]=:titi
puts  "storage content is : #{$storage[:hello]}"