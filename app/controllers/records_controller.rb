class RecordsController < ApplicationController
  protect_from_forgery :except => :create, :only => [:create]

  def index
    @tel = Tel.find(params[:tel_id])
    @records = @tel.records

    render layout: false
  end

  def create
    @tel = Tel.find(params[:tel_id])
    begin
      raise if @tel.nil?
      record = Record.new
      record.from = TwilioClient.jap_number(voice_params[:From])
      record.to = TwilioClient.jap_number(voice_params[:To])
      record.voice_url = voice_params[:RecordingUrl]
      record.duration = voice_params[:DialCallDuration]
      @tel.records << record
      @tel.save!
    rescue => e
      p e.message
    end

    xml_str = Twilio::TwiML::Response.new do |r|
      r.Say "通話を終了します。", language: "ja-jp"
      r.Hangup
    end.text
    render xml: xml_str
  end

  private
  def voice_params
    params.permit(:From, :To, :RecordingUrl, :DialCallDuration)
  end
end
