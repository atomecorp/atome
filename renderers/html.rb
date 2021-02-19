# render methods
module Render
  def self.r_get(atome_id)
    Element.find("#" + atome_id[:value])
  end

  def self.js_get(atome)
    Element.find("#" + atome.atome_id[:value])
  end

  def self.render_render(params)
    type = params.delete(:type)
    atome_id = params.delete(:atome_id)
    case atome_id
    when :dark_matter
      r_get({value: :user_device}).append("<div class='atome' id='#{atome_id}'></div>")
    when :device
      r_get({value: :user_device}).append("<div class='atome' id='#{atome_id}'></div>")
    when :intuition
      r_get({value: :user_device}).append("<div class='atome' id='#{atome_id}'></div>")
    when :view
      r_get({value: :intuition}).append("<div class='atome' id='#{atome_id}'></div>")
    else
      case type
      when :text
        r_get({value: :view}).append("<div class='atome' style='display:inline-block' id='#{atome_id}'></div>")
      when :shape
        r_get({value: :view}).append(("<div class='atome' id='#{atome_id}'></div>"))
      when :image
        r_get({value: :view}).append("<div class='atome' id='#{atome_id}'></div>")
      when :video
        r_get({value: :view}).append("<div  id=" + atome_id + " class='atome' ><video  width='512' muted ></video></div>")
      when :audio
        r_get({value: :view}).append("<div  id=" + atome_id + " class='atome' ></div>")
      else
        r_get({value: :dark_matter}).append(("<div class='atome' id='#{atome_id}'></div>"))
      end
    end
    atome = grab(atome_id)
    params.each do |key, value|
      Render.send("render_#{key}", atome, value)
    end
  end

  def self.render_language(*params)
    puts params
  end

  def self.render_preset(*params)
    puts params
  end

  def self.render_atome_id(*params)
    puts params
  end

  def self.type(*params)
    puts params
  end

  def self.render_tactile(*params)
    puts params
  end

  def self.render_id(*params)
    puts params
  end

  def self.render_content(*params)
    puts params
  end

  def self.render_parent(*params)
    puts params
  end

  def self.render_width(atome, params)
    r_get(atome.atome_id).css(:width, params)
  end

  def self.render_height(atome, params)
    r_get(atome.atome_id).css(:height, params)
  end

  def self.render_x(atome, params)
    if !atome.width || atome.width == :auto
      r_get(atome.atome_id).css(:width, :auto)
    end
    r_get(atome.atome_id).css(:left, params)
  end

  def self.render_xx(atome, params)
    if !atome.width || atome.width == "auto"
      r_get(atome.atome_id).css("width", "auto")
    else
      r_get(atome.atome_id).css("left", "auto")
    end
    r_get(atome.atome_id).css("right", params)
  end

  def self.render_y(atome, params)
    if !atome.height || atome.height == :auto
      r_get(atome.atome_id).css(:height, :auto)
    end
    r_get(atome.atome_id).css(:top, params)
  end

  def self.render_yy(atome, params)
    if !atome.height || atome.height == "auto"
      r_get(atome.atome_id).css("height", "auto")
    else
      r_get(atome.atome_id).css("top", "auto")
    end
    r_get(atome.atome_id).css("bottom", params)
  end

  def self.render_z(atome, params)
    r_get(atome.atome_id).css("z-index", params)
  end

  def self.render_color(atome, params)
    color = "background-image"
    value = ""
    if params.instance_of?(String)
      value = " linear-gradient(0deg," + params + ", " + params + ")"
    end
    r_get(atome.atome_id).css(color, value)
  end

  def self.render_overflow(atome, params)
    if params.instance_of?(Hash)
      x = params[:x]
      y = params[:y]
      if x
        r_get(atome.atome_id).css("overflow-y", :visible)
        r_get(atome.atome_id).css("overflow-x", :visible)
      end
      if y
        r_get(atome.atome_id).css("overflow-y", y)
      end
    else
      r_get(atome.atome_id).css("overflow", params)
    end
  end
end