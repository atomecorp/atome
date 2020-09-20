# here the main methods to create basic atome object

module Nucleon
  module Core
    class Nucleon
      include Neutron
      include Proton
      include Photon

      @@atomes = []
      @@black_hole = [] # deleted atomes
      @@buffer = []
      @@device = ''

      def initialize(params, refresh = true)
        # if not param is passed then we create a particle by default
        params = :particle unless params
        # if it's a single keyword we found the corresponding properties from Proton's preset function
        if params.class == Symbol || params.class == String
          # We get the preset name
          preset = params
          # we get the preset for shape and then default value for the preset
          params = Proton.presets[params]
          # now we inject the preset name into the hash
          @preset = preset.to_sym
        end
        # at last we generate the atome_id, the first 5 elements are systems they have specials atome_id and id
        atome_id = if @@atomes.length == 0
                     :blackhole
                   elsif @@atomes.length == 1
                     :dark_matter
                   elsif @@atomes.length == 2
                     :device
                   elsif @@atomes.length == 3
                     :intuition
                   elsif @@atomes.length == 4
                     :view
                   elsif @@atomes.length == 5
                     :actions
                   else
                     ('a_' + object_id.to_s).to_sym
                   end
        @atome_id = atome_id
        # We generate  the id below
        properties = {}
        # We create the hash property to avoid to modify the frozen 'params' Hash
        if params[:id].nil?
          generated_id = if params[:preset]
                           (params[:preset].to_s + '_' + @@atomes.length.to_s).to_sym
                         else
                           (params[:type].to_s + '_' + @@atomes.length.to_s).to_sym
                         end
          properties[:id] = generated_id
        end
        params = params.merge(properties)
        # we re order the hash to puts the atome_id type at the begining to optimise rendering
        params = reorder_properties(params)
        # #we send the collected properties to the atome
        params.each_key do |property|
          send(property, params[property], refresh)
        end
        # now we add the new atome to the atomes's list
        @@atomes << self
      end

      # S.A.G.E.D methods
      def set params = nil, refresh = true, &proc
        if params.class == Hash
          if params[:type] && params[:type]==:text
            params = reorder_properties(params)
            params = params.to_a.reverse.to_h
          end

          params.each do |property, value|
            send(property, value, refresh, false, &proc)
          end
        elsif params.class == Array
          params.each do |param|
            if param.class == Hash
              param.keys.each do |key|
                send(key, param[key], refresh, false, &proc)
              end
            elsif param.class == Array
              alert "todo : create recursive treatment of prop's array"
            end
          end
        else
          property = params
          send(property, nil, refresh, false, &proc)
        end
      end

      def add params, refresh = true, &proc
        if params.class == Hash
          params.each do |property, value|
            # send :  first is the function call, second is the value, third is to refresh the view fourth to add/stack the prop or replace, and last is the proc if present
            send(property, value, refresh, true, &proc)
          end
        elsif params.class == String || Symbol
          property = params
          send(property, nil, refresh, true, &proc)
        end
      end

      def get params = nil
        if params
          if params.class == String || params.class == Symbol
            Object.get(params)
          end # we check if user try to get the object by id
        else
          self
        end
      end

      def enliven(params, refresh = true)
        @@black_hole.each do |atome|
          if atome.atome_id.to_sym == atome_id.to_sym
            @@atomes |= [atome]
            @@black_hole.delete(atome)
          end
        end
        if refresh
          properties.each do |property|
            property.each do |key, value|
              key = key.to_sym
              if key == :group
              elsif key == :parent
              elsif key == :atome_id
              elsif key == :preset
              elsif key == :render
              else
                send(key, value)
              end

            end
          end
        end
        # we enliven childs too
        child&.each do |child|
          child.enliven(true)
        end

        # we re attach to parent #fixme the preset already attach to view so we can optimise to immedialtly attach to parent instead
        parent.each do |parent|
          parent.insert(self)
        end

      end

      def delete params = nil, refresh = true
        if params || params == false
          if params.class == Atome # here we delete the whole atome
            # the strategy is to delete all atomes then add them to the @atomes array except the deleted one
            atomes = []
            @@atomes.each do |atome|
              if atome.id.to_sym == params.id.to_sym
                # the line below insert into array or update/replace if already exit in array
                @@black_hole |= [atome]
                @@atomes.delete(atome)
                # now we delete all child
                atome.child.each do |child|
                  child&.delete(true)
                end
              else
                atomes << atome
              end
            end
            @@atomes = atomes
          elsif params.class == Hash
            property = params.keys[0]
            new_prop_array = []
            case property
            when :selector
              selector.each do |value|
                new_prop_array << value if value != value_to_remove
              end
              @selector = new_prop_array
            end
          elsif params == false
            get(:view).enliven(atome_id)
          elsif params.class == Boolean || params.to_sym == :true
            # now we delete all child
            self.child&.each do |child|
                child&.delete(true)
              end
            # the line below insert into array or update/replace if already exit in array
            # we add the deleted object to the blackhole
            @@black_hole |= [self]
            # #we remove object from view(:child)
            grab(:view).child().each do |child|
              grab(:view).ungroup(child) if child.atome_id == self.atome_id
            end
            # we delete all the dynamic actions :
            # - first the dynamic actions centering object
              grab(:actions).resize_actions[:center].delete(self)
            # we remove objet from the atomes list
            @@atomes.delete(self)
          end

          Render.render_delete(self, params) if refresh
        else
          @@black_hole
        end
      end

      # generated atomes manipulators
      def self.atomes
        @@atomes
      end

      def self.atomes=
        atomes
      end

      def self.blackhole
        @@black_hole
      end

      # modules methods to be exposed
      def self.presets params = nil
        Proton.presets params
      end

      def self.types params = nil
        Proton.types
      end

      # Helpers  methods
      def error msg
        puts msg
      end

      def self.apis
        # todo avoid conflict with electron methods that remove some function
        Atome.instance_methods - Object.methods
      end

      # Allow lazy mode to add method on the fly to automatically create the corresponding instance variable
      # ex b=box; b.my_meth(:the_value); puts b.my_meth => :the_value (@my_meth has been created)
      #      def method_missing method, params = nil, &block
      #        alert "message from : atome.rb, line :233 , method id: #{method}, object is is : #{self.id }\n\n"
      #        if params || params == false
      #          instance_variable_set("@#{method}", params)
      #        else
      #          instance_variable_get("@#{method}")
      #        end
      #      end
    end
  end
end
