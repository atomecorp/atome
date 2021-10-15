
class Atome

  # this method to build the constraint
  def variation val
    if val
      # we send this to the source to be inform of the object to watch
      @change = { atome_id: atome_id, property: val }
      { _dynamic: { atome_id: atome_id, property: val } }
    else
      @change
    end
  end

  def on_change val, &proc
    if val
      @on_change = val
    else
      @on_change
    end
  end

  def change val, &proc
    changes = { property: val, proc: proc }
    self.on_change(changes)
  end

  ############# methods to patch below

  def y_test val
    # insert the methods below in properties_generator line 143 below pre_processor or after

    if val && val.instance_of?(Hash) && val[:_dynamic]
      # here we send the infos
      prc = Proc.new do |evt|
        self.y = evt
      end
      changes = { property: val[:_dynamic][:property], proc: prc }
      grab(val[:_dynamic][:atome_id]).on_change(changes)
    end

    if val && @on_change && @on_change[:property] == :y_test
      @on_change[:proc].call(val) if @on_change[:proc].is_a?(Proc)
      # val
    end

    y(val)
  end

  def y_test= val
    y_test val
  end

  def x_test val

    if val && val.instance_of?(Hash) && val[:_dynamic]
      # here we send the infos
      prc = Proc.new do |evt|
        self.x = evt
      end
      changes = { property: val[:_dynamic][:property], proc: prc }
      grab(val[:_dynamic][:atome_id]).on_change(changes)
    end

    if val && @on_change && @on_change[:property] == :x_test
      @on_change[:proc].call(val) if @on_change[:proc].is_a?(Proc)
    end
    x val
  end

  def x_test= val
    x_test val
  end

end

# Example:
a = text :hello
b = box({ atome_id: :the_box })
c = circle({ x_test: 300, atome_id: :the_circle })
c.drag true

# # Syntax 1 :
# b.y_test = c.variation(:x_test)
# # b.y_test = c.variation(:delete)
#
# # ex 1 :
#
# c.touch do
#   c.x_test(33)
# end
#
# wait 2 do
#   c.x_test(455)
# end

# Syntax 2 :

# # Ex 1 :

# c.change(:x_test) do
#   if c.x_test
#     b.y = c.x_test
#   end
# end

c.change(:all) do
  if c.x_test >300
    b.y = c.x_test
  end
end

# Ex 2 :
# a.drag(true)
# b.y(55)
# batch([a,c]).change(:x_test) do
#   if [a,c].x_test > 33
#     b.y = [a,c].x_test
#   end
# end

# # Syntax 3 :
#
# # Ex 1 :
# b.constraint do
#   if c.x
#     b.y = c.x
#   end
# end
#
# # Ex 2 :
# b.constraint do
#   if c.x > 20
#     b.y = c.x
#   end
# end

