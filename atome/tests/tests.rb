# Creation tests
circle(200,200,150,120)
circle ({color: :red, x: 100, y: 150})

# open test
run
open_ide
open_console(:toggle)


# Param test
b=box()
b.color="red"
b.color=:pink
b.color(:blue)
b.color("green")

# infos test
b=box()
p b
p b.id
p b.atome_id
p b.atome
p b


# grab test
b=box()
grab(b.atome_id).color(:blue)
c=circle()
get(c.id).x(200).y(120).color(:green)


# chain test
b=box
b.color(:yellow).x(200).y(100)

# methods test
run
b=box()
box({color: :red, x: 150})
box(200,200)

b.color="green"
b.touch do
  alert "good"
end

# file tests
create(:project ,:myscript) # create a new sript
store(:myfile , "file content")
store({newfile:  "content to store"})
load :myscript #load the script and replace conetnt of the ide

puts Atome.current_project # print the name of the project on screen


# event test
b=box()
b.touch do
  b.color(:yellow)
end

#drag test
b=box()
b.drag()

#sleep test
b=circle()
render
sleep 1
b.color(:orange).x(70).y(200)
render
sleep 2
b.color(:red).x(170).y(90)
render
sleep 0.1
b.color(:blue).x(70).y(90)
render
sleep 0.1
b.color(:pink).x(70).y(90)
i=0


#list atomes
b=box()
c=cirle()
puts Atome.atomes

#print atome_id
b=box()
puts b.atome_id

#event with self
b=box()
c=circle
b.touch do
  self.color="red"
  c.x=200
end

#not loaded as code
clear
create(:project, :file)
load :file, `flash`
puts Atome.current_project
# should puts the id of the current project not the one of the loaded one

#timeout
timeout(2000) do
  alert('ok!!')
end

#nonymous-user test
puts Atome.user # after and before login

#user basic
Atome.set(:user,  :my_new_user)
p Atome.user

#triangle
triangle()

#bloob
bloob()

#squiggle
squiggle()

# test set
Atome.set(:user,  :JohnDoe)
puts Atome.user
Atome.set({user:  :joahnna})
puts Atome.user
b=box()
b.set({id: :my_identity})
p b.id
b.set(:color , :green)
p b.color

#read_bufferize_find
b=box()
p fiind "b.drag"
read "project_0"
b.drag
wait 2000 do
  index= Atome.buffer.length-1
  p  Atome.buffer[index]
end

#delete
delete :project_0

#rename
rename :project_0, :my_script