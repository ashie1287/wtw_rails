module SiteHelper
  def render_menu
    menu_hash = ActiveSupport::OrderedHash.new
    
=begin
                      'Causes'      => url_for(:controller => 'site', :action => 'causes'),
                      'Fundraising' => url_for(:controller => 'site', :action => 'fundraising'),
                      'Sponsors'    => url_for(:controller => 'site', :action => 'sponsors'),
                      'About'       => url_for(:controller => 'site', :action => 'about'),
                      'Contact'     => url_for(:controller => 'site', :action => 'contact')
=end
    menu_hash['Home'   ] = home_path
    menu_hash['About'  ] = about_path
    menu_hash['Contact'] = contact_path

    render(:partial => 'site/menu', :locals => {:menu_items => menu_hash})
  end

  def render_last_events
    render(:partial => 'site/events')
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
      render(:partial => 'site/flash')
    end
  end
end
