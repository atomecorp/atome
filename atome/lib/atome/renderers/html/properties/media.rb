module PropertyHtml
  def content_html(value="")
    if render
      if type == :text
        value = value.to_s.gsub("\n", "<br>")
        # FIXME:children are deleted,  we must preserve them when setting html content
        jq_get(atome_id).html(value)
      elsif type == :shape
        if value[:tension]
          self.smooth(value[:tension])
        end
      elsif type == :video
        video_creator_helper(value)
      elsif type == :camera
        camera_creator_helper(value)
      elsif type == :image
        image_creator_helper(value)
      end
    end
  end
end