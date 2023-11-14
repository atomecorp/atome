# frozen_string_literal: true

# The class Universe is used to  retrieve some data needed for the atome framework
# per example you can retrieve the list of all available particles
puts Universe.particle_list
# this give at the date 14/11/2023 :
# or the list of all available atomes
puts Universe.atomes
# this give at the date 14/11/2023 :
# as well as the list of renderer available
puts Universe.renderer_list
# this give at the date 14/11/2023 :

# Universe hold all these instance variable :

# @counter is a integer  that store the total number of atome actually active for the current user on the current machine
# @atomes = is a hash that contains  a list all atomes actually active for the current user on the current machine,
# the key is the atome ID the value is the atome object itself
# atomes_specificities
# @atome_list is a hash that contains all atome's types available
# @particle_list is a hash that contains all particle's types available
# @renderer_list is an array that contains all renderers available
# @specificities indicate to the atome framework witch atomes or particles have specificities, as all atomes and particles methods are define using lot of meta-programming, some atome and particle need special treatment, then we use specificities
# @specificities is a hash where the key is either the atome type or the particle type and the value is a proc that hold the code to be executed when the specified atome is instantiated or the particle is applied onto the atome
# @sanitizers  is a hash where the key is either the atome type or the particle type and the value is a proc holding the code to sanitize user input value before it's the value is interpreted , rendered and stored
# @history is a hash that store the history of all modification of any atome's particle that happen on the current machine for current user.
# the history hash is define as follow: the key is number of the operation  ( 0 is the first modification, 1 the second , and so on... )
# that value of the history hash contain also another hash define as follow: the key is the id of the atome altered and the value is again a new hash with three keys :
# on of the three keys is sync , the sync value hold the sync state of the alteration (sync true means that the alteration is stored and backup on a server), another keys is time, its value hold the time stamp of the alteration
# the third key is the particle altered and value is the new value of the particle
# @users = is a hash that contains all user session on the current machine

# basic usage:
# # we create a basic empty atome
a=Atome.new
# we add a bunch particles
a.renderers([:html])
a.id(:my_shape)
a.type(:shape)
a.width(33)
a.height(33)
a.top(33)
a.left(33)
# we can now add a color the atome using  apply  used to apply an atome onto another (please note that color is also an atome not a particle)
# in this case  we apply the color atome name box_color this a default color created by the system
a.apply([:box_color])
wait 2 do
  # a bit less efficient and a bit more processor intensive solution is to use the box preset, that render a box too
  b=box
  # we can add a color atome onto the new atome my_shape. as stated before for some atome types such as color, shadows ,the relation between the two atomes won't be attach and attached but  apply and affect instead the atome color with the particle red onto the
  b.color(:red)
end
