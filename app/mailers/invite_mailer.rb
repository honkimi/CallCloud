class InviteMailer < ActionMailer::Base
  default from: "info@callcloud.com"

  def welcome user
    @user = user
  end
end
