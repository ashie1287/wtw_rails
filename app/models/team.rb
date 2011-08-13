class Team < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name, :scope => :event_id
  belongs_to :event
  has_many :user_teams
  has_many :members, :class_name => User, :through => :user_teams
end
