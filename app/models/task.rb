class Task < ActiveRecord::Base

  attr_accessible :completed, :description, :list_id, :priority, :due_at, :tag, :sms_reminder
  belongs_to :list

  validates :description, :length => { :in => 3..30}
  validates :priority, :inclusion => { :in => %w(low high), :message => "must select high or low"}
  #validates :sms_reminder, :inclusion => { :in => ["5 hours", "3 hours", "1 hour"], :message => "must SMS reminder"}
  validates :tag, presence: :true

  def self.for_list(list)
    where(:list_id => list.id)
  end

  def self.complete_task(task_id)
    task = find(task_id)
    task.completed? ? task.completed = false : task.completed = true
    task.save
  end

  

end
