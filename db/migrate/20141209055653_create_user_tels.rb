class CreateUserTels < ActiveRecord::Migration
  def change
    create_table :user_tels do |t|
      t.references :user, index: true, null: false
      t.references :tel, index: true, null: false

      t.boolean :is_notify, default: true

      t.timestamps
    end
  end
end
