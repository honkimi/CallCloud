class InvitesController < ApplicationController
  before_action :authenticate_user!

  def index
    invites = Invite.joins(:user, :tel).where("to_email = ? and status = ?", current_user.email, 0)

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
      flash[:notice] = I18n.t("invite.success")
      redirect_to tels_url
    rescue => e
      flash[:alert] = I18n.t("invite.failed")
      redirect_to edit_invite_url(invite)
  end
end
