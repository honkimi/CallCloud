class Tel < ActiveRecord::Base
  has_many :user_tels
  has_many :records
  has_many :users, :through => :user_tels
  has_one :twilio_phone
  has_many :invite

  def get_first_action_message
    json = JSON.parse(self.sheet)
    str = ""
    json['actions'].each do |action|
      str << action['name']
      str << 'へのお問い合わせは'
      str << han_to_zen(action['number'])
      str << 'とシャープを、'
    end
    str << '入力してください。'
    str
  end

  def get_second_action_message idx
    json = JSON.parse(self.sheet)
    str = ""
    return json['actions'][idx]['action'] if json['actions'][idx]['action'] != "--"

    json['actions'][idx]['children'].each do |action|
      str << action['name']
      str << 'へのお問い合わせは'
      str << han_to_zen(action['number'])
      str << 'とシャープを、'    
    end
    str << '入力してください。'
    str
  end

  def get_second_action_phone_number first, second
    json = JSON.parse(self.sheet)
    return json['actions'][first]['children'][second]['action']
  end

  private
  def han_to_zen num
    Moji.han_to_zen(num.to_s.encode('UTF-8', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  end
end
