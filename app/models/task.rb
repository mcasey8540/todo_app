class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :priority

  validates :description, :length => { :minimum => 3} 

  belongs_to :list

  scope :complete, where(:completed => true)
  scope :incomplete, where(:completed => false)

  def self.sorted_by(option)
  	case option
  	when "sort_low"    then order("completed, priority DESC")
  	when "sort_high"   then order("completed, priority")
  	when "completed"   then order("completed DESC")
    when "incomplete"  then order("completed")
    else                self.all
    end
  end

  def self.for_list(list)
  	where(:list_id => list.id)
  end
end
