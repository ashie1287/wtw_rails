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
end
