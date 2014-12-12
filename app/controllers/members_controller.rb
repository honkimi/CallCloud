class MembersController < ApplicationController
  before_action :fetch_tel

  def index
    @user_tels = UserTel.where(:id => @tel.id)
    @users = User.find(@user_tels.map(&:user_id))
    p @user_tels

    render layout: false
  end

  def new

  end

  def create

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
end
