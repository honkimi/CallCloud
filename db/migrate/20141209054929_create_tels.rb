class CreateTels < ActiveRecord::Migration
  def change
    create_table :tels do |t|
      t.string :organize_name
      t.string :base_tel_bumber
      t.string :first_msg
      t.boolean :is_record, default: true
      t.text :sheet

      t.timestamps
    end
  end
end
