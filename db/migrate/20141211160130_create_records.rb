class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :tel, index: true, null: false
      t.string :from
      t.string :voice_url
      t.string :duration

      t.timestamps
    end
  end
end
