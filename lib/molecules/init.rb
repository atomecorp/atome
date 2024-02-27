# frozen_string_literal: true

module Molecule
  def new(params, &bloc)
    if params[:page]
      site_found = grab(params[:page][:application])
      site_found.clear(true)
      page_id = params[:page][:name]
      site_found.box({ id: page_id })
    elsif params[:application]

      footer_header_size=33
      footer_header_color=color({red: 0, green: 0, blue: 0, id: :footer_header_color})

      if params[:header]
        top = footer_header_size
        header=box({ left: 0, right: 0, width: :auto, top: 0, height: top, id: :header })
        # header.attach(:footer_header_color)
      else
        top = 0
        end
        if params[:footer]
          bottom = footer_header_size
          box({ left: 0, right: 0, width: :auto, top: :auto, bottom: 0, height: bottom, id: :footer })
        else
          bottom = 0
        end
        box({ left: 0, right: 0, width: :auto, top: top, bottom: bottom, height: :auto, id: params[:application] })
        elsif params[:module]

      end
      super if defined?(super)
    end
  end

  class Object
    include Molecule
  end

  # tests
  # new({application: :compose, header: true, footer: true })
  #
  # new(page: {name: :home, application: :compose, attach: :root })
  #
  # new(module: {name: :home, application: :compose, attach: :root })






