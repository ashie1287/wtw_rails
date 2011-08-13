class User < ActiveRecord::Base
  validates_presence_of   :name
  validates_presence_of   :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates_format_of     :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :allow_nil => true

  has_many :user_events
  has_many :events, :through => :user_events
  has_many :user_teams
  has_many :teams, :through => :user_teams
end
