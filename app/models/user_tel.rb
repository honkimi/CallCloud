class UserTel < ActiveRecord::Base
  belongs_to :user
  belongs_to :tel

  # role: {
  #   guest: 10, 
  #   writer: 20, 
  #   admin: 30
  # }
end

