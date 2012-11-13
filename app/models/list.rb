class List < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name, :description, :presence => true 

  has_many :tasks, :order => :priority

  def sorted_tasks(option)
  	case option
  	when "sort_high"
  		tasks.all(:order => "priority DESC")
  	else
  		tasks.all(:order => "priority")
  	end
  end
end
