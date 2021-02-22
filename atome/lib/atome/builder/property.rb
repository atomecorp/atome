# the class below initialize common property's methods and meta-create all the wanted properties API
module Properties
  def self.atome_methods
    spatial = {width: [], height: [], size: [], x: [], xx: [], y: [], yy: [], z: []}
    events = {touch: [], drag: [], over: []}
    helper = {tactile: [], display: []}
    visual = {color: [:pre], opacity: [], border: [], overflow: [:pre, :post]}
    geometry = {width: [], height: [], resize: [], rotation: []}
    effect = {blur: [], shadow: [:post]}
    identity = {atome_id: [], id: [], type: []}
    media = {content: [], image: [], sound: [], video: []}
    hierarchy = {parent: [], child: [], insert: []}
    communication = {share: []}
    utility = {add: [], delete: [], record: [], enliven: [], selector: [], render: [], preset: []}
    spatial.merge(events).merge(helper).merge(visual).merge(geometry).merge(effect).merge(identity).merge(media).merge(hierarchy).merge(communication).merge(utility)
  end

  def self.methods_genesis(method_name, options)
    # this meta-methods define behaviors for atome basic properties
    Atome.define_method method_name do |value|
      if value
        # send to pre or post processor if specified
        options.each do |option|
          Renderer.send("#{method_name}_#{option}_processor", value)
        end
        # we send to the renderer now
        RenderHtml.send(method_name, atome_id, value)
        # at last we store the new property and it's value
        instance_variable_set("@#{method_name}", value)
      else
        # no params send, we call the getter using magic_getter
        instance_variable_get("@#{method_name}")
      end
    end
    # the meta-program below create the same method as above, but add equal at the end of the name to allow assignment
    Atome.define_method method_name.to_s + "=" do |value|
      send(method_name, value)
    end
  end
end