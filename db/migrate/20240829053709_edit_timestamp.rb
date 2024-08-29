class EditTimestamp < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :created_at, :datetime 
  end
end
