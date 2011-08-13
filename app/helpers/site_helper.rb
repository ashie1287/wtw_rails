module SiteHelper
  def render_menu
    menu_hash = {
                  'Home'        => url_for(:controller => 'site', :action => 'index'),
=begin
                  'Causes'      => url_for(:controller => 'site', :action => 'causes'),
                  'Fundraising' => url_for(:controller => 'site', :action => 'fundraising'),
                  'Sponsors'    => url_for(:controller => 'site', :action => 'sponsors'),
                  'About'       => url_for(:controller => 'site', :action => 'about'),
                  'Contact'     => url_for(:controller => 'site', :action => 'contact')
=end
                  'Causes'      => '#',
                  'Fundraising' => '#',
                  'Sponsors'    => '#',
                  'About'       => '#',
                  'Contact'     => '#'
                }

    render(:partial => 'site/menu', :locals => {:menu_items => menu_hash})
  end

  def render_last_events
    render(:partial => 'site/events')
  end

  def event_times(event)
    concat(content_tag(:span, "Start Time: #{event.start_time}", :class => 'event-start')) if event.start_time
    if event.start_time && event.end_time
      concat(content_tag(:span, "End Time: #{event.end_time}", :class => 'event-end'))
      concat(content_tag(:span, "Duration: #{distance_of_time_in_words(event.start_time, event.end_time)}", :class => 'event-duration'))
    end
  end
end
