class Task < ActiveRecord::Base

  attr_accessible :completed, :description, :list_id, :priority, :due_at, :tag, :sms_reminder, :iw_schedule_id
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

  def self.schedule_sms(task, current_user)
    unless task.sms_reminder.nil? 
      d = task.due_at.to_s
      time = Time.new(d[0..3],d[5..6],d[8..9]) - (3600 * task.sms_reminder.to_i )
      @iw = IronWorkerNG::Client.new
      @iw.schedules.create("sms", 
                      {
                      description: task.description, 
                      sms_reminder: task.sms_reminder, 
                      due_at: task.due_at.to_date, 
                      to: current_user.phone_number,
                      },  
                       {
                           #This is the schedule
                           :start_at => time,
                           #:start_at => task.due_at - (3600 * task.sms_frequency.to_i),
                           :run_times => 1,
                           #:end_at => Time.now + 180
                       })
    end
  end

  def self.cancel_sms_reminder(task, current_user)
    client = IronWorkerNG::Client.new
    client.schedules.list.each do |s| 
      if s.payload.include?(task.description) and s.payload.include?(current_user.phone_number)
        client.schedules.cancel(s.id)
      end
    end
  end

end
