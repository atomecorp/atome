# frozen_string_literal: true

def wait(seconds, &proc)
  if seconds == :kill
    abort
  else
    seconds = seconds.to_f
    after seconds, &proc if proc.instance_of?(Proc)
  end

end

def repeater(counter, proc)
  instance_exec(counter, &proc) if proc.is_a?(Proc)
end

def repeat(delay = 1, repeat = 0, &proc)
  # below we exec the call a first time
  instance_exec(0, &proc) if proc.is_a?(Proc)
  # as we exec one time above we subtract one below
  `
var  x = 1
var intervalID = window.setInterval(function(){ Opal.Object.$repeater(x,#{proc})
if (++x ===#{repeat} )  {
       window.clearInterval(intervalID);
   }}, #{delay * 1000})
`
end

