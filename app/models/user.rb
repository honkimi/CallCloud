class User < ActiveRecord::Base
  has_many :user_tels
  has_many :tels, :through => :user_tels
  has_many :invites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :confirmable,
         :trackable, 
         :validatable

  def user_tel(tel_id)
    UserTel.find_by_user_id_and_tel_id(self[:id], tel_id)
  end
end
