
class Atome
  @@idb_save_proc=:poil
  def idb_load_callback(operation, content=nil)
    case operation
    when 'save'
       @@idb_save_proc.call(content) if @@idb_save_proc.is_a?(Proc)
    when 'load'
      puts "load: #{operation}: #{content}"
    when 'remove'
      puts "remove: #{operation}: #{content}"
    when 'reset'
      puts "reset: #{operation}: #{content}"
    when 'list'
      puts "list: #{operation}: #{content}"
    else
      puts 'nothing happened'
    end
  end



  def idb_save (idb, filename, content, &proc )
    @@idb_save_proc = proc
    js_func('idb_save', idb,filename, content)
  end

  def idb_load(idb,filename )
    js_func('idb_load', idb,filename)
  end

  def idb_list (idb )
    js_func('idb_list', idb)
  end

  def idb_remove(idb,filename )
    js_func('idb_remove', idb,filename)
  end

  def idb_reset(idb )
    js_func('idb_reset', idb)
  end

end




b=box({left: 0,text: :save })

b.touch(true) do
  b.idb_save('eDen',:toto, "hello") do |file_get|
    puts "file_saved: #{file_get}"
  end
end


c=box({left: 50,text: :load })

c.touch(true) do
  A.idb_load('eDen',:toto) do |file_get|
    puts "file_get: #{file_get}"
  end
end


d=box({left: 100,text: :list })

d.touch(true) do
  A.idb_list(:eDen)
end


e=box({left: 150,text: :remove })

e.touch(true) do
  A.idb_remove('eDen',:toto)
end


f=box({left: 200,text: :reset })

f.touch(true) do
  A.idb_reset(:eDen)
end


