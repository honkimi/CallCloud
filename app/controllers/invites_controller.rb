class InvitesController < ApplicationController
  before_action :authenticate_user!

  def index
    invites = Invite.joins(:user, :tel).where("to_email = ? and status = ?", current_user.email, 0)

    # どうにかしたい...
    # JOINしたのをそのまま突っ込めばいいだけなのに.
    # 助けて〜
    res = []
    invites.each do |i|
      touple = {}
      touple["user"] = i.user
      touple["tel"] = i.tel
      touple["invite"] = i
      res << touple
    end
    render json: res
  end

  def edit
    @invite = Invite.find(params[:id])
    @tel = @invite.tel
  end

  def update
    invite = Invite.find(params[:id])
    ActiveRecord::Base.transaction do
      UserTel.create!({
        user_id: current_user.id, 
        tel_id: invite.tel_id,
        role: 20
      })
      invite.status = 1
      invite.save!
    end
      flash[:notice] = "やった！組織の参加に成功しました。"
      redirect_to tels_url
    rescue => e
      flash[:alert] = "おっと、組織の参加に失敗しました。"
      redirect_to edit_invite_url(invite)
  end
end
