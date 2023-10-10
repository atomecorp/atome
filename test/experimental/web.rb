#  frozen_string_literal: true
shadow({ renderers: [:browser], id: :default_shadow, type: :shadow,
         left: 0, top: 0, blur: 18,
         red: 0, green: 0, blue: 0, alpha: 0
       })

shadow({ renderers: [:browser], id: :article_shadow, type: :shadow, direction: :inset,
         left: 0, top: 0, blur: 9,
         red: 0, green: 0, blue: 0, alpha: 0
       })

class Atome

  def default_values
    {
      article_margin: 0,
      header_height: 99,
      footer_height: 33,
      back_color: { red: 1, green: 1, blue: 1 },
      alternate_color: { red: 226 / 255, green: 213 / 255, blue: 242 / 255 },
    }
  end

  def default_style

    {

      site: {
        role: :site,
        color: :white,
        left: 0,
        right: 0,
        width: :auto,
        height: :auto,
        top: 0,
        bottom: 0,
        # shadow: true,
        attach: self.id,
        international: {},
      },
      header: {
        role: :header,
        depth: 1,
        color: default_values[:alternate_color],
        left: 0,
        right: 0,
        width: :auto,
        top: 0,
        height: default_values[:header_height],
        # attached: :default_shadow,
        id: :header,
      },
      footer: {
        role: :footer,
        depth: 5,
        color: default_values[:alternate_color],
        bottom: 0,
        left: 0,
        right: 0,
        top: :auto,
        width: :auto,
        height: default_values[:footer_height],
        # attached: :default_shadow,
        id: :footer,

      },
      page: {
        role: :page,
        # color: default_values[:back_color],
        color: default_values[:back_color],
        bottom: default_values[:footer_height],
        depth: 0,
        left: 0,
        right: 0,
        top: default_values[:header_height],
        width: :auto,
        height: :auto,
        id: :body,
        overflow: :auto,
        attach: self.id
      },
      article: {
        role: :article,
        color: default_values[:back_color],
        # color: :red,
        left: 0,
        right: 0,
        top: 0,
        width: :auto,
        height: 200,
        overflow: :visible,
      },
      content: {
        visual: { size: 16 },
        symbol: { font: 'Roboto ', type: 'ThinItalic' }
      },
      title: {
        top: (default_values[:header_height] / 2) - 9,
        visual: { size: 18 },
        symbol: { font: 'Roboto ', type: 'ThinItalic' }
      },
      map: {
        top: 0,
        left: 0
      }
    }

  end

  def new(params)
    params = { params => {} } unless params.instance_of? Hash
    atomes_created = []
    params.each do |new_atome, atome_params|
      atomes_created << self.send(new_atome, atome_params)
    end
    atomes_created.last
  end

  def site(params = {})
    @sites ||= {}
    params[:id] = "my_site_#{@sites.length}" unless params[:id]
    grab(:view).state({ site: params[:id] })
    default_params = default_style[:site].merge(params)
    new_site = box(default_params)
    new_site.state = {}
    new_site.init_articles
    @site = new_site
    @sites[params[:id]] = @site
    @site.initialize
    # now we return the object
    @site
  end

  def header
    self.box(default_style[:header])
  end

  def footer
    self.box(default_style[:footer])
  end

  def page(user_params = {})
    @pages ||= {}
    user_params[:id] = "page_#{@pages.length}" unless user_params[:id]
    params = default_style[:page].merge(user_params)
    title_found = params.delete(:title)
    title_found = { international: { english: title_found } } unless title_found.instance_of? Hash
    # TODO: Left pos must be logo width+ max title width
    title_found = default_style[:title].merge(title_found)
    if @pages.length == 0
      current_page(params[:id])
      @pages[params[:id]] = params
      title_found = title_found.merge({ left: 90 + @pages.length * 100, link: params[:id], attach: current_site })
      title(title_found)
      return self.box(params)
    else
      @pages[params[:id]] = params
    end
    title_found = title_found.merge({ left: 90 + @pages.length * 100, link: params[:id], attach: current_site })
    title(title_found)
  end

  def pages
    @pages
  end

  def add_articles(articles_to_add)
    articles_to_add.each do |article_to_add|
      @articles.delete(article_to_add)
    end
  end

  def remove_articles(articles_to_remove)
    articles_to_remove.each do |article_to_remove|
      @articles.delete(article_to_remove)
    end

  end

  def init_articles
    @articles = {}
  end

  def articles
    @articles
  end

  def separator(params)
    @separator = params
  end

  def article(params)

    host_pages = params.delete(:pages)
    article_id = "article_#{articles.length}"

    # now we add article to the current_site
    articles[article_id] = params
    # now we attach articles to corresponding pages
    host_pages.each do |host_page|
      @pages[host_page][:articles] = [] unless @pages[host_page][:articles]
      @pages[host_page][:articles] << article_id
    end

    # TODO : we must add article to current page and refresh
    display_articles(@current_page)
  end

  def current_language
    # FIXME: very unreliable way to to get the languqge
    # if multiple parent it may have unexpected results
    if role != :site
      grab(attach.last).current_language
    else
      grab(attach.last).language
    end
  end

  def current_site
    if role != :site
      grab(attach.last).current_site
    else
      self.id
    end
  end

  def current_page(page_id)
    if page_id
      @current_page = page_id
    else
      @current_page
    end

  end

  def position_article(articles_list)
    separator_height = grab(current_site).instance_variable_get('@separator')[:height]
    offset_top = 25

    found_width = grab(:view).realWidth
    if found_width < 480
      puts "==> responsive : #{found_width}"
    else
      puts "===> #{found_width}"
    end
    articles_list&.each do |article_id|
      article_found = grab(article_id)
      ratio_found = article_found.ratio

      if found_width > 900
        found_height = 999 * ratio_found
        article_found.height = found_height
        grab("#{article_id}_layout").resize(999, found_height)
        article_found.top(offset_top)
        offset_top = offset_top + (article_found.height) + (separator_height * ratio_found)
        # grab(@current_page).width(999)
        # grab(@current_page).width('100%')
        # grab(@current_page).center(x: true)
        full_width = grab(:view).realWidth
        grab(@current_page).left((full_width - 999) / 2)
        # grab(@current_page).left(full_width-999)
      else
        grab(@current_page).left(0)
        found_height = found_width * ratio_found
        article_found.height = found_height
        grab("#{article_id}_layout").resize(found_width, found_height)
        article_found.top(offset_top)
        offset_top = offset_top + (article_found.height) + (separator_height * ratio_found)
        # article_found.top(offset_top)
        # grab(@current_page).width(999)
        # grab(@current_page).center(x: true)
        #       grab(@current_page).width(:auto)
        #       grab(@current_page).height(:auto)
        # grab(@current_page).top(0)
        # grab(@current_page).left(0)
        # grab(@current_page).bottom(0)
        # grab(@current_page).right(0)
      end

      # offset_top = offset_top + article_found.height
    end
  end

  def display_articles(page_id)

    page_found = grab(page_id)
    articles_list = grab(current_site).instance_variable_get("@pages")[page_id][:articles]
    grab(current_site).state[:articles] = articles_list
    grab(current_site).state[:page] = page_id
    articles_list&.each do |article_id|
      unless Universe.atomes.key?(article_id)
        article_found = grab(current_site).articles.dup
        article_content = article_found[article_id].dup

        # if title_found.instance_of?(Hash)
        #   unless article_content[:title][:international]
        #     article_content[:title][:international] = { english: article_content[:title] }
        #   end
        # else
        #   article_content[:title] = { data: article_content[:title, international: { english: article_content[:title] }] }
        # end
        # alert article_content[:title]
        title_found = article_content.delete(:title)
        separator_found = article_content.delete(:separator)

        # template_found = article_content.delete(:template)
        # row_found = template_found.delete(:row) || 2
        # column_found = template_found.delete(:column) || 2

        template_found = article_content[:template]
        row_found = template_found[:row] || 2
        column_found = template_found[:column] || 2

        ratio_found = template_found[:ratio] || 1
        margin_found = template_found[:margin] || 9

        template_found[:id] = article_id

        # now lest build the template

        article_template = default_style[:article].merge(template_found)
        article_template = article_template.merge({ ratio: ratio_found })

        created_article = page_found.box(article_template)
        if article_content[:background]
          back_image = created_article.image(path: article_content[:background][:path])
          back_image.width(:auto)
          # back_image.height(500)
        end
        layout_params = {
          id: "#{article_id}_layout", left: 0, top: 0, smooth: 8, color: { alpha: 0 },
          columns: { count: column_found
          },
          rows: { count: row_found,
          },
          cells: {
            particles: { margin: margin_found, overflow: :hidden, color: default_values[:back_color], smooth: 0, shadow: { blur: 9, left: 3, top: 3, alpha: 0 } }
          }
          # cells: {
          #   particles: { margin: 9, color: :blue, smooth: 9, shadow: { blur: 9, left: 3, top: 3,id: :cell_shadow } }
          # },

        }
        article_layout = created_article.matrix(layout_params)

        # now filling the layout
        # alert article_content

        article_content.each_with_index do |(item_id, content), index|

          content_found_copy = content.dup
          location_found = content_found_copy.delete(:location)
          type_found = content_found_copy.delete(:type)
          case type_found

          when :style
            # alert
            article_layout.cell(location_found).style(content_found_copy)
          when :content

            # back=article_layout.cell(location_found).box({color: :red, left: 12, top: 12, bottom: 0, right: 0, width:'90%', height: '90%'})
            content_found_copy = default_style[:content].merge(content_found_copy)
            data_found = content_found_copy[:data]
            data_found = { international: { english: data_found } } unless data_found.instance_of? Hash
            localised_data = data_found[:international][current_language]
            localised_data = data_found[:international][:english] unless localised_data
            content_found_copy[:data] = localised_data
            content_found_copy[:id] = "#{article_id}_item_#{index}"
            # content_found_copy=content_found_copy.merge({width: 300, height: 333})
            # alert content_found_copy
            content_created = article_layout.cell(location_found).text(content_found_copy)
            content_found_copy.delete(:data)
            content_found_copy.delete(:location)
            if content_found_copy[:visual] && content_found_copy[:visual][:padding]
              padding_found = content_found_copy[:visual][:padding]

              `
                      var text_found = document.getElementById(#{content_created.id});
                 // text_found.style.padding = #{padding_found}+'px';
                 //text_found.style.paddingRight = "-152px";
                //text_found.style.marginRight = "130px";
                //text_found.style.paddingLeft = "30px";
                //text_found.style.width = "100px";
                //text_found.style.padding = #{padding_found}+'px';
                 //text_found.style.paddingLeft = "15px";
                 //Text_text_found.style.paddingLTop = "15px";
                 //text_found.style.paddingBottom = "15px";
                 //text_found.style.paddingRight = "152px";

`
            end
            content_created.set(content_found_copy)
          when :image
            # back_obj= article_layout.cell(location_found).box({top: 0, left: 0, width: '100%', color: :red})
            # back_obj.image({left: 0, top: 0}.merge(content_found_copy))

            article_layout.cell(location_found).image({ left: 0, top: 0 }.merge(content_found_copy))
          when :color
            article_layout.cell(location_found).color(content_found_copy)
          when :action
            touch_found = content_found_copy[:touch]
            current_object = article_layout.cell(location_found)
            # # current_object.over(:enter) do
            # #   current_object.color(:orange)
            # # end
            # # current_object.over(:leave) do
            # #   current_object.color(:black)
            # # end
            current_object.cursor(:pointer)
            current_object.touch(true) do
              instance_exec(&touch_found)
            end
          when :video
            back_position = { top: 0, left: 0, width: '100%', height: '100%' }
            video_position = { top: 0, left: 0, width: '100%' }
            video_support_created = article_layout.cell(location_found).box(back_position)
            content_found_copy = video_position.merge(content_found_copy)
            video_created = video_support_created.video(content_found_copy)
            if content_found_copy[:automatic] && content_found_copy[:automatic][:play] == true
              `
                var video_tag = document.getElementById(#{video_created.id});
                video_tag.autoplay = true;
                video_tag.play();
                `
            end
            player_off = article_layout.cell(location_found).image({ path: "medias/images/logos/Play.svg", center: true })
            player_off.cursor(:pointer)
            video_created.cursor(:pointer)
            video_created.touch(true) do
              video_created.play(true)
            end
            player_off.touch(true) do
              player_off.delete(true)
              video_created.play(true)
            end

          when :box

            article_layout.cell(location_found).box(content_found_copy)
          when :web
            article_layout.cell(location_found).web(content_found_copy)
            wait 1 do
              `console.clear()`
            end

          when :map
            content_found_copy = default_style[:map].merge(content_found_copy)
            map_created = article_layout.cell(location_found).box(content_found_copy)
            map_created.color({ red: 0.95, green: 0.95, blue: 0.95 })
            map_created_id = map_created.id

            coordinnate = content_found_copy[:coordinate]
            zoom = content_found_copy[:zoom]
            label = content_found_copy[:label]
            wait 0.1 do
              `
var coordinate =  #{coordinnate};
var view = #{zoom};

var map = L.map(#{map_created_id}).setView(coordinate, view);

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);

            L.marker(#{coordinnate}).addTo(map)
                .bindPopup(#{label})
                .openPopup();`
            end
          else
            ""
          end
        end
        article_layout.top(0).left(0)
      end
    end

    position_article(articles_list)
  end

  def delete_children_recursively(page)
    if grab(page)
      grab(page).attached&.each do |child_found|
        delete_children_recursively(child_found)
        grab(child_found).delete(true) if grab(child_found)
      end
    end
    grab(page).delete(true) if grab(page)
  end

  def title(params)
    params = { width: :auto }.merge(params)
    international ||= {}
    if params.instance_of? Hash
      international_found = params.delete(:international)
      international_found.each do |key_word, translation|
        international[key_word] = translation
      end
    else
      international[:english] = params
    end
    title_found = international[current_language] || international[:english]
    params = params.merge({ data: title_found, depth: 7 })
    link_found = params.delete(:link)
    attach_found = params.delete(:attach)
    full_params = default_style[:title].merge(params)
    title_created = grab(attach_found).text(full_params)
    if link_found
      title_created.cursor(:pointer)
      title_created.over(:enter) do
        title_created.color(:orange)
      end
      title_created.over(:leave) do
        title_created.color(:black)
      end

      title_created.touch(true) do
        current_site_found = grab(current_site)
        pages_found = current_site_found.pages
        pages_found.each do |page_id, page_definition|
          if page_id == link_found
            delete_children_recursively(current_site_found.current_page)
            current_site_found.current_page(link_found)
            page_call = grab(current_site).instance_variable_get("@current_page")
            new_page = current_site_found.box({ id: page_call })
            new_page.set(page_definition)
            current_page(page_call)
            display_articles(page_call)
          end
        end
      end
    end
    title_created
  end

end

##### Object level
def new(params)
  grab(:view).new(params)
end

body = grab(:view)

body.on({ event: :size }) do |event, params|
  current_site = grab(body.state[:site])
  articles_list = current_site.state[:articles]
  current_site.position_article(articles_list)
end
