class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :priority

  validates :description, :presence => true

  belongs_to :list

  scope :complete, where(:completed => true)
  scope :incomplete, where(:completed => false)

  def self.sorted_by(option)
  	case option
  	when "sort_low"
  		order("priority DESC")
  	else
  		order("priority")
  	end
  end

  def self.for_list(list)
  	where(:list_id => list.id)
  end
end
