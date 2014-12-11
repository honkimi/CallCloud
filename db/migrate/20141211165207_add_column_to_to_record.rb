class AddColumnToToRecord < ActiveRecord::Migration
  def change
    add_column :records, :to, :string
  end
end
