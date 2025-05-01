

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


