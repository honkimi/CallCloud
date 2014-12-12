class Invite < ActiveRecord::Base
  belongs_to :tel
  belongs_to :user
end
