
include Internal
def grab(val)
  Atome.grab(val)
end


def read(file, action=:text)
  Internal.send("read_#{action}", file)
end

def wait(seconds)
  seconds = seconds.to_f
  `setTimeout(function(){ #{yield} }, #{seconds * 1000})`
end


def repeater(counter,proc)
  instance_exec(counter,&proc) if proc.is_a?(Proc)
end

def repeat(delay = 1, repeat = 0, &proc)
  # below we exec the call a first time
  instance_exec(0,&proc) if proc.is_a?(Proc)
  # as we exec one time above we subtract one below
  %x{
var  x = 1
var intervalID = window.setInterval(function(){ Opal.Object.$repeater(x,#{proc})
if (++x ===#{repeat} )  {
       window.clearInterval(intervalID);
   }}, #{delay * 1000})
}

end


def schedule(date, &proc)
  date = date.to_s
  delimiters = [",", " ", ":", "-"]
  formated_date = date.split(Regexp.union(delimiters))
  missing_datas = Time.now
  missing_datas = missing_datas.to_s
  delimiters = [",", " ", ":", "-"]
  missing_datas_formated_date = missing_datas.split(Regexp.union(delimiters))

  case formated_date.length
  when 1
    seconds = formated_date[0]
    minutes = missing_datas_formated_date[4]
    hours = missing_datas_formated_date[3]
    days = missing_datas_formated_date[2]
    months = missing_datas_formated_date[1]
    years = missing_datas_formated_date[0]

  when 2
    seconds = formated_date[0]
    minutes = formated_date[1]
    hours = missing_datas_formated_date[3]
    days = missing_datas_formated_date[2]
    months = missing_datas_formated_date[1]
    years = missing_datas_formated_date[0]
  when 3
    seconds = formated_date[0]
    minutes = formated_date[1]
    hours = formated_date[2]
    days = missing_datas_formated_date[2]
    months = missing_datas_formated_date[1]
    years = missing_datas_formated_date[0]
  when 4
    seconds = formated_date[0]
    minutes = formated_date[1]
    hours = formated_date[2]
    days = formated_date[3]
  when 5
    seconds = formated_date[0]
    minutes = formated_date[1]
    hours = formated_date[2]
    days = formated_date[3]
    months = formated_date[4]
    years = missing_datas_formated_date[0]
  else
    years = formated_date[0]
    months = formated_date[1]
    days = formated_date[2]
    hours = formated_date[3]
    minutes = formated_date[4]
    seconds = formated_date[5]
  end
  `atome.jsSchedule(#{years},#{months},#{days},#{hours},#{minutes},#{seconds},#{proc})`
end


def schedule_callback(proc)
  instance_exec(&proc) if proc.is_a?(Proc)
end