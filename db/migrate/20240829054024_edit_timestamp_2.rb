class EditTimestamp2 < ActiveRecord::Migration[6.1]
  def change
    change_table(:posts) { |t| t.timestamps }
  end
end
