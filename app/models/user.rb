class User < ActiveRecord::Base
  validates_presence_of   :name
  validates_presence_of   :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates_format_of     :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :allow_nil => true
  has_many :user_event_teams, :dependent => :destroy
  has_many :events, :through => :user_event_teams
  has_many :teams,  :through => :user_event_teams

  def register_for(event, team = nil)
    uet = UserEventTeam.find_by_user_id_and_event_id(self.id, event.id)

    unless uet
      uet = UserEventTeam.create!(:user => self, :event => event, :team => team)
    end

    if uet.team.blank? && !team.blank?
      uet.team = team
      uet.save!
    end

    uet
  end
end
