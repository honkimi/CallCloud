class TwilioController < ApplicationController
  protect_from_forgery with: :null_session

  def welcome
    @tel = Tel.find(params[:tel_id])
    raise if @tel.nil?

    say_word = @tel.first_msg
    say_word << @tel.get_first_action_message()

    xml_str = Twilio::TwiML::Response.new do |r|
      r.Gather timeout: 30, finishOnKey: '#', action: action_url(@tel), method: 'GET' do |gather|
        gather.Say say_word, language: "ja-jp"
      end
    end.text

    render xml: xml_str
  end

  def action
    @tel = Tel.find(params[:tel_id])
    xml_str = Twilio::TwiML::Response.new do |r|
#      begin
        raise if @tel.nil?
        say_word = @tel.get_second_action_message(params[:Digits])

        if say_word =~ /^[\+0-9]+$/
          # tel number
          r.Dial :callerId => @tel.twilio_phone.number do |d|
            d.Number TwilioClient.to_i18n_number(say_word)
          end
        else
          # say
          r.Gather timeout: 30, finishOnKey: '#', action: action_url(@tel.id, params[:Digits]), method: 'GET' do |gather|
            gather.Say say_word, language: "ja-jp"
          end
        end
#      rescue => e
#        p e.message
#        r.Say "正しい入力が確認できませんでした。", language: "ja-jp"
#        r.Redirect welcome_url(@tel), method: 'GET'
#      end
    end.text
    render xml: xml_str
  end

  def action2 
    @tel = Tel.find(params[:tel_id])
    xml_str = Twilio::TwiML::Response.new do |r|
      begin
        r.Dial :callerId => @tel.twilio_phone.number do |d|
          d.Number TwilioClient.to_i18n_number(@tel.get_second_action_phone_number(params[:action_id], params[:Digits]))
        end
      rescue => e
        p e.message
        r.Say "正しい入力が確認できませんでした。", language: "ja-jp"
        r.Redirect welcome_url(@tel), method: 'GET'
      end
    end.text
    render xml: xml_str
  end
end
