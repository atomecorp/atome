class Atome

  def idb_load_callback(operation, content = nil)
    case operation
    when 'save'
      proc_f = A.content[:idb_save_proc]
      proc_f.call(content) if proc_f.is_a?(Proc)
    when 'load'
      proc_f = A.content[:idb_load_proc]
      proc_f.call(content) if proc_f.is_a?(Proc)
    when 'remove'
      proc_f = A.content[:idb_remove_proc]
      proc_f.call(content) if proc_f.is_a?(Proc)
    when 'reset'
      proc_f = A.content[:idb_reset_proc]
      proc_f.call(content) if proc_f.is_a?(Proc)
    when 'list'
      proc_f = A.content[:idb_list_proc]
      proc_f.call(content) if proc_f.is_a?(Proc)
    else
      puts 'nothing happened'
    end
  end

  def idb_save (idb, filename, content, &proc)
    if A.data.instance_of?(Hash)
      A.content[:idb_save_proc] = proc
    else
      A.content = { idb_save_proc: proc }
    end
    js_func('idb_save', idb, filename, content)
  end

  def idb_load(idb, filename, &proc)
    if A.data.instance_of?(Hash)
      A.content[:idb_load_proc] = proc
    else
      A.content = { idb_load_proc: proc }
    end
    js_func('idb_load', idb, filename)
  end

  def idb_list (idb, &proc)
    if A.data.instance_of?(Hash)
      A.content[:idb_list_proc] = proc
    else
      A.content = { idb_list_proc: proc }
    end
    js_func('idb_list', idb)
  end

  def idb_remove(idb, filename, &proc)
    if A.data.instance_of?(Hash)
      A.content[:idb_remove_proc] = proc
    else
      A.content = { idb_remove_proc: proc }
    end
    js_func('idb_remove', idb, filename)
  end

  def idb_reset(idb, &proc)
    if A.data.instance_of?(Hash)
      A.content[:idb_reset_proc] = proc
    else
      A.content = { idb_reset_proc: proc }
    end
    js_func('idb_reset', idb)
  end

end

b = box({ left: 0, text: :save })

b.touch(true) do
  b.idb_save('eDen', :toto, "hello") do |file_get|
    puts "file_saved: #{file_get}"
  end
end

c = box({ left: 50, text: :load })

c.touch(true) do
  A.idb_load('eDen', :toto) do |file_get|
    puts "file_get: #{file_get}"
  end
end

d = box({ left: 100, text: :list })

d.touch(true) do
  A.idb_list(:eDen) do |file_get|
    puts "file_list: #{file_get}"
  end
end

e = box({ left: 150, text: :remove })

e.touch(true) do
  A.idb_remove('eDen', :toto) do |file_get|
    puts "file_remove: #{file_get}"
  end
end

f = box({ left: 200, text: :reset })

f.touch(true) do
  A.idb_reset(:eDen)do |file_get|
    puts "file_reset: #{file_get}"
  end
end


