class TelsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_tel, only: [:show, :edit]

  def index
    @tels = current_user.tels.order("updated_at desc")
  end

  def show
    if @tel.twilio_phone == nil
      flash['notice'] = '電話番号を選択してください。'
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
    @tel = Tel.new(tel_param)
    @tel.users << current_user
    current_user.user_tel(@tel.id).role = 30
    if @tel.save && current_user.save
      flash['notice'] = 'やった！新しい電話が生成されました。電話番号を選択してください。'
      redirect_to new_tel_twilio_phone_url(@tel)
    else 
      render :new
    end
  end

  def update
    p params
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
