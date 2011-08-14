class Event < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name, 
                            :case_sensitive => false,
                            :scope => [:start_time, :end_time]

  validate :start_must_be_in_the_future
  validate :end_is_after_start

  has_many :user_events

  has_many :attendees,
             :class_name => User,
             :through => :user_events

  has_many :teams

  named_scope :without_image, :select => "#{(self.column_names - ['image']).join(',')}"

  before_save :set_image_data

  private

  def set_image_data
    if self.image.is_a?(ActionDispatch::Http::UploadedFile)
      self.image = self.image.tempfile.read
    end
  end

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
end
