class UserTel < ActiveRecord::Base
  belongs_to :user
  belongs_to :tel
end
