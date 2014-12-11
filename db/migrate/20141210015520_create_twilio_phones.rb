class CreateTwilioPhones < ActiveRecord::Migration
  def change
    create_table :twilio_phones do |t|
      t.string :number, :null => false
      t.string :friendly_name, :null => false
      t.string :account_sid, :null => false
      t.string :voice_url, :null => false
      t.string :voice_fallback_url
      t.references :tel, index: true

      t.timestamps
    end
  end
end
