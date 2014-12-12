class TwilioClient
  attr_reader :client

  def initialize
    @client = get_client()
  end

  def get_available_tels
    tels = []
    @client.account.incoming_phone_numbers.list.each do |number|
      if number.friendly_name != "ConnexiSMS" and number.voice_url =~ /demo.twilio.com/
        tel_hash = {}
        tel_hash["number"] = TwilioClient.jap_number(number.phone_number)
        tel_hash["sid"] = number.sid
        tels.push(tel_hash) 
      end
    end
    tels
  end

  def set_voice_url sid, voice_url
    number = @client.account.incoming_phone_numbers.get(sid)
    number.update(
      :voice_url => voice_url,
      :VoiceMethod => "GET"
    )
  end

  def self.jap_number number
    number.sub("+81","0").gsub(/-/, "")
  end

  def self.to_i18n_number tel
    tel.sub(/^0/, "+81").gsub(/-/, "")
  end

  private
  def get_client
    Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN'] 
  end
end
