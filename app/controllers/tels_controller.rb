class TelsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_tel, only: [:show, :edit]

  def index
    @tels = current_user.tels.order("updated_at desc")
  end

  def show
    if @tel.twilio_phone == nil
      flash['notice'] = I18n.t('tel.select')
      redirect_to new_tel_twilio_phone_url(@tel, redirected: true)
    else 
      @user_tel = current_user.user_tel(@tel.id)
      render :layout => false
    end
  end

  def edit 
    render :layout => false
  end

  def new
    @tel = Tel.new
  end

  def create
    begin 
      @tel = Tel.new(tel_param)
      @tel.users << current_user
      @tel.save!
      usertel = current_user.user_tel(@tel.id)
      usertel.role = 30
      usertel.save!
      flash['notice'] = I18n.t('tel.created')
      redirect_to new_tel_twilio_phone_url(@tel)
    rescue => e
      render :new
    end
  end

  def update
    @tel = Tel.find(params[:id])
    if @tel.update_attributes(tel_param)
      render json: @tel, status: 200
    else 
      render json: @tel, status: 400
    end
  end

  private
  def tel_param
    params.require(:tel).permit(:organize_name, :base_tel_bumber, :first_msg, :is_record, :voice_type)
  end

  def fetch_tel
    @tel = Tel.find(params[:id])
  end
end
