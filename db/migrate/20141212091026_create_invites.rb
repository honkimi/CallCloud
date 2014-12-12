class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :to_email, :null => false, :default => ""
      t.integer :status, :default => 0, :null => false

      t.references :tel, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end

    add_index :invites, [:to_email, :status], :unique => true
  end
end
