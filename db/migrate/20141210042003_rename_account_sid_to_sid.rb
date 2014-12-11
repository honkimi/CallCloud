class RenameAccountSidToSid < ActiveRecord::Migration
  def change
    rename_column :twilio_phones, :account_sid, :sid
  end
end
