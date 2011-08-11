module SiteHelper
  def render_menu
    menu_hash = {
                  'Home'        => url_for(:action => 'index'),
=begin
                  'Causes'      => url_for(:action => 'causes'),
                  'Fundraising' => url_for(:action => 'fundraising'),
                  'Sponsors'    => url_for(:action => 'sponsors'),
                  'About'       => url_for(:action => 'about'),
                  'Contact'     => url_for(:action => 'contact')
=end
                  'Causes'      => '#',
                  'Fundraising' => '#',
                  'Sponsors'    => '#',
                  'About'       => '#',
                  'Contact'     => '#'
                }

    render(:partial => 'menu', :locals => {:menu_items => menu_hash})
  end
end
