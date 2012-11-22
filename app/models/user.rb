class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :id, :email, :password, :password_confirmation, :remember_me, :phone_number
  # attr_accessible :title, :body

  has_many :lists

  Roles = [:admin, :non_admin]

  def is?(requested_role)
  	self.role == requested_role.to_s
  end

end
