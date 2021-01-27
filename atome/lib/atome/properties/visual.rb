## here the methods to add spatials and visuals properties to atome objects
#  the module below contains all the specifics code for properties
module Visual_processor
  include Properties

  def color_processing(params)
    alert "color processed#{params}"
  end

  def border_processing(params)
    # puts "border processed#{params}"
  end

  def atome_id_processing(params)
    puts "atome_id DSP is #{params}"
  end

end
module Nucleon
  module Core
    module Photon
      def initialize
        @align = {}
      end

      def render params = nil, refresh = true
        if params || params == false
          if params == false || params == :false
            delete(true)
          else
            a_found=[]
            Atome.atomes.each do |atome|
              a_found << atome.id
            end
            unless a_found.include? atome_id
              enliven(true)
            end
          end
          @render = params
        else
          @render
        end
      end

      def render= params = nil, refresh = true
        render(params, refresh)
      end

      #def display params = nil, refresh = true
      #  alert params
      #end
      def color params = nil, refresh = true
        if params || params == false
          if params.class== Hash && params[:add]
            if self.color.class == String || self.color.class == Symbol || self.color.class == Hash
              prop_array = []
              prop_array << @color
              prop_array << params
              @color = prop_array
            else
              @color << params
            end
          else
            @color = params
          end
          broadcast(atome_id => {color: params, private: false})
          if refresh
            # we add two condtion to render the object first if we want to refreshit , sencond if type exist (to avoid qending properties to the veiw when the obejct is not present in the view)
            Render.render_color(self, params) if refresh
          end
          return self
        else
          @color
        end
      end

      def color= params = nil, refresh = true
        color(params, refresh)
      end

      def opacity params = nil, refresh = true
        if params || params == false
          @opacity = params
          broadcast(atome_id => {opacity: params, private: false})
          if refresh
            Render.render_opacity(self, params) if refresh
          end
          return self
        else
          @opacity
        end
      end

      def opacity= params = nil, refresh = true
        opacity(params, refresh)
      end

      #spatial utilities

      def resize_actions params = nil
        if params
          params.each do |key, value|
            grab(:actions).resize_actions[key] = value
          end
        else
          if atome_id == :actions
            if @resize_actions.class == NilClass
              @resize_actions = {}
            else
              @resize_actions
            end
          else
            grab(:actions).resize_actions
          end
        end
      end

      def viewer_actions
        grab(:view).resize do
          grab(:actions).resize_actions[:center]&.each do |atome, action|
            atome.centering(:x, atome.x[:center], atome.x[:reference], atome.x[:dynamic]) if atome.x[:center]
            atome.centering(:y, atome.y[:center], atome.y[:reference], atome.y[:dynamic]) if atome.y[:center]
          end
        end
      end

      #spatial

      def centering(axis, params, reference, dynamic)
        if reference.nil?
          parent = if self.parent
                     self.parent[0] #is a quick and dirt patch to get the first parent as the referernt for centering
                   else
                     grab(:view)
                   end
        else
          parent = grab(reference)
        end
        parent_width = parent.value(:width)
        parent_height = parent.value(:height)
        #below we add a default size of 0 id it isn't alredy setted to avoid crashes
        self_width = if value(:width)
                       value(:width)
                     else
                       0
                     end
        self_height = if value(:height)
                        value(:height)
                      else
                        0
                      end
        if axis == :x
          x = (parent_width - self_width) / 2
          @x[:content]=x
          Render.render_x(self, x)
        end
        if axis == :y
          y = (parent_height - self_height) / 2
          @y[:content]=y
          Render.render_y(self, y)
        end
      end

      def center params = nil, refresh = true
        if params == false || params == :false
          grab(:actions).resize_actions[:center][self]&.delete(:x)
          @x.delete(:center)
          grab(:actions).resize_actions[:center][self]&.delete(:y)
          @y.delete(:center)
        elsif params && grab(:actions)

          grab(:actions).resize_actions[:center] = {} unless grab(:actions).resize_actions[:center]
          # todo : make set an offset to x or y position (ex : center({x: 20, y: -10}))
          if params.class == Hash
            if params[:x]
              x({center: params[:x]})
              if params[:dynamic] != false && params[:dynamic] != :false
                grab(:actions).resize_actions[:center][self] = {} unless grab(:actions).resize_actions[:center][self]
                grab(:actions).resize_actions[:center][self][:x] = @x[:center]
              else
                # we delete the dynamic re centering facility
                grab(:actions).resize_actions[:center][self]&.delete(:x)
                @x.delete(:center)
              end
            end
            if params[:y]
              y({center: params[:y]})
              if params[:dynamic] != false && params[:dynamic] != :false
                grab(:actions).resize_actions[:center][self] = {} unless grab(:actions).resize_actions[:center][self]
                grab(:actions).resize_actions[:center][self][:y] = @y[:center]
              else
                # we delete the dynamic re centering facility
                grab(:actions).resize_actions[:center][self]&.delete(:y)
                @y.delete(:center)
              end
            end
            if params[:dynamic] == false
              grab(:actions).resize_actions[:center][self]&.delete(:x)
              @x.delete(:center)
              grab(:actions).resize_actions[:center][self]&.delete(:y)
              @y.delete(:center)
            elsif params[:dynamic] == true
              x({center: 0})
              y({center: 0})
              grab(:actions).resize_actions[:center][self] = {} unless grab(:actions).resize_actions[:center][self]
              grab(:actions).resize_actions[:center][self][:x] = @x[:center]
              grab(:actions).resize_actions[:center][self] = {} unless grab(:actions).resize_actions[:center][self]
              grab(:actions).resize_actions[:center][self][:y] = @y[:center]
            end
          elsif params.class == Integer || params.class == Number
            x({center: params})
            y({center: params})
            grab(:actions).resize_actions[:center][self][:x] = @x[:center]
            grab(:actions).resize_actions[:center][self][:y] = @y[:center]
          elsif params == true || params == :true
            x({center: 0})
            y({center: 0})
            if grab(:actions).resize_actions[:center][self].nil?
              grab(:actions).resize_actions[:center][self] = {x: 0}
              grab(:actions).resize_actions[:center][self] = {y: 0}
            elsif grab(:actions).resize_actions[:center] == {}
              grab(:actions).resize_actions[:center][self][:x] = 0
              grab(:actions).resize_actions[:center][self][:y] = 0

            else
              grab(:actions).resize_actions[:center][self][:x] = 0
              grab(:actions).resize_actions[:center][self][:y] = 0
            end

          elsif params.to_sym == :x
            x({center: 0})
            if grab(:actions).resize_actions[:center] == {}
              grab(:actions).resize_actions[:center] = {self => {x: 0}}
            elsif grab(:actions).resize_actions[:center][self].nil?
              grab(:actions).resize_actions[:center][self] = {x: 0}
            else
              grab(:actions).resize_actions[:center][self][:x] = 0
            end
          elsif params.to_sym == :y
            y({center: 0})
            if grab(:actions).resize_actions[:center] == {}
              grab(:actions).resize_actions[:center] = {self => {y: 0}}
            elsif grab(:actions).resize_actions[:center][self].nil?
              grab(:actions).resize_actions[:center][self] = {y: 0}
            else
              grab(:actions).resize_actions[:center][self][:y] = 0
            end
          end
        end
        self
      end

      def center= params = nil, refresh = true
        center(params, refresh)
      end

      def x params = nil, refresh = true
        if params || params == false
          broadcast(atome_id => {x: params, private: false})
          #the line below create the hash for the x property
          @x = {} if @x.nil?
          if params.class == Integer || params.class == Number
            # if the y property is set using an integer then the center property is cleared
            @x.delete(:center)
            @x.delete(:dynamic)
            #we add the current value in the content
            params = {content: params}
            value = params
          elsif (params.class == String || params.class == Symbol) && params.to_sym == :center
            params = {center: 0}
          end
          params.each do |key, value|
            @x[key] = value
          end
          if @x[:center]
            # now we center the object
            #todo calculate the center with the offset  : @x[:center] = @x[:center] + params[:content]
            centering(:x, @x[:center], @x[:reference], @x[:dynamic])
          end
          #below we send the params into resize action class variable, so if the view size change the object position is re calculated
          grab(:actions).resize_actions[:center] = {self => {x: @x[:center]}} if @x[:dynamic] && @x[:center]
          if params[:dynamic] == false
            # we delete the dynamic re centering facility
            grab(:actions).resize_actions[:center][self]&.delete(:x)
            @x.delete(:center)
          end
          # now we assign the value
          Render.render_x(self, params[:content]) if refresh
          return self
        else
          @x
        end
      end

      def x= params = nil, refresh = true
        x(params, refresh)
      end

      def y params = nil, refresh = true
        if params || params == false
          #the line below create the hash for the y property
          @y = {} if @y.nil?
          if params.class == Integer || params.class == Number
            # if the y property is set using an integer then the center property is cleared
            @y.delete(:center)
            @y.delete(:dynamic)
            #we add the current value in the content
            params = {content: params}
            value = params
          elsif (params.class == String || params.class == Symbol) && params.to_sym == :center
            params = {center: 0}
          end
          params.each do |key, value|
            @y[key] = value
          end
          if @y[:center]
            # now we center the object
            #todo calculate the center with the offset  : @y[:center] = @y[:center] + params[:content]
            centering(:y, @y[:center], @y[:reference], @y[:dynamic])
          end
          #below we send the params into resize action class variable, so if the view size change the object position is re calculated
          grab(:actions).resize_actions[:center] = {self => {y: @y[:center]}} if @y[:dynamic] && @y[:center]
          if params[:dynamic] == false
            # we delete the dynamic re centering facility
            grab(:actions).resize_actions[:center][self]&.delete(:y)
            @y.delete(:center)
          end
          # now we assign the value
          broadcast(atome_id => {y: params, private: false})
          Render.render_y(self, params[:content]) if refresh
          return self
        else
          @y
        end
      end

      def y= params = nil, refresh = true
        y(params, refresh)
      end

      def left params = nil, refresh = true
        x(params, refresh)
      end

      def left= params = nil, refresh = true
        x(params, refresh)
      end

      def xx params = nil, refresh = true
        if params || params == false
          @xx = {} if @xx.nil?
          if params.class == Integer || params.class == Number
            # if the y property is set using an integer then the center property is cleared
            @xx.delete(:center)
            @xx.delete(:dynamic)
            #we add the current value in the content
            params = {content: params}
            value = params
          elsif (params.class == String || params.class == Symbol) && params.to_sym == :center
            params = {center: 0}
          end
          params.each do |key, value|
            @xx[key] = value
          end
          if @xx[:center]
            # now we center the object
            #todo calculate the center with the offset  : @x[:center] = @x[:center] + params[:content]
            centering(:x, @xx[:center], @xx[:reference], @xx[:dynamic])
          end
          #below we send the params into resize action class variable, so if the view size change the object position is re calculated
          grab(:actions).resize_actions[:center] = {self => {x: @x[:center]}} if @x[:dynamic] && @x[:center]
          if params[:dynamic] == false
            # we delete the dynamic re centering facility
            grab(:actions).resize_actions[:center][self]&.delete(:x)
            @x.delete(:center)
          end
          ## now we assign the value
          broadcast(atome_id => {xx: params, private: false})
          Render.render_xx(self, params[:content]) if refresh
          return self
        else
          @xx
        end
      end

      def xx= params = nil, refresh = true
        xx(params, refresh, )
      end

      def right params = nil, refresh = true
        xx(params, refresh, )
      end

      def right= params = nil, refresh = true
        xx(params, refresh)
      end

      def top params = nil, refresh = true
        y(params, refresh)
      end

      def top= params = nil, refresh = true
        y(params, refresh)
      end

      def yy params = nil, refresh = true
        if params || params == false
          @yy = {} if @yy.nil?
          if params.class == Integer || params.class == Number
            # if the y property is set using an integer then the center property is cleared
            @yy.delete(:center)
            @yy.delete(:dynamic)
            #we add the current value in the content
            params = {content: params}
            value = params
          elsif (params.class == String || params.class == Symbol) && params.to_sym == :center
            params = {center: 0}
          end
          params.each do |key, value|
            @yy[key] = value
          end
          if @yy[:center]
            # now we center the object
            #todo calculate the center with the offset  : @x[:center] = @x[:center] + params[:content]
            centering(:x, @yy[:center], @yy[:reference], @yy[:dynamic])
          end
          #below we send the params into resize action class variable, so if the view size change the object position is re calculated
          grab(:actions).resize_actions[:center] = {self => {y: @y[:center]}} if @y[:dynamic] && @y[:center]
          if params[:dynamic] == false
            # we delete the dynamic re centering facility
            grab(:actions).resize_actions[:center][self]&.delete(:y)
            @y.delete(:center)
          end
          ## now we assign the value
          broadcast(atome_id => {yy: params, private: false})
          Render.render_yy(self, params[:content] ) if refresh
          return self
        else
          @yy
        end
      end

      def yy= params = nil, refresh = true
        yy(params, refresh)
      end

      def bottom params = nil, refresh = true
        yy(params, refresh)

      end

      def bottom= params = nil, refresh = true
        yy(params, refresh)
      end

      def z params = nil, refresh = true
        if params || params == false
          @z = params
          broadcast(atome_id => {z: params, private: false})
          if refresh
            Render.render_z(self, params) if refresh
          end
          return self
        else
          @z
        end
      end

      def z= params = nil, refresh = true
        z(params, refresh)
      end

      #geometry
      def width params = nil, refresh = true
        if params || params == false
          @width = params
          broadcast(atome_id => {width: params, private: false})
          if refresh
            Render.render_width(self, params) if refresh
          end
          return self
        else
          @width
        end
      end

      def width= params = nil, refresh = true
        width(params, refresh)
      end

      def height params = nil, refresh = true
        if params || params == false
          @height = params
          broadcast(atome_id => {height: params, private: false})
          if refresh
            Render.render_height(self, params) if refresh
          end
          return self
        else
          @height
        end
      end

      def height= params = nil, refresh = true
        height(params, refresh)
      end

      def size params = nil, refresh = true
        if params || params == false
          @size = params
          broadcast(atome_id => {size: params, private: false})
          if refresh
            Render.render_size(self, params) if refresh
          end
          return self
        else
          @size
        end
      end

      def size= params = nil, refresh = true
        size(params, refresh)
      end

      def position params = nil, refresh = true
        if params || params == false
          @position = params
          broadcast(atome_id => {position: params, private: false})
          if refresh
            Render.render_position(self, params) if refresh
          end
          return self
        else
          @position
        end
      end

      def align params = nil, refresh = true
        if params || params == false
          if params == "invert" || params == :invert
            @align = {x: :xx, y: :yy}
          elsif params == "normal" || params == :normal
            @align = {x: :x, y: :y}
          elsif params == :x || params == x
            @align[:x] = :x
          elsif params == :y || params == y
            @align[:y] = :y
          elsif params == :x || params == x
            @align[:xx] = :xx
          elsif params == :y || params == y
            @align[:yy] = :yy
          elsif params.class == Hash
            @align = params
          end
          return self
        else
          @align
        end
      end

      def align= params = nil, refresh = true
        align(params, refresh)
      end

      def overflow params = nil, refresh = true
        if params || params == false
          @overflow = params
          broadcast(atome_id => {overflow: params, private: false})
          if refresh
            Render.render_overflow(self, params) if refresh
          end
          return self
        else
          @overflow
        end
      end

      def overflow= params = nil, refresh = true
        overflow(params, refresh)
      end

      def fill params = nil, refresh = true
        if params || params == false
          if params.class == Hash && params[:add]
            if @fill.class == Array
              @fill << params
            else
              @fill = [params]
            end
          end
          broadcast(atome_id => {fill: params, private: false})
          if refresh
            Render.render_fill(self, params) if refresh
          end
          return self
        else
          @fill
        end
      end

      def fill= params = nil, refresh = true
        fill(params, refresh)
      end

      def fit params = nil, refresh = true
        if params || params == false
          if params.class == String || params.class == Symbol || params.class == Atome
            #atome= find_atome_from_params(params)
            hashed_params = {target: params}
            params = hashed_params
          end
          if params.class == Hash && params[:add]
            if @fit.class == Array
              @fit << params
            else
              @fit = [params]
            end
          end
          target = find_atome_from_params(params[:target])
# line below (self.y) is a quick patch to patch a bug
          self.y(0)
          if params[:x]
            self.x(params[:x])
          end
          if params[:xx]
            self.width(:auto)
            self.xx(params[:xx])
          end
          if params[:y]
            self.y(params[:y])
          end
          if params[:yy]
            self.height(:auto)
            self.yy(params[:yy])
          end
          if params[:margin]
            target.x(params[:margin])
            target.y(params[:margin])
            self.width(target.value(:width) + params[:margin] * 2, refresh)
            self.height(target.value(:height) + params[:margin] * 2, refresh)
          else
            self.width(target.value(:width), refresh)
            self.height(target.value(:height), refresh)
          end
          broadcast(atome_id => {fit: params, private: false})
          return self
        else
          @fit
        end
      end

      def fit= params = nil, refresh = true
        fit(params, refresh)
      end

      #def rotate params = nil, refresh = true
      #  if params || params == false
      #    @rotate = params
      #    broadcast(atome_id => {rotate: params, private: false})
      #    if refresh
      #      Render.render_rotate(self, params) if refresh
      #    end
      #    return self
      #  else
      #    @rotate
      #  end
      #end

      #def rotate= params = nil, refresh = true
      #  rotate(params, refresh)
      #end

      ####### start new methods #######
      # specific property methods
      def rotate_proc(proc)
        # if the object property contain a Proc it'll be processed here
        proc
      end

      def rotate_rendering(params)
        # if the object property needs to be refresh then I'm your method
        Render.render_rotate(self, params) if params[:refresh].nil? || params[:refresh] == true
      end

      def rotate_processing(properties)
        # let's go with the DSP ...
        properties
      end

      def rotate_treatment(params)
        # here happen the specific treatment for the current property
        if params.class == Hash
          rotate_proc params[:proc] if params && params[:proc]
          rotate_processing params
          # if prop needs to be refresh we send it to the Render engine
          rotate_rendering params
        elsif params.class == Array
          # if params is an array is found we send each item of the array to 'rotate_treatment' as a Hash
          params.each do |param|
            rotate_treatment param
          end
        end
        broadcast(atome_id => { rotate: params })
      end

      def rotate(params = nil)
        # This is the entry point for property getter and setter:
        # this is the main entry method for the current property treatment
        # first we create a hash for the property if t doesnt exist
        # we don't create a object init time, to only create property when needed
        @rotate ||= {}
        # we send the params to the 'reformat_params' if there's a params
        method_analysis params, @rotate, :rotate if params
        # finally we return the current property using magic_return
        if params
          self
        else
          magic_return @rotate
        end
      end

      def rotate=(params = nil)
        my_prop(params)
      end

      ######## end new methods #######


      def shadow params = nil, refresh = true
        if params || params == false
          if params.class == Hash && params[:add]
            if @shadow.class == Array
              @shadow << params
            else
              @shadow = [params]
            end
          else
            @shadow = [params]
          end
          broadcast(atome_id => {shadow: params, private: false})
          if refresh
            formated_params= parse_params(params, :shadow)
            Render.render_shadow(self, formated_params) if refresh
          end
          return self
        else
          @shadow
        end
      end

      def shadow= params = nil, refresh = true
        shadow(params, refresh)
      end

      def border params = nil, refresh = true
        if params || params == false
          @border = params
          broadcast(atome_id => {border: params, private: false})
          if refresh
            Render.render_border(self, params) if refresh
          end
          return self
        else
          @border
        end
      end

      def border= params = nil
        border(params, refresh)
      end

      def smooth params = nil, refresh = true
        if params || params == false
          @smooth = params
          broadcast(atome_id => {smooth: params, private: false})
          if refresh
            Render.render_smooth(self, params) if refresh
          end
          return self
        else
          @smooth
        end
      end

      def smooth= params = nil, refresh = true
        smooth(params, refresh)
      end

      def blur params = nil, refresh = true
        if params || params == false
          @border = params
          broadcast(atome_id => {blur: params, private: false})
          if refresh
            Render.render_blur(self, params) if refresh
          end
          return self
        else
          @border
        end
      end

      def blur= params = nil, refresh = true
        blur(params, refresh)
      end

      def level params = nil, refresh = true
        if params || params == false
          @level = params
          broadcast(atome_id => {level: params, private: false})
          if refresh
            Render.render_level(self, params) if refresh
          end
          return self
        else
          @level
        end
      end

      def level= params = nil, refresh = true
        level(params, refresh)
      end

      private

    end
  end
end