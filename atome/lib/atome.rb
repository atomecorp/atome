require "atome/core/neutron"
require "atome/core/proton"
require "atome/core/photon"
require "atome/core/nucleon"
require "atome/core/electron"


class Atome < Nucleon::Core::Nucleon
  # S.A.G.E.D methods
  #def set params = nil, refresh = true, &proc
  #  if params.class == Hash
  #    if params[:type] && params[:type] == :text
  #      params = reorder_properties(params)
  #      #we invert hash order but why?
  #      params = params.to_a.reverse.to_h
  #    end
  #
  #    params.each do |property, value|
  #      send(property, value, refresh, false, &proc)
  #    end
  #  elsif params.class == Array
  #    params.each do |param|
  #      if param.class == Hash
  #        param.keys.each do |key|
  #          send(key, param[key], refresh, false, &proc)
  #        end
  #      elsif param.class == Array
  #        puts "todo : create recursive treatment of prop's array"
  #      end
  #    end
  #  else
  #    property = params
  #    send(property, nil, refresh, false, &proc)
  #  end
  #end
  #
  #def add params, refresh = true, &proc
  #  if params.class == Hash
  #    params.each do |property, value|
  #      # send :  first is the function call, second is the value, third is to refresh the view fourth to add/stack the prop or replace, and last is the proc if present
  #      send(property, value, refresh, true, &proc)
  #    end
  #  elsif params.class == String || Symbol
  #    property = params
  #    send(property, nil, refresh, true, &proc)
  #  end
  #end
  #
  #def get params = nil
  #  if params
  #    if params.class == String || params.class == Symbol
  #      Object.get(params)
  #    end # we check if user try to get the object by id
  #  else
  #    self
  #  end
  #end
  #
  #def enliven(params = nil, refresh = true)
  #  @@black_hole.each do |atome_deleted|
  #    if atome_deleted && (atome_deleted.atome_id.to_sym == atome_id.to_sym)
  #      @@black_hole.delete(self)
  #      if refresh
  #        properties.each do |property|
  #          property.each do |key, value|
  #            key = key.to_sym
  #            if key == :group
  #              @group = value
  #            elsif key == :parent
  #              @parent = value
  #            elsif key == :child
  #              @child = value
  #            elsif key == :atome_id
  #            elsif key == :render
  #              @render = value
  #            else
  #              if value.class == Array
  #                value.each do |val|
  #                  send(key, val)
  #                end
  #              else
  #                send(key, value)
  #              end
  #            end
  #          end
  #        end
  #      end
  #      if @parent != nil &&  @parent != []
  #        @parent.each do |parent_found|
  #          if parent_found != nil
  #            @@atomes << self
  #            find({value: parent_found, property: :atome_id, scope: :view}).insert(self)
  #          end
  #        end
  #      end
  #
  #      if @child && @child.length > 0
  #        @child.each do |child_found|
  #          alert "message :\n#{dig(child_found)}\n from : atome.rb : 173"
  #          #find({value: child_found, property: :atome_id, scope: :all}).enliven(true)
  #          dig(child_found).enliven(true)
  #        end
  #      end
  #    end
  #  end
  #  #we re attach to parent #fixme the preset already attach to view so we can optimise to immediatly attach to parent instead
  #end
  #
  #def delete params = nil, refresh = true
  #  if id==:view
  #    #alert "message :\n#{':couille dans le potage !!!'}\n from : atome.rb : 185"
  #  else
  #    #alert "message :\nparams:#{params},\n#{atome_id} : #{id}\nfrom : atome.rb : 187"
  #    if params || params == false
  #      if params.class == Atome # here we delete the whole atome
  #        # the strategy is to delete all atomes then add them to the @atomes array except the deleted one
  #        atomes = []
  #        @@atomes.each do |atome_found|
  #          if atome_found.id.to_sym == params.id.to_sym
  #            # the line below insert into array or update/replace if already exit in array
  #            @@black_hole |= [atome_found]
  #            #@@atomes.delete(atome)
  #            # now we delete all child
  #            atome_found.child.each do |child_found|
  #              child_found&.delete(true)
  #            end
  #          else
  #            atomes << atome
  #          end
  #        end
  #        alert "message :\n#{@@atomes}\n from : atome.rb : 205"
  #        @@atomes = atomes
  #      elsif params.class == Hash
  #        property = params.keys[0]
  #        new_prop_array = []
  #        case property
  #        when :selector
  #          selector.each do |value|
  #            new_prop_array << value if value != value_to_remove
  #          end
  #          @selector = new_prop_array
  #        end
  #      elsif params == false
  #        alert "message is \n\n#{"sure?"} \n\nLocation: atome.rb, line 220"
  #        get(:view).enliven(atome_id)
  #      elsif params.class == Boolean || params.to_sym == :true
  #        # now we delete all child
  #        self.child&.each do |child_found|
  #          child_found&.delete(true)
  #        end
  #
  #        ## #we remove object from view(:child)
  #        #grab(:view).child().each do |child_found|
  #        #  if child_found
  #        #    grab(:view).ungroup(child_found) if child_found.atome_id == self.atome_id
  #        #  end
  #        #end
  #        # we delete all the dynamic actions :
  #        # - first the dynamic actions centering object
  #        grab(:actions).resize_actions[:center].delete(self)
  #        # the line below insert into array or update/replace if already exit in array
  #        # we add the deleted object to the blackhole
  #        @@black_hole |= [self]
  #        # we remove objet from the atomes list
  #        @@atomes.delete(self)
  #      end
  #      Render.render_delete(self, params) if refresh
  #    else
  #      @@black_hole
  #    end
  #  end
  #
  #end

end

require "atome/big_bang"