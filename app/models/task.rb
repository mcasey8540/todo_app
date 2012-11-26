class Task < ActiveRecord::Base

  after_validation do
    self.sms_frequency = self.sms_frequency.gsub!(/\D/,"")
  end

  attr_accessible :completed, :description, :list_id, :priority, :due_at, :tag, :sms_frequency

  validates :description, :length => { :in => 3..30}

  validates :priority, :inclusion => { :in => %w(low high), :message => "must select high or low"}
  validates :sms_frequency, :inclusion => { :in => ["5 hours", "3 hours", "1 hour"], :message => "must select 5, 3 or 1 hours"}
  validates :tag, presence: :true

  belongs_to :list

  scope :complete, where(:completed => true)
  scope :incomplete, where(:completed => false)


  def self.for_list(list)
      where(:list_id => list.id)
  end

end
