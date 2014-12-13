class MembersController < ApplicationController
  before_action :fetch_tel
  before_action :authenticate_user!

  def index
    @user_tels = UserTel.where(:tel_id => @tel.id)
    @users = User.find(@user_tels.map(&:user_id))
    @my_user_tel = UserTel.find_by_user_id_and_tel_id(current_user.id, @tel.id)

    render layout: false
  end

  def new
    @invite = Invite.new
  end

  def create
    begin 
      member_from_mail = @tel.users.where(email: invite_param[:to_email])
      raise I18n.t("member.already") unless member_from_mail.empty?
      invite = Invite.find_by_to_email_and_tel_id(invite_param[:to_email], @tel.id)
      raise I18n.t("member.invited") unless invite.nil?

      invite = Invite.new(invite_param)
      invite.tel_id = @tel.id
      invite.user_id = current_user.id
      invite.save!
      # send mail if he not joined this service
      invited = User.find_by_email(invite_param[:to_email])
      InviteMailer.welcome(current_user, invite_param[:to_email]).deliver if invited.nil?

      flash[:notice] = I18n.t("member.success")
    rescue => e
      flash[:alert] = e.message
    end
    @invite = Invite.new
    render action: :new
  end

  def update
    @user_tel = UserTel.find(params[:id])
    res_j = {}
    if @user_tel.update_attributes!(user_tel_param)
      res_j["status"] = "ok"
    else 
      res_j["status"] = "ng"
    end
    res_j["idx"] = params[:idx]
    res_j["role"] = self.class.helpers.role(@user_tel)
    render json: res_j
  end

  private
  def fetch_tel
    @tel = Tel.find(params[:tel_id])
  end

  def user_tel_param
    params.require(:user_tel).permit(:role)
  end

  def invite_param
    params.require(:invite).permit(:to_email)
  end
end
