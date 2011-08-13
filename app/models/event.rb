class Event < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name, 
                            :case_sensitive => false,
                            :scope => [:start_time, :end_time]
  validate :end_is_after_start

  has_many :user_events

  has_many :attendees,
             :class_name => User,
             :through => :user_events

  has_many :teams

  private

  def end_is_after_start
    if start_time && end_time && start_time > end_time
      errors.add_to_base("Start Time must be before End Time")
    end
  end
end
