class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :list_id, :priority

  validates :description, :presence => true

  belongs_to :list

  scope :complete, where(:completed => true)
  scope :incomplete, where(:completed => false)


end
