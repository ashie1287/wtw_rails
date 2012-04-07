module SiteHelper
  IMAGE_REGEX = /\.(jpg|png|gif)$/

  def render_menu
    menu_items = ActiveSupport::OrderedHash.new
    
    menu_items['Home'] = home_path
    %w(About Causes Sponsors Donate Contact).each do |page|
      menu_items[page] = site_path(page.downcase)
    end

    render('site/menu', :menu_items => menu_items)
  end

  def render_fancybox_gallery(image_dir)
    images = Dir.entries(File.join('public', 'images', *image_dir)).grep(IMAGE_REGEX)
    src = ['', 'images', *image_dir].join('/')
    render(:partial => 'site/fancybox_image',
           :collection => images.sort_by(&:to_i),
           :as => :image,
           :locals => {:src => src,
                       :rel => image_dir.join('_')})
  end

  def duration(event)
    if !event.start_time.blank? && !event.end_time.blank?
      distance_of_time_in_words(event.start_time, event.end_time)
    end
  end

  def render_notice
    unless notice.blank?
      render(:partial => 'shared/notice', :locals => {:notice => notice})
    end
  end

  def render_slider_images(image_dir)
    images = Dir.entries(File.join('public', 'images', *image_dir)).grep(IMAGE_REGEX)
    src = ['', 'images', *image_dir].join('/')
    images.map {|image|
      img = [src, image].join('/')
      image_tag(img)
    }.join.html_safe
  end

  def article_excerpt(article, length = 200)
    text = strip_tags(article.body).gsub(/&nbsp;/i,"")
    text = truncate(text, :length => length, :seperator => ' ', :omission => '')
    link = link_to('[...]', article_path(article))
    raw("#{text} #{link}")
  end

  def article_info(article)
    "By #{article.author} on #{article.created_at.strftime('%b %d at %I:%M %p')}"
  end
end
