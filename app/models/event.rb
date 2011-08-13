class Event < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name, :scope => [:start_time, :end_time]
  has_many :user_events
  has_many :attendees, :class_name => User, :through => :user_events
  has_many :teams
end
