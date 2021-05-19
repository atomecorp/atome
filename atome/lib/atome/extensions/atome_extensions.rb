# here stand some atome's function to allow atome's objects manipulation

# the result method is used to get the return queries of the database
def result(params)
  result = {}
  params.each do |key_pair|
    result[key_pair[0]] = key_pair[1]
  end
  text("msg from atome_extension line 9 : #{result}")
end

def identity
  "a_" + object_id.to_s + "_" + Atome.atomes.length.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S")
end

def get(id)
  Atome.atomes.values.each do |atome|
    if atome.id == id
      return atome
    end
  end
  nil
end

def grab(atome_id)
  if Atome.atomes.key?(atome_id)
    Atome.atomes[atome_id]
  end
end

def find(query)
  grab(:view).find(query)
end

def batch(objects)
  batched_atomes = []
  objects.each do |atome_id|
    batched_atomes << atome_id.atome_id
  end
  ATOME.atomise(:batch, batched_atomes)
end

def tactile
  # check if user's device is a tactile device
  false
end

def lorem
  <<~STRDELIM
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
  STRDELIM
end

def wait(seconds)
  wait_html(seconds) do
    yield
  end
end

def schedule(date, &proc)
  date=date.to_s
  delimiters = [",", " ", ":", "-"]
  formated_date = date.split(Regexp.union(delimiters))

  missing_datas=Time.now
  missing_datas=missing_datas.to_s
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
  schedule_html(years, months, days, hours, minutes, seconds, &proc)
end

def repeat(delay = 3, repeat = 5, &proc)
  repeat_html(delay, repeat, &proc)
end

def clear(value)
  grab(:view).clear(value)
end

def atome_require(file)
  alert "atome_require message I replace atome_require with require to be able to load the file '#{file}'"
end

def compile(code)
  code = code.gsub("require ", "atome_require ")
  eval(code)
end

def version
  "v:0.017"
end

# def notification(message, duration)
#   notification = text({ content: message, color: :orange, x: 69, y: 69 })
#   ATOME.send(:wait, duration) do
#     notification.delete
#   end
# end

def animate(params)
  if params[:start][:blur]
    value_found = params[:start][:blur]
    params[:start][:filter] = "blur(#{value_found}px)"
    params[:start].delete(:blur)
  end
  if params[:end][:blur]
    value_found = params[:end][:blur]
    params[:end][:filter] = "blur(#{value_found}px)"
    params[:end].delete(:blur)
  end
  if params[:start][:smooth]
    value_found = params[:start][:smooth]
    params[:start][:borderRadius] = value_found
    params[:start].delete(:smooth)
  end
  if params[:end][:smooth]
    value_found = params[:end][:smooth]
    params[:end][:borderRadius] = value_found
    params[:end].delete(:smooth)
  end

  if params[:start][:color]
    value_found = params[:start][:color]
    value_found = grab(params[:target]).color_helper(value_found)
    params[:start][:background] = value_found
    params[:start].delete(:color)
  end
  if params[:end][:color]
    value_found = params[:end][:color]
    value_found = grab(params[:target]).color_helper(value_found)
    params[:end][:background] = value_found
    params[:end].delete(:color)
  end

  if params[:start][:shadow]
    value_found = params[:start][:shadow]
    value_found = grab(params[:target]).shadow_helper(value_found)
    params[:start][value_found[0]] = value_found[1]
    params[:start].delete(:shadow)
  end
  if params[:end][:shadow]
    value_found = params[:end][:shadow]
    value_found = grab(params[:target]).shadow_helper(value_found)
    params[:end][value_found[0]] = value_found[1]
    params[:end].delete(:shadow)
  end
  ATOME.animate_html(params)
end

def animate=(params)
  animate(params)
end

def anim(params)
  animate(params)
end

def selection
  ATOME.selection_html
end

def group(params)
  grab(:view).group(params)
end