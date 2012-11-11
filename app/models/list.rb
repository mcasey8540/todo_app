class List < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name, :description, :presence => true 

  has_many :tasks
end
