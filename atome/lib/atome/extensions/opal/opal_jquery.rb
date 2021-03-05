class Element
  def create(parent)
    `atome.jsCreateVideo(#{parent})`
  end


end

module Events
  #def self.update_values params
  #  @x = params[0]
  #  @y = params[1]
  #  # we update current_atome position
  #  #puts ("from opal_addon : we update current_atome position")
  #  return self
  #end

  def playing(proc, evt)
    @time = evt
    #evt = Events.update_values(evt)
    proc.call(evt) if proc.is_a?(Proc)
  end
end