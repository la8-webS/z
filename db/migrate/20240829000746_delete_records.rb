class DeleteRecords < ActiveRecord::Migration[6.1]
  def change
    drop_table :accounts
  end
end
