module SiteHelper
  def render_menu
    menu_hash = {
                  'Home'        => home_path,
=begin
                  'Causes'      => url_for(:controller => 'site', :action => 'causes'),
                  'Fundraising' => url_for(:controller => 'site', :action => 'fundraising'),
                  'Sponsors'    => url_for(:controller => 'site', :action => 'sponsors'),
                  'About'       => url_for(:controller => 'site', :action => 'about'),
                  'Contact'     => url_for(:controller => 'site', :action => 'contact')
=end
                  'About'       => about_path,
                  'Contact'     => contact_path
                }

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
    links << link_to('Sign Up!', signup_event_path(event))
    links.join(' | ')
  end
end
