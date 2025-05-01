
class Atome
  def idb_load_callback(operation, content=nil)
    case operation
    when 'save'
      puts "#{operation}: #{content}"
    when 'load'
      puts "#{operation}: #{content}"
    else
      puts 'no'
    end

  end
end



def idb_save (idb, filename, content )
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

b=box({left: 0,text: :save })

b.touch(true) do
  idb_save('eDen',:toto, "hello")
end


c=box({left: 50,text: :load })

c.touch(true) do
  idb_load('eDen',:toto)
end


d=box({left: 100,text: :list })

d.touch(true) do
  idb_list(:eDen)
end


e=box({left: 150,text: :remove })

e.touch(true) do
  idb_remove('eDen',:toto)
end


f=box({left: 200,text: :reset })

f.touch(true) do
  idb_reset(:eDen)
end


