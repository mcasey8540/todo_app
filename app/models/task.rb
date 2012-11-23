class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :priority, :due_at, :tag

  validates :description, :length => { :in => 3..30}
  #validate :due_date_must_be_today_or_later
  validates :priority, :inclusion => { :in => %w(low high), :message => "must select high or low"}  


  belongs_to :list

  scope :complete, where(:completed => true)
  scope :incomplete, where(:completed => false)

  # def self.sorted_by(option)
  # 	case option
  # 	when "sort_low"    then order("completed, priority DESC")
  # 	when "sort_high"   then order("completed, priority")
  # 	when "completed"   then order("completed DESC")
  #   when "incomplete"  then order("completed")
  #   else                self.all
  #   end
  # end

  # def self.for_list(list)
  # 	where(:list_id => list.id)
  # end

  def self.for_list(list)
      where(:list_id => list.id)
  end

  # def due_date_must_be_today_or_later
  #   errors.add(:due_at, "Must be after today") if due_at < Date.today
  # end

end
