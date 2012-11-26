class Task < ActiveRecord::Base

  after_validation do
    self.sms_reminder = self.sms_reminder.gsub!(/\D/,"")
  end

  attr_accessible :completed, :description, :list_id, :priority, :due_at, :tag, :sms_reminder

  validates :description, :length => { :in => 3..30}
  validates :priority, :inclusion => { :in => %w(low high), :message => "must select high or low"}
  validates :sms_reminder, :inclusion => { :in => ["5 hours", "3 hours", "1 hour"], :message => "must SMS reminder"}
  validates :tag, presence: :true
  # validate :sms_frequency_must_be_before_due_at

  belongs_to :list

  scope :complete, where(:completed => true)
  scope :incomplete, where(:completed => false)


  def self.for_list(list)
      where(:list_id => list.id)
  end

  # def sms_frequency_must_be_before_due_at
  #   self.sms_frequency = self.sms_frequency.gsub!(/\D/,"")
  #   errors.add(:sms_frequency, "too few hours until due date") if (self.due_at - Time.now) < (self.sms_frequency.to_i * 3600)
  # end

end
