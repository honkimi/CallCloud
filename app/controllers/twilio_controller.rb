class TwilioController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :fetch_tel

  def welcome
    raise if @tel.nil?

    say_word = @tel.first_msg
    say_word << @tel.get_first_action_message()

    xml_str = Twilio::TwiML::Response.new do |r|
      r.Gather timeout: 60, finishOnKey: '#', action: action_url(@tel), method: 'GET' do |gather|
        gather.Say say_word, language: "ja-jp"
      end
    end.text

    render xml: xml_str
  end

  def action
    xml_str = Twilio::TwiML::Response.new do |r|
      begin
        raise if @tel.nil?
        say_word = @tel.get_second_action_message(params[:Digits].to_i - 1)
        if say_word =~ /^[\+0-9-]+$/
          # tel number
          r.Dial :callerId => @tel.twilio_phone.number, :record => @tel.is_record, :action => tel_records_url(@tel, to: say_word) do |d|
            d.Number TwilioClient.to_i18n_number(say_word)
          end
        else
          # say
          r.Gather timeout: 60, finishOnKey: '#', action: action2_url(@tel.id, params[:Digits].to_i - 1), method: 'GET' do |gather|
            gather.Say say_word, language: "ja-jp"
          end
        end
      rescue => e
        p e.message
        r.Say "正しい入力が確認できませんでした。", language: "ja-jp"
        r.Redirect welcome_url(@tel), method: 'GET'
      end
    end.text
    render xml: xml_str
  end

  def action2 
    xml_str = Twilio::TwiML::Response.new do |r|
      begin
        raise if @tel.nil?
        tel_num = @tel.get_second_action_phone_number(params[:action_id].to_i, params[:Digits].to_i - 1)
        r.Dial :callerId => @tel.twilio_phone.number, :record => @tel.is_record, :action => tel_records_url(@tel, to: tel_num) do |d|
          d.Number TwilioClient.to_i18n_number(tel_num)
        end
      rescue => e
        p e.message
        r.Say "正しい入力が確認できませんでした。", language: "ja-jp"
        r.Redirect welcome_url(@tel), method: 'GET'
      end
    end.text
    render xml: xml_str
  end

  private
  def fetch_tel
    @tel = Tel.find(params[:tel_id])
  end

end
