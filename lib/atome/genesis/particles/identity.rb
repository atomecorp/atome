# frozen_string_literal: true

new({ particle: :real, category: :identity, type: :string })
new({ particle: :type, category: :identity, type: :string })
new({ particle: :id, category: :identity, type: :string })
new({ sanitizer: :id }) do |params|
  # first we sanitize the the id below

  params = params.to_sym

  params
end
new({ particle: :name, category: :identity, type: :string })
new({ particle: :active, category: :identity, type: :boolean })
new({ particle: :markup, category: :identity, type: :string })
new({ particle: :bundle, category: :identity, type: :string })
new({ particle: :data, category: :identity, type: :string })

new({ particle: :category, category: :identity, type: :string, store: false }) do |category_names|
  category_names = [category_names] unless category_names.instance_of? Array
  category_names.each do |category_name|
    @category << category_name
  end
end
# The selection particle is used by current user to store selected atomes
new(particle: :selection, category: :identity, type: :string)

new({ read: :selection }) do |params_get|
  selector = grab(:selector)
  selector.collect = params_get
  selector
end

new(particle: :selected, category: :identity, type: :boolean) do |params|
  if params == true
    @selection_style = []
    default_style = Universe.default_selection_style
    select_style = ''
    default_style.each do |atome_f, part_f|
      select_style = send(atome_f, part_f)
    end
    @selection_style << select_style.id
    grab(Universe.current_user).selection << @id
  elsif params == false
    @selection_style&.each do |style_f|
          remove(style_f)
        end
    @selection_style = nil
    grab(Universe.current_user).selection.collect.delete(@id)
  else
    @selection_style = []
    params.each do |part_f, val_f|
      select_style = send(part_f, val_f)
      @selection_style << select_style.id
    end
    grab(Universe.current_user).selection << @id
  end
  params
end

new({ particle: :format, category: :identity, type: :string })
new({ particle: :alien, category: :identity, type: :string }) # special particel that old alien object

new({ particle: :email, category: :identity, type: :string })

