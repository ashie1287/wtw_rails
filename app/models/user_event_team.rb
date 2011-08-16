class UserEventTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :team

  validates_presence_of :user, :event
end
