class Event < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name, :case_sensitive => false, :scope => [:start_time, :end_time]

  validate :start_must_be_in_the_future
  validate :end_is_after_start
  validate :teams_cant_be_allowed_without_signup

  has_many :user_event_teams, :dependent => :destroy
  has_many :users, :through => :user_event_teams
  has_many :teams, :dependent => :destroy

  has_attached_file :image, :styles => { :thumb => "100x100>" },
                            :default_url => '/images/noimage.gif'

  after_save  :destroy_teams_and_uets

  def remove_image
    self.image = nil
    self.save!
  end

  private

  def end_is_after_start
    if self.start_time && self.end_time && self.start_time > self.end_time
      self.errors.add(:base, "Start Time must be before End Time")
    end
  end

  def start_must_be_in_the_future
    if self.start_time && self.start_time < Time.zone.now
      self.errors.add(:base, "Start Time must be in the future")
    end
  end

  def teams_cant_be_allowed_without_signup
    if self.allow_teams? && !self.allow_signup
      self.errors.add(:base, "Signup must be allowed if teams are allowed")
    end
  end

  def destroy_teams_and_uets
    self.teams.destroy_all unless self.allow_teams?
    self.user_event_teams.destroy_all unless self.allow_signup?
  end
end
