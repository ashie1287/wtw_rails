class Team < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name, :case_sensitive => false, :scope => :event_id
  belongs_to :event
  has_many :user_event_teams
  has_many :users, :through => :user_event_teams
end
