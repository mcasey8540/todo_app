class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :id, :email, :password, :password_confirmation, :remember_me, :phone_number

  validates :phone_number, :format => { :with => /^\d{10}$/,
  :message => "must be 10 digits" }
  validates_uniqueness_of :phone_number


  before_validation :phone_number_format

  has_many :lists

  Roles = [:admin, :non_admin]

  def is?(requested_role)
  	self.role == requested_role.to_s
  end

  protected 

  def phone_number_format
    self.phone_number = phone_number.to_s.gsub(/-/,"") 
  end

end
