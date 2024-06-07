class AddDailyRecordIdToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :daily_record_id, :bigint
  end
end
