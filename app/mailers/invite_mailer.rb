class InviteMailer < ActionMailer::Base
  default from: "info@callcloud.com"

  def welcome user, to_email
    @user = user

    mail to: to_email, subject: "コールクラウドより招待が届いています。"
  end
end
