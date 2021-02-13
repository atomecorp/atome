# here the methods to create default values, properties and presets to atome objects
module Nucleon
  module Core

    module Pi

      #We use call variable here so user can change default value using Pi.presets method
      @@visual = {}
      @@shape = @@visual.merge({})
      @@box = @@visual.merge(@@shape)
      @@circle = @@visual.merge(@@shape).merge({})
      @@text = @@visual.merge({})
      @@image = @@visual.merge({})
      @@video = @@visual.merge({})
      @@audio = @@visual.merge({})
      @@particle = {}
      @@tool = @@visual.merge({})
      @@web = @@visual.merge({})
      @@user = @@visual.merge({})
      @@color = {}
      @@shadow = {}
      @@border = {}
      @@blur = {}

      def self.types
        visual = {color: :lightgray, center: {y: 43, x: 16, dynamic: false}, z: 0, overflow: :visible, parent: :view}.merge(@@visual)
        shape = visual.merge({type: :shape, width: 70, height: 70, content: {points: 2}}).merge(@@shape)
        box = visual.merge(shape).merge(content: {points: 4}).merge(@@box)
        circle = visual.merge(shape).merge({color: :red, content: {points: 4, tension: "100%"}}).merge(@@circle)
        text = visual.merge({type: :text, color: 'rgb(124,124,124)', size: 25, content: lorem}).merge(@@text)
        image = visual.merge({type: :image, color: :transparent, content: :atome}).merge(@@image)
        video = visual.merge({type: :video, color: :transparent, content: :atome}).merge(@@video)
        audio = visual.merge({type: :audio, color: :transparent, content: :atome}).merge(@@audio)
        particle = {type: :particle, content: nil}.merge(@@particle)
        collector = {type: :collector, content: nil}.merge(@@particle)
        tool = visual.merge({type: :tool, width: 52, height: 50, parent: :intuition, content: :dummy}).merge(@@tool)
        web = visual.merge({type: :web, color: :transparent, content: :atome}).merge(@@web)
        user = visual.merge({type: :user, color: :transparent, name: :anonymous, pass: :none, content: :anonymous}).merge(@@user)
        color = {content: :black}.merge(@@color)
        history={}
        autorisation={creator: :atome, read: :all, write: :all}#only set only creator can change it unless specfic authoration set by creator()
        shadow = {x: 0, y: 0, blur: 7, thickness: 0, color: 'rgba(0,0,0,0.3)', invert: false}.merge(@@shadow)
        border = {thickness: 1, pattern: :solid, color: :red}.merge(@@border)
        blur = {default: 5}.merge(@@blur)


        types = {
            shape: shape,
            box: box,
            circle: circle,
            text: text,
            image: image,
            video: video,
            audio: audio,
            particle: particle,
            collector: collector,
            tool: tool,
            web: web,
            user: user,
            color: color,
            history: history,
            autorisation: autorisation,
            shadow: shadow,
            border: border,
            blur: blur,

        }
        return types
      end

      def self.presets params = nil
        if params
          key_found = params.keys[0].to_s
          values_found = params.values[0]
          new_value = class_variable_get("@@#{key_found}").merge(values_found)
          class_variable_set("@@#{key_found}", new_value)
        else
          return types
        end
      end
    end
  end
end


