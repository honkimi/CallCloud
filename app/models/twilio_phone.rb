class TwilioPhone < ActiveRecord::Base
  belongs_to :tel

  def set_number number
    self.number = number.phone_number
    self.friendly_name = TwilioClient.jap_number(number.phone_number)
    self.sid = number.sid
    self.voice_url = number.voice_url
  end
end
