# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #def back_path(default = root_path)
  #  session[:return_to] || default
  #end

  def bread_category(category)
    categories = []
    parent = category.parent
    klass = "current"
    categories << link_to(parent.title, parent, :class => klass) if parent
    categories << link_to(category.title, category, :class => klass)
    categories.join(" -- ")
  end

  def rubl(price)
    price + ' руб.'
  end

  def paginate(collection)
    content_tag :div, will_paginate(collection,
      :previous_label => "&#171; Назад",
      :next_label => "Вперед &#187;"
    ), :class => "emph"
  end

  def display_standard_flashes(message = 'Хм.. Возникли проблемы...')
    if flash[:success]
      flash_to_display, level = flash[:success], 'notice'
    elsif flash[:notice]
      flash_to_display, level = flash[:notice], 'notice'
    elsif flash[:warning]
      flash_to_display, level = flash[:warning], 'warning'
    elsif flash[:failure]
      flash_to_display, level = flash[:failure], 'error'
    elsif flash[:error]
      level = 'error'
      if flash[:error].instance_of?(ActiveRecord::Errors) || flash[:error].is_a?(Hash)
        flash_to_display = message
        flash_to_display << activerecord_error_list(flash[:error])
      else
        flash_to_display = flash[:error]
      end
    else
      return
    end
    content_tag 'div', content_tag(:span, sanitize(flash_to_display) + link_to("X", "#", :id => "close_flash", :style => "position:absolute; right:5px;")), :id => "flash", :class => "flash-#{level}", :style => "position:relative;"
  end

def link_to(*args, &block)
  if block_given?
    options      = args.first || {}
    html_options = args.second
    concat(link_to(capture(&block), options, html_options))
  else
    name         = args.first
    options      = args.second || {}
    html_options = args.third

    url = url_for(options)

    if html_options
      html_options = html_options.stringify_keys
      href = html_options['href']
      convert_options_to_javascript!(html_options, url)
      tag_options = tag_options(html_options)
    else
      tag_options = nil
    end

    format = '.html'
    href_attr = "href=\"#{url}\"" unless href
    "<a #{href_attr}#{tag_options}>#{name || url}</a>".html_safe
  end
end




end

