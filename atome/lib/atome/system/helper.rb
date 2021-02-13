class Helper
  def self.version
    'v:0.010'
  end

  def self.apis
    # todo avoid conflict with electron methods that remove some function
    Atome.instance_methods - Object.methods
  end

  def self.to_px(obj = nil, property = :top)
    obj = get(obj) if obj.class != Atome
    Render.render_to_px(obj, property)
  end

  # def self.batch atomes, properties
  #   get(:view).batch atomes, properties
  # end
  

end

#fixme : put whole code in Atome context to be able to remove the method below
def to_px (obj = nil, property = :top)
  Atome.to_px(obj, property)
end

# class Help
#   def self.color
#     ["a=box()\na.color(:red)"]
#   end
#   @example={}
#   @help={}
#   @usage={}
# end
# alert Help.color