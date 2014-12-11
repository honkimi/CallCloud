class User < ActiveRecord::Base
  has_many :user_tels
  has_many :tels, :through => :user_tels
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :confirmable,
         :trackable, 
         :validatable
end
