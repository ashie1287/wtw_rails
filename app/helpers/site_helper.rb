module SiteHelper
  IMAGE_REGEX = /\.(jpg|png|gif)$/

  def render_menu
    menu_items = ActiveSupport::OrderedHash.new
    
    menu_items['Home'] = home_path
    %w(About Seniors Sponsors Donate Contact).each do |page|
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

  def render_last_events
    render('site/events')
  end

  def duration(event)
    if !event.start_time.blank? && !event.end_time.blank?
      distance_of_time_in_words(event.start_time, event.end_time)
    end
  end

  def event_links(event)
    links = []
    links << link_to('Details', event_path(event))
    if event.allow_signup? && (event.start_time.blank? || event.start_time > Time.zone.now)
      links << link_to('Sign Up!', signup_event_path(event))
    end
    links.join(' | ')
  end

  def render_flash
    unless notice.blank?
      render('site/flash')
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
end
