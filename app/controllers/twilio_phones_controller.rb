class TwilioPhonesController < ApplicationController
  before_action :authenticate_user!
  before_action :init_twilio, only: [:index, :create]
  before_action :tel_get, only: [:new, :create]

  def index
    render json: @twilio.get_available_tels
  end

  def new 
    @twilio_phone = TwilioPhone.new
    render layout: false if params[:redirected]
  end

  def create
    sid = params["twilio_phone"]["sid"]
    begin
      url = Rails.env == "production" ? welcome_url(@tel) : "https://callcloud.herokuapp.com" + welcome_path(@tel)
      number = @twilio.set_voice_url(sid, url)
      
      @twilio_phone = TwilioPhone.new
      @twilio_phone.set_number(number)
      @tel.twilio_phone = @twilio_phone
      @tel.save!
      flash['notice'] = 'Yay! Your tel was created. '
      redirect_to tels_url
    rescue => e
      flash['alert'] = e.message
      redirect_to new_tel_twilio_phone_url(@tel)
    end
  end
    
  private
  def init_twilio
    @twilio = TwilioClient.new
  end

  def tel_get
    @tel = Tel.find(params[:tel_id])
  end
end
