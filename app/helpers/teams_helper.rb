module TeamsHelper

  def render_user_views_for(team)
    render(:partial => 'teams/view_user', :collection => team.users, :as => :user)
  end
end
