class AddVoiceTypeToTel < ActiveRecord::Migration
  def change
    add_column :tels, :voice_type, :string, :null => false, :default => "woman"
  end
end
